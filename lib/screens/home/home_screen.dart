import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "homeScreen";

  final List<String> movieImages = [
    AppAssets.superMan,
    AppAssets.doctorStrange,
    AppAssets.film,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 0, left: 7, right: 7, top: 7),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
              backgroundColor: appColors.grey,
              selectedItemColor: appColors.yellow,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.homeIcon, height: 28),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.searchIcon, height: 28),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.exploreIcon, height: 28),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.ProfileIcon, height: 28),
                  label: "",
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Image with Opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                AppAssets.openHimer,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // "Available Now" Image
          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width * 0.28,
            child: Image.asset(AppAssets.avaliableNow, width: 200),
          ),

          // Movie Posters Carousel (with overlapping effect)
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            height: 260,
            child: CarouselSlider.builder(
              itemCount: movieImages.length,
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.5, // Adjust to make posters overlap
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
              ),
              itemBuilder: (context, index, realIndex) {
                return moviePoster(movieImages[index]);
              },
            ),
          ),

          // "Watch Now" Image
          Positioned(
            top: 330,
            left: MediaQuery.of(context).size.width * 0.28,
            child: Image.asset(AppAssets.watchNow, width: 200),
          ),

          // Action Movies Section
          Positioned(
            top: 370,
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

          Positioned(
            top: 380,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Handle "See More" action
              },
              child: Text(
                "See More →",
                style: TextStyle(color: Colors.yellow, fontSize: 14),
              ),
            ),
          ),

          // Horizontal Movie List
          Positioned(
            top: 420,
            left: 0,
            right: 0,
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                movieThumbnail(AppAssets.doctorStrange),
                movieThumbnail(AppAssets.superMan),
                movieThumbnail(AppAssets.film),
                movieThumbnail(AppAssets.openHimer),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget moviePoster(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }

  Widget movieThumbnail(String imagePath) {
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
                child: Image.asset(imagePath, width: 120, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 5),
            Text(
              "7.7 ⭐",
              style: TextStyle(color: Colors.yellow, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
