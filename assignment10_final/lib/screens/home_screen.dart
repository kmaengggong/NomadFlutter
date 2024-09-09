import 'package:assignment10_final/models/movie_model.dart';
import 'package:assignment10_final/services/api_service.dart';
import 'package:assignment10_final/widgets/comming_soon_widget.dart';
import 'package:assignment10_final/widgets/now_in_cinemas_widget.dart';
import 'package:assignment10_final/widgets/popular_movie_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> nowMovies = ApiService.getNowMovies();
  final Future<List<MovieModel>> soonMovies = ApiService.getSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Popular Movies",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            FutureBuilder(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 240,
                        child: makePopularList(snapshot),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Now in Cinemas",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            FutureBuilder(
              future: nowMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 260,
                        child: makeNowList(snapshot),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Comming soon",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            FutureBuilder(
              future: soonMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 260,
                        child: makeSoonList(snapshot),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ListView makePopularList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return PopularMovie(
          id: movie.id,
          title: movie.title,
          backdropPath: movie.backdropPath,
          posterPath: movie.posterPath,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }

  ListView makeNowList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return NowInCinemas(
          id: movie.id,
          title: movie.title,
          backdropPath: movie.backdropPath,
          posterPath: movie.posterPath,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }

  ListView makeSoonList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return CommingSoon(
          id: movie.id,
          title: movie.title,
          backdropPath: movie.backdropPath,
          posterPath: movie.posterPath,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
