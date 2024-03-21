import 'package:flutter/material.dart';
import 'package:httprequest/services/http_services.dart';

class movelist extends StatefulWidget {
  const movelist({super.key});

  @override
  State<movelist> createState() => _movelistState();
}

class _movelistState extends State<movelist> {
  String result = "";
  int ?movieCount;
   List ?movies;
  httpService? service;

  Future initialize() async {
    movies = [];
    movies = (await service?.getPopularMovies())!;
    setState(() {
      movieCount = movies?.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    service = httpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    service!.getPopularMovies().then((value) => {
          setState(
            () {
              result = value as String;
            },
          )
        });

    return Scaffold(
      appBar: AppBar(
        title: Text('Popular movie'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: movieCount,
          itemBuilder: (context, int position) {
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading:
                    Image(image: NetworkImage(movies![position].posterPath)),
                title: Text(movies![position].title),
                subtitle: Text(
                  'Rating: = ' + movies![position].voteAverage.toString(),
                ),
              ),
            );
          }),
    );
  }
}
