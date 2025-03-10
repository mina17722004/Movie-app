import 'package:flutter/material.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/text_form_field.dart';
import '../../../../apis/movie_servers.dart';
import '../../../../model/movie_model.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _searchController = TextEditingController();
  List<Movie> _allMovies = [];
  List<Movie> _filteredMovies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  void _fetchMovies() async {
    try {
      List<Movie> movies = await MovieService().fetchMovies();
      setState(() {
        _allMovies = movies;
        _filteredMovies = movies;
      });
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  void _filterMovies(String query) {
    setState(() {
      _filteredMovies = _allMovies
          .where((movie) =>
          movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: CustomTextFormField(
            text: "Search",
            PrefixiconData: Icons.search_outlined,
            controller: _searchController,
            onchanged: _filterMovies,
          ),
        ),
        Expanded(
          child: _filteredMovies.isEmpty
              ? Center(child: Image.asset(AppAssets.empty))
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
            GridView.builder(
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
