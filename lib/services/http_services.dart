import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:httprequest/Models/Movie.dart'; 

class httpService{
  final String apiKey = 'api key';
  final String baseUrl = 'http://movie.tukanginyuk.com/api/getmovie';

  Future<List?> getPopularMovies()async{
    final String uri = baseUrl+ apiKey;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok){
      print("sukses");
      final jsonResponse =jsonDecode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.get((i) => Movie.fromjson(i)).toList();
      return movies;
    } else{
      print("Fail");
      return null;
    }
    
  }
}