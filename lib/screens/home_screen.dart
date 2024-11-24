import 'package:flutter/material.dart';
import 'package:test111/widgets/news_card.dart';
import 'package:test111/widgets/chart.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더 섹션
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                // 캐릭터 이미지.
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1731466224339-5a6b88eb1efb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "현재 졸음수치는 60입니다. 첫번째 미션을 드리겠습니다. 고개를 좌우로 5번 돌려주세요!",
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text('Current Status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
          Flexible(
              child:HeartRateScreen()),
          // 뉴스 리스트 섹션
          const SizedBox(height: 30,),
          const Text('Breaking News', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
          const SizedBox(height: 10),
          Flexible(
            child: NewsCard(), // 뉴스 데이터를 전달
          ),
        ]);
  }
}