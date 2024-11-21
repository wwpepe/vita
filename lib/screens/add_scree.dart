import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // 캐릭터 리스트 상태
  final List<Map<String, String>> _characters = [];

  // 새 캐릭터 추가 메서드
  void _addCharacter(String name, String personality) {
    setState(() {
      _characters.add({
        'name': name,
        'personality': personality,
        'imageUrl': 'https://via.placeholder.com/100', // 기본 이미지 URL
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
                  _addCharacter(result['name'], result['personality']);
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

  const CharacterCard({
    Key? key,
    required this.name,
    required this.personality,
    required this.imageUrl,
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
            radius: 30,
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

  void _saveCharacter() {
    final name = _nameController.text.trim();
    final personality = _personalityController.text.trim();

    if (name.isNotEmpty && personality.isNotEmpty) {
      Navigator.pop(context, {'name': name, 'personality': personality});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
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
