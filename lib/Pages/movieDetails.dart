import 'package:flutter/material.dart';
import 'package:httprequest/Models/Movie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path = movie.posterPath ??
        'https://cdn.vectorstock.com/i/preview-1x/82/99/no-image-available-like-missing-picture-vector-43938299.jpg';

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.indigo],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 70),
                Container(
                  padding: const EdgeInsets.all(16),
                  height: height / 1.5,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      path,
                      height: height / 1.5,
                      width: width * 0.8,
                      fit: BoxFit.cover,
                      // Add shadow to the image
                      color: Colors.black.withOpacity(0.5),
                      colorBlendMode: BlendMode.darken,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    movie.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    movie.overview,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 100,
              left: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    initialRating: movie.voteAverage.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
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
                    movie.voteAverage.toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
