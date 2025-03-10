import 'package:flutter/material.dart';
import 'package:mm/theme/app_colors.dart';
import '../../../../apis/movie_servers.dart';
import '../../../../model/movie_model.dart';
import '../movie_details/movie_details.dart';

class SeeMoreScreen extends StatefulWidget {
  static const String routeName = "seeMore";

  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  List<Movie> _movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      List<Movie> movies = await MovieService().fetchMovies();
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching movies: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black,
      appBar: AppBar(
        backgroundColor: appColors.black,
        centerTitle: true,
        title: Text("All Movies",
            style: TextStyle(color: appColors.yellow)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _movies.isEmpty
          ? Center(
          child: Text("No movies available",
              style: TextStyle(color: Colors.white)))
          : Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemCount: _movies.length,
          itemBuilder: (context, index) {
            return _buildMovieCard(context, _movies[index]);
          },
        ),
      ),
    );
  }

  Widget _buildMovieCard(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.network(
              movie.largeCoverImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 14),
                    SizedBox(width: 3),
                    Text(
                      movie.rating.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
