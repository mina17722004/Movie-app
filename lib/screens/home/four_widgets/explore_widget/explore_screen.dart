import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:mm/apis/movie_servers.dart';
import 'package:mm/theme/app_colors.dart';
import '../../../../model/movie_model.dart';
import '../../../../theme/app_assets.dart';

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({super.key});
  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}
class _ExploreWidgetState extends State<ExploreWidget> {
  int _tabTextIndexSelected = 0;
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  List<String> _genres = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }
  Future<void> _fetchMovies() async {
    try {
      List<Movie> movies = await MovieService().fetchMovies();
      Set<String> uniqueGenres = {};
      for (var movie in movies) {
        uniqueGenres.addAll(movie.genres);
      }
      setState(() {
        _movies = movies;
        _genres = uniqueGenres.toList();
        _filterMovies();
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching movies: $e");
      setState(() => _isLoading = false);
    }
  }
  void _filterMovies() {
    if (_genres.isEmpty) return;
    String selectedGenre = _genres[_tabTextIndexSelected];
    setState(() {
      _filteredMovies = _movies
          .where((movie) => movie.genres.contains(selectedGenre))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          if (_genres.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FlutterToggleTab(
                      width:501,
                      borderRadius: 30,
                      height: 50,
                      unSelectedBackgroundColors: [appColors.grey],
                      selectedIndex: _tabTextIndexSelected,
                      selectedBackgroundColors: [appColors.yellow],
                      selectedTextStyle: TextStyle(
                        color: appColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
              ),
        unSelectedTextStyle: TextStyle(
           color: appColors.white,
        fontSize: 14,
     fontWeight: FontWeight.bold,
        ),
      dataTabs: _genres.map((genre) => DataTab(title: genre)).toList(),
   selectedLabelIndex: (index) {
            setState(() {
             _tabTextIndexSelected = index;
          _filterMovies();
         });},
        isScroll: true,
         ),],),)),
     Expanded(
 child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _filteredMovies.isEmpty
          ? Center(child: Image.asset(AppAssets.empty))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: _filteredMovies.length,
                itemBuilder: (context, index) {
                  return _buildMovieCard(_filteredMovies[index]);
                },
              ),
            ),
          ),
        ],
      ),
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