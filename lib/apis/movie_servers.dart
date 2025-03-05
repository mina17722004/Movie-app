import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/movie_model.dart';


class MovieService {
  final String baseUrl = "https://yts.mx/api/v2/list_movies.json";

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> moviesJson = data['data']['movies'];
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}