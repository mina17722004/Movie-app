import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _selectedTab = 0;

  final List<String> movieImages = [
    AppAssets.superMan,
    AppAssets.doctorStrange,
    AppAssets.film,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black,
      bottomNavigationBar: SalomonBottomBar(
       itemPadding: EdgeInsets.all(16),
        //backgroundColor: appColors.grey,
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        selectedItemColor: appColors.yellow,
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home, size: 28),
            title: Text("Home"),
              selectedColor: appColors.yellow,
            unselectedColor: appColors.white
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search, size: 28),
            title: Text("Search"),
              selectedColor: appColors.yellow,
              unselectedColor: appColors.white
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.explore, size: 28),
            title: Text("Explore"),
              selectedColor: appColors.yellow,
              unselectedColor: appColors.white
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person, size: 28),
            title: Text("Profile"),
            selectedColor: appColors.yellow,
              unselectedColor: appColors.white
          ),
        ],
      ),
      body: Stack(
        children: [
          // Dynamic Background Image
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Image.asset(
                movieImages[_currentIndex],
                key: ValueKey<String>(movieImages[_currentIndex]),
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.5),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),

          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width * 0.28,
            child: Image.asset(AppAssets.avaliableNow, width: 200),
          ),

          // Movie Posters Carousel
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
                viewportFraction: 0.5,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return moviePoster(movieImages[index]);
              },
            ),
          ),

          // "Watch Now"
          Positioned(
            top: 330,
            left: MediaQuery.of(context).size.width * 0.28,
            child: Image.asset(AppAssets.watchNow, width: 200),
          ),

          // Action Movies Section
          Positioned(
            top: 450,
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
            top: 450,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // Handle "See More"
              },
              child: Text(
                "See More →",
                style: TextStyle(color: Colors.yellow, fontSize: 14),
              ),
            ),
          ),

          // Horizontal Movie List
          Positioned(
            top: 480,
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
