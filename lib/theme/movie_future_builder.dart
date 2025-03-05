import 'package:flutter/material.dart';

import '../apis/movie_servers.dart';
import '../model/movie_model.dart';

class MovieFutureBuilder extends StatefulWidget {
  final Widget child;

  const MovieFutureBuilder({super.key, required this.child});

  @override
  State<MovieFutureBuilder> createState() => _MovieFutureBuilderState();
}

class _MovieFutureBuilderState extends State<MovieFutureBuilder> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = MovieService().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: futureMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No movies found'));
        } else {
          return widget.child;
        }
      },
    );
  }
}
