import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mm/screens/home/edit_profile_screen.dart';
import 'package:mm/screens/home/home.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';
import '../../apis/movie_servers.dart';
import '../../model/movie_model.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  List<Movie> _allMovies = [];
  String? username;
  String? iconFilename;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchMovies();
  }

  Future<void> _fetchUserData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        setState(() {
          username = userDoc['name'] ?? "Anonymous";
          iconFilename = userDoc['iconUrl'] ?? "gamerOne.png";
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _fetchMovies() async {
    try {
      List<Movie> movies = await MovieService().fetchMovies();
      setState(() {
        _allMovies = movies;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  String _getIconPath(String filename) {
    Map<String, String> iconMap = {
      "gamerOne.png": AppAssets.gamerOne,
      "gamerTwo.png": AppAssets.gamerTwo,
      "gamerThree.png": AppAssets.gamerThree,
    };
    return iconMap[filename] ?? AppAssets.gamerOne;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: appColors.grey,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blueAccent,
                      backgroundImage:
                      AssetImage(_getIconPath(iconFilename ?? "gamerTwo.png")),
                    ),
                    SizedBox(width: 45),
                    _infoBox("${_allMovies.length}", "Watch List"),
                    SizedBox(width: 55),
                    _infoBox("0", "History"),
                  ],
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    username ?? "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _profileButton(context, "Edit Profile", appColors.yellow,
                        appColors.black, EditProfileScreen.routeName),
                    SizedBox(width: 10),
                    _profileButton(context, "Exit", appColors.red,
                        appColors.white, HomeScreen.routeName),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _tabButton(Icons.menu, "Watch List", 0),
                SizedBox(width: 20),
                _tabButton(Icons.folder, "History", 1),
              ],
            ),
          ),
          Expanded(
            child: selectedTab == 0 ? _buildWatchList() : _buildHistory(),
          ),
        ],
      ),
    );
  }

  Widget _buildWatchList() {
    return _allMovies.isEmpty
        ? Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.movie, size: 60, color: Colors.yellow),
          SizedBox(height: 10),
          Text("No movies found",
              style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    )
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
        itemCount: _allMovies.length,
        itemBuilder: (context, index) {
          return _buildMovieCard(_allMovies[index]);
        },
      ),
    );
  }

  Widget _buildHistory() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.history, size: 60, color: Colors.yellow),
          SizedBox(height: 10),
          Text("No history available",
              style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }
  Widget _tabButton(IconData icon, String label, int tabIndex) {
    bool isSelected = selectedTab == tabIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = tabIndex; // Change tab on tap
        });
      },
      child: Column(
        children: [
          Icon(icon,
              color: isSelected ? Colors.yellow : Colors.white, size: 24),
          SizedBox(height: 4),
          Container(
            height: 3,
            width: 60,
            color: isSelected ? Colors.yellow : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _profileButton(BuildContext context, String text, Color bgColor,
      Color textColor, String routeName) {return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      padding: EdgeInsets.symmetric(horizontal: 65, vertical: 10),
    ),
    onPressed: () {
      Navigator.pushReplacementNamed(context, routeName);
    },
    child: Text(text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
  );}
  Widget _infoBox(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label,
            style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return ClipRRect(
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
    );
  }
}
