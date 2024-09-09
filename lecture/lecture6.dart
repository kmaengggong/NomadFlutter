// main.dart
import 'package:flutter/material.dart';

// /services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;


// main.dart
void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}


// /screens/home_screen.dart
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();
  
  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(webtoon);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Column(
              children: [
                const SizedBox(
                  height: 50
                ),
                Expanded(
                  child: makeList(snapshot)
                ),
              ],
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


// /screens/detail_screen.dart
class DetailScreen extends StatelessWidget {
  final String title, thumb, id;
  
  DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: id,
                child: Container(
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: Offset(10, 10),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Image.network(thumb),
                ), 
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// /services/api_service.dart
// pub.dev 공식 패키지 보관소.
// http 검색. 
// pubspec.yaml: 프로젝트 정보, 폰트, 패키지 버전
// dependencies: flutter: http:  --> 다운버튼 클릭
class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";
  
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final List<dynamic> webtoons = jsonDecode(response.body);
      for(var webtoon in webtoons){
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
      // return webtoons.map((webtoon) => WebtoonModel.fromJson(webtoon)).toList();
    }
    throw Error();
  }
}


// /models/webtoon_model.dart
class WebtoonModel {
  final String title, thumb, id;
  
  WebtoonModel.fromJson(Map<String, dynamic> json):
    title = json['title'],
    thumb = json['thumb'],
    id = json['id'];
}


// /widgets/webtoon_widget.dart
class Webtoon extends StatelessWidget {
  final String title, thumb, id;
  
  Webtoon(WebtoonModel webtoon, {super.key}):
    title = webtoon.title,
    thumb = webtoon.thumb,
    id = webtoon.id;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: Offset(10, 10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 22
            ),
          ),
        ],
      ),
    );
  }
}