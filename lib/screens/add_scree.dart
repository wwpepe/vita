import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:math';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // 캐릭터 리스트 상태
  final List<Map<String, dynamic>> _characters = [];

  // 새 캐릭터 추가 메서드
  void _addCharacter(String name, String personality, String imageUrl, String audioPath) {
    setState(() {
      _characters.add({
        'name': name,
        'personality': personality,
        'imageUrl': imageUrl,
        'audioPath': audioPath,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black,
            hintText: 'Search...',
            hintStyle: const TextStyle(color: Colors.white),
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 캐릭터 그리드
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 한 행에 3개의 아이템
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _characters.length,
                itemBuilder: (context, index) {
                  final character = _characters[index];
                  return CharacterCard(
                    name: character['name']!,
                    personality: character['personality']!,
                    imageUrl: character['imageUrl']!,
                    audioPath: character['audioPath'],
                  );
                },
              ),
            ),
            // 추가 버튼
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCharacterScreen(),
                  ),
                );
                if (result != null) {
                  _addCharacter(result['name'], result['personality'], result['imageUrl'], result['audioPath']);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBBF246),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Add Character',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final String name;
  final String personality;
  final String imageUrl;
  final String? audioPath;

  const CharacterCard({
    Key? key,
    required this.name,
    required this.personality,
    required this.imageUrl,
    this.audioPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBBF246), width: 2),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 40,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            personality,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (audioPath != null)
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                FlutterSoundPlayer().startPlayer(fromURI: audioPath!);
              },
            ),
        ],
      ),
    );
  }
}

class AddCharacterScreen extends StatefulWidget {
  @override
  _AddCharacterScreenState createState() => _AddCharacterScreenState();
}

class _AddCharacterScreenState extends State<AddCharacterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _personalityController = TextEditingController();
  XFile? _selectedImage;

  FlutterSoundRecorder? _recorder;
  String? _audioPath;

  final List<String> _randomSentences = [
    "엄마가 지켜 보고있다 졸지마라 그러다 골로 간다.",
    //이곳에 챗봇이 생성한 대화 넣어야 함
  ];

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _recorder!.openRecorder();
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _startRecording() async {
    _audioPath = '/path/to/recorded/audio.aac';
    await _recorder!.startRecorder(toFile: _audioPath);
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
  }
//저장 메소드
  void _saveCharacter() {
    final name = _nameController.text.trim();
    final personality = _personalityController.text.trim();

    if (name.isNotEmpty && personality.isNotEmpty && _selectedImage != null && _audioPath != null) {
      final randomSentence = (_randomSentences..shuffle()).first;
      FlutterTts().speak(randomSentence);
      Navigator.pop(context, {
        'name': name,
        'personality': personality,
        'imageUrl': _selectedImage!.path,
        'audioPath': _audioPath,//여기 수정해야함 저장시 음성 출력됨 -> 홈으로 옮기기
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Character'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Character Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter character name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Personality',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _personalityController,
              decoration: InputDecoration(
                hintText: 'Enter personality',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Profile Picture',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[200],
                backgroundImage: _selectedImage != null
                    ? FileImage(File(_selectedImage!.path))
                    : null,
                child: _selectedImage == null
                    ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Record Voice',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _startRecording,
                  child: const Text('Start Recording'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _stopRecording,
                  child: const Text('Stop Recording'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveCharacter,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBBF246),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
