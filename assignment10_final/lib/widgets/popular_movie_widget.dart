import 'package:assignment10_final/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class PopularMovie extends StatelessWidget {
  static const String baseUrl = "https://image.tmdb.org/t/p/w500";
  final String id, title, backdropPath, posterPath;

  const PopularMovie({
    super.key,
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(id: id, posterPath: posterPath),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 320,
            height: 240,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(
              "$baseUrl/$backdropPath",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
