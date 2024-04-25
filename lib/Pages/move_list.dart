import 'package:flutter/material.dart';
import 'package:httprequest/Pages/movieDetails.dart';
import '../services/http_services.dart'; // Adjust the import path as per your project structure
import '../Models/Movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int moviesCount = 0;
  List? movies;
  httpService? service = httpService();

  @override
  void initState() {
    super.initState();
    service = httpService();
    initialize();
  }

  Future<void> initialize() async {
    movies= [];
    movies = await service!.getPopularMovies() as List<Movie>;
    setState(() {
      moviesCount = movies!.length;
      movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Movies"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: moviesCount,
        itemBuilder: (context, position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: Image(
                  image: NetworkImage(movies![position].posterPath ??
                      "https://m.media-amazon.com/images/M/MV5BNjQwZDIyNjAtZGQxMC00OTUwLWFiOWYtNzg2NDc5Mjc1MDQ5XkEyXkFqcGdeQXVyMTAxNzQ1NzI@._V1_.jpg")),
              title: Text(movies![position].title),
              subtitle:
                  Text('Rating: ${movies![position].voteAverage.toString()}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => movieDetail(movies![position]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}