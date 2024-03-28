import 'package:flutter/material.dart';
import '../services/http_services.dart'; // Adjust the import path as per your project structure
import '../Models/Movie.dart';

class movelist extends StatefulWidget {
  const movelist({Key? key}) : super(key: key);

  @override
  State<movelist> createState() => _movelistState();
}

class _movelistState extends State<movelist> {
  List<Movie>? _movies;
  bool _isLoading = true;
  late httpService _httpService; // Declare httpService instance

  @override
  void initState() {
    super.initState();
    _httpService = httpService(); // Initialize httpService instance
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      final movies =
          await _httpService.getPopularMovies(); // Use httpService instance
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (error) {
      print('Error fetching movies: $error');
      // Handle error here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movie"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _movies != null
              ? ListView.builder(
                  itemCount: _movies!.length,
                  itemBuilder: (context, index) {
                    final movie = _movies![index];
                    return ListTile(
                      leading: Image.network(
                        'https://movie.tukanginyuk.com/${movie.posterPath}', // Provide the URL of the movie poster image
                        width: 20, // Adjust width as needed
                        height: 20, // Adjust height as needed
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return Icon(Icons
                              .error); // Display a placeholder or error icon
                        },
                      ),
                      title: Text(movie.title),
                      subtitle: Text('Rating: ${movie.voteAverage}'),
                    );
                  },
                )
              : Center(
                  child: Text('No movies found'),
                ),
    );
  }
}
