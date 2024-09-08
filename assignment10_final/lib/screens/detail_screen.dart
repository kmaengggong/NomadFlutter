import 'package:assignment10_final/models/movie_detail_model.dart';
import 'package:assignment10_final/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailScreen extends StatefulWidget {
  final String id, posterPath;

  const DetailScreen({
    super.key,
    required this.id,
    required this.posterPath,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  static const String baseUrl = "https://image.tmdb.org/t/p/w500";
  late Future<MovieDetailModel> movie;

  // Future<void> _launchUrl(_url) async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

  onPressedHomePage(String url) async {
    await launchUrlString(url);
  }

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 40,
            color: Colors.white,
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Back to list",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.network(
              "$baseUrl/${widget.posterPath}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 320,
                    ),
                    FutureBuilder(
                      future: movie,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;

                          final stars = List<Widget>.generate(
                            (data.voteAverage / 2).floor(), // 전체 별 개수
                            (index) => Icon(Icons.star, color: Colors.yellow),
                          );

                          final halfStar = (data.voteAverage / 2) % 1 != 0
                              ? Icon(Icons.star_half, color: Colors.yellow)
                              : SizedBox();

                          final emptyStars = List<Widget>.generate(
                            5 -
                                stars.length -
                                (halfStar is Icon ? 1 : 0), // 빈 별 개수
                            (index) =>
                                Icon(Icons.star_border, color: Colors.yellow),
                          );

                          final hours = data.runtime ~/ 60;
                          final minutes = data.runtime % 60;
                          final runtimeText = '${hours}h ${minutes}min';

                          final genresText =
                              data.genres.map((genre) => genre.name).join(', ');

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                children: [
                                  ...stars,
                                  halfStar,
                                  ...emptyStars,
                                  data.adult
                                      ? Icon(
                                          Icons.eighteen_up_rating,
                                          color: Colors.red,
                                          size: 32,
                                        )
                                      : Icon(
                                          Icons.no_adult_content,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$runtimeText | $genresText',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Storyline",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                data.overview,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      onPressedHomePage(data.homepage),
                                  child: Text(
                                    "Visit Homepage",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                    minimumSize: Size(320, 56),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const Text("...");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
