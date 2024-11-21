import 'package:flutter/material.dart';
import 'package:test111/api/DeepSearhApi.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({Key? key}) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  final DeepSearchApi _api = DeepSearchApi();
  late Future<List<Map<String, String>>> _newsData;

  @override
  void initState() {
    super.initState();
    // API에서 뉴스 데이터를 가져옴
    _newsData = _api.fetchArticles(
      companyName: '교통사고',
      dateFrom: '2024-04-25',
      dateTo: '2024-04-25',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: _newsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 에러 발생 시 샘플 데이터로 렌더링
          return buildNewsCards([
            {
              "title": "첫 번째 뉴스 제목",
              "description": "이것은 첫 번째 뉴스의 요약입니다.",
              "image":
              "https://media.istockphoto.com/id/969500140/ko/%EC%82%AC%EC%A7%84/car-%EC%82%AC%EA%B3%A0.jpg?s=612x612&w=0&k=20&c=1RaObmBHE4xqrisebjI-33K-5IN7fI49QVnr4h2vZ3Y=",
            },
            {
              "title": "두 번째 뉴스 제목",
              "description": "이것은 두 번째 뉴스의 요약입니다.",
              "image":
              "https://media.istockphoto.com/id/1408564727/ko/%EC%82%AC%EC%A7%84/%EB%8F%84%EC%8B%9C-%EA%B1%B0%EB%A6%AC-%EC%B6%A9%EB%8F%8C-%ED%98%84%EC%9E%A5%EC%97%90%EC%84%9C-%EC%B6%A9%EB%8F%8C-%ED%9B%84-%EB%8C%80%ED%98%95-%EC%9E%90%EB%8F%99%EC%B0%A8-%EC%82%AC%EA%B3%A0-%EC%B0%A8%EB%9F%89%EC%97%90-%EC%86%90%EC%83%81-%EB%8F%84%EB%A1%9C-%EC%95%88%EC%A0%84-%EB%B0%8F-%EB%B3%B4%ED%97%98-%EA%B0%9C%EB%85%90.jpg?s=612x612&w=0&k=20&c=boM9JiougnB5qcfqSA5QHcnB5-IBtGYbBZi-VFhhQrM=",
            },
            {
              "title": "3 번째 뉴스 제목",
              "description": "이것은 3 번째 뉴스의 요약입니다.",
              "image":
              "https://media.istockphoto.com/id/1408564727/ko/%EC%82%AC%EC%A7%84/%EB%8F%84%EC%8B%9C-%EA%B1%B0%EB%A6%AC-%EC%B6%A9%EB%8F%8C-%ED%98%84%EC%9E%A5%EC%97%90%EC%84%9C-%EC%B6%A9%EB%8F%8C-%ED%9B%84-%EB%8C%80%ED%98%95-%EC%9E%90%EB%8F%99%EC%B0%A8-%EC%82%AC%EA%B3%A0-%EC%B0%A8%EB%9F%89%EC%97%90-%EC%86%90%EC%83%81-%EB%8F%84%EB%A1%9C-%EC%95%88%EC%A0%84-%EB%B0%8F-%EB%B3%B4%ED%97%98-%EA%B0%9C%EB%85%90.jpg?s=612x612&w=0&k=20&c=boM9JiougnB5qcfqSA5QHcnB5-IBtGYbBZi-VFhhQrM=",
            },
            {
              "title": "4 번째 뉴스 제목",
              "description": "이것은 4 번째 뉴스의 요약입니다.",
              "image":
              "https://media.istockphoto.com/id/1408564727/ko/%EC%82%AC%EC%A7%84/%EB%8F%84%EC%8B%9C-%EA%B1%B0%EB%A6%AC-%EC%B6%A9%EB%8F%8C-%ED%98%84%EC%9E%A5%EC%97%90%EC%84%9C-%EC%B6%A9%EB%8F%8C-%ED%9B%84-%EB%8C%80%ED%98%95-%EC%9E%90%EB%8F%99%EC%B0%A8-%EC%82%AC%EA%B3%A0-%EC%B0%A8%EB%9F%89%EC%97%90-%EC%86%90%EC%83%81-%EB%8F%84%EB%A1%9C-%EC%95%88%EC%A0%84-%EB%B0%8F-%EB%B3%B4%ED%97%98-%EA%B0%9C%EB%85%90.jpg?s=612x612&w=0&k=20&c=boM9JiougnB5qcfqSA5QHcnB5-IBtGYbBZi-VFhhQrM=",
            },
          ]);
        } else if (snapshot.hasData) {
          // API 데이터로 렌더링
          return buildNewsCards(snapshot.data!);
        } else {
          return const Center(child: Text('No news available.'));
        }
      },
    );
  }

  Widget buildNewsCards(List<Map<String, String>> newsData) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // 가로 스크롤 활성화
      child: Row(
        children: newsData.map((news) => buildNewsCard(news)).toList(),
      ),
    );
  }

  Widget buildNewsCard(Map<String, String> news) {
    return Padding(
      padding: const EdgeInsets.all(8.0),

      child: Card(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: SizedBox(
          width: 250,
          height: 150,
          child: Stack(
            children: [
              // 배경 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  news['image']!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // 불투명 레이어
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              // 텍스트
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      news['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      news['description']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
