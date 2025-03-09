import 'package:flutter/material.dart';
import 'package:mm/theme/app_assets.dart';
import '../../model/movie_model.dart';
import '../../theme/app_colors.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.largeCoverImage,
                    width: double.infinity,
                    height: 900,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.4),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 12,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 12,
                  child: IconButton(
                    onPressed: () {
                    },
                    icon: Icon(Icons.bookmark_border, color: Colors.white, size: 30),
                  ),
                ),
                Positioned(
                  top: 350,
                  left: 160,
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(AppAssets.playPause),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        movie.titleLong,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _infoContainer(Icons.favorite, "15"),
                          SizedBox(width: 25),
                          _infoContainer(Icons.timer, "90"),
                          SizedBox(width: 25),
                          _infoContainer(Icons.star, "${movie.rating}"),
                        ],
                      ),

                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: appColors.red,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text("Match", style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _sectionTitle("Screen Shots"),
            SizedBox(
              height: 150,
              width: 400,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
                child: _screenshotItem(movie.backgroundImage),)
            ),
            SizedBox(height: 5,),
            SizedBox(
              height: 150,
              width: 400,
              child: Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
                child: _screenshotItem(movie.backgroundImage),)
            ),
            SizedBox(height: 5,),
            SizedBox(
              height: 150,
              width: 400,
              child: Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
                child: _screenshotItem(movie.backgroundImage),)
            ),

            _sectionTitle("Similar"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMovieCard(movie),
                      _buildMovieCard(movie),
                    ],
                  ),
                  SizedBox(height: 10), // Add spacing between rows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMovieCard(movie),
                      _buildMovieCard(movie),
                    ],
                  ),
                ],
              ),
            ),

            _sectionTitle("Summary"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                movie.summary.isNotEmpty ? movie.summary : "No summary available.",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            _sectionTitle("Cast"),
            _castItem("Hayley Atwell", "Captain Carter"),
            _castItem("Elizabeth Olsen", "The Scarlet Witch"),
            _castItem("Rachel McAdams", "Dr. Christine Palmer"),
            _castItem("Chiwetel Ejiofor", "Karl Mordo"),

            _sectionTitle("Genres"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 8.0,
                children: movie.genres
                    .map((genre) => Chip(
                  backgroundColor: Colors.grey[800],
                  label: Text(genre, style: TextStyle(color: Colors.white)),
                ))
                    .toList(),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _infoContainer(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: appColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color:appColors.yellow, size: 20),
          SizedBox(width: 5),
          Text(text, style: TextStyle(color:appColors.white,
              fontSize: 18)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _screenshotItem(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(imageUrl, width: 150, fit: BoxFit.cover),
      ),
    );
  }
  Widget _castItem(String name, String character) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: $name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text("Character: $character", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
Widget _buildMovieCard(Movie movie) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        children: [
          // Movie Poster
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(movie.largeCoverImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 16),
                  SizedBox(width: 4),
                  Text(
                    movie.rating.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
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


