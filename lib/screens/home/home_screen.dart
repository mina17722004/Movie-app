import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mm/screens/home/profile_screen.dart';
import 'package:mm/screens/home/search_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';
import '../../apis/movie_servers.dart';
import '../../model/movie_model.dart';
import 'explore_screen.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = 0;
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = MovieService().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: FutureBuilder<List<Movie>>(
            future: futureMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No movies found'));
              } else {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    key: ValueKey<String>(snapshot.data![_currentIndex].largeCoverImage),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data![_currentIndex].largeCoverImage),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          appColors.black.withOpacity(0.5),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        Positioned(
          top: 20,
          left: MediaQuery.of(context).size.width * 0.28,
          child: Image.asset(AppAssets.avaliableNow, width: 200),
        ),
        Positioned(
          top: 90,
          left: 0,
          right: 0,
          height: 350,
          child: FutureBuilder<List<Movie>>(
            future: futureMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No movies found'));
              } else {
                return CarouselSlider.builder(
                  itemCount: snapshot.data!.length,
                  options: CarouselOptions(
                    height: 350,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.5,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return moviePoster(snapshot.data![index].largeCoverImage);
                  },
                );
              }
            },
          ),
        ),

        // "Watch Now" Text
        Positioned(
          top: 440,
          left: MediaQuery.of(context).size.width * 0.28,
          child: Image.asset(AppAssets.watchNow, width: 200),
        ),

        // "Action" Text
        Positioned(
          top: 520,
          left: 20,
          child: Text(
            "Action",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // "See More" Text
        Positioned(
          top: 520,
          right: 20,
          child: GestureDetector(
            onTap: () {
              // Navigate to a detailed list of movies
            },
            child: Text(
              "See More →",
              style: TextStyle(color: Colors.yellow, fontSize: 14),
            ),
          ),
        ),

        // Horizontal List of Movies
        Positioned(
          top: 550,
          left: 0,
          right: 0,
          height: 170,
          child: FutureBuilder<List<Movie>>(
            future: futureMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No movies found'));
              } else {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!
                      .map((movie) => movieThumbnail(movie.largeCoverImage, movie.rating.toString()))
                      .toList(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget moviePoster(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(imageUrl, fit: BoxFit.cover),
    );
  }

  Widget movieThumbnail(String imageUrl, String rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 120,
        height: 170,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, width: 120, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 5),
            Text(
              "$rating ⭐",
              style: TextStyle(color: Colors.yellow, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}