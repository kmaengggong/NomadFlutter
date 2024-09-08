import 'package:assignment10_final/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class CommingSoon extends StatelessWidget {
  static const String baseUrl = "https://image.tmdb.org/t/p/w500";
  final String id, title, backdropPath, posterPath;

  const CommingSoon({
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 170,
            height: 170,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(
              "$baseUrl/$backdropPath",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 170,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
