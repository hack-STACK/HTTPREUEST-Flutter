import 'package:flutter/material.dart';
import 'package:httprequest/Pages/movieDetails.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../services/http_services.dart'; // Adjust the import path as per your project structure
import '../Models/Movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
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
    movies = [];
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
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetail(movies![index]),
                ),
              );
            },
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: Container(
                height: 250, // Set the desired height for the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              movies![index].posterPath ??
                                  "https://m.media-amazon.com/images/M/MV5BNjQwZDIyNjAtZGQxMC00OTUwLWFiOWYtNzg2NDc5Mjc1MDQ5XkEyXkFqcGdeQXVyMTAxNzQ1NzI@._V1_.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movies![index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: movies![index].voteAverage / 1,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              SizedBox(width: 5),
                              Text(
                                movies![index].voteAverage.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
