import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<List<dynamic>> getMovies(String movieName) async {
    final response = await http.get(
        'https://api.themoviedb.org/3/search/movie?api_key=aed290d0b9e9740f99746c0bf2f05d80&query=' +
            Uri.encodeQueryComponent(movieName));

    var toReturn = [];
    final results = jsonDecode(response.body)['results'];
    for (int i = 0; i < results.length; i++) {
      if (results[i]["poster_path"] == null) {
        continue;
      }
      toReturn.add(Container(
          child: Column(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500' + results[i]["poster_path"],
            width: 200,
            height: 400,
          ),
          Text(results[i]["title"], style: TextStyle(fontSize: 20))
        ],
      )));
    }
    return toReturn;
  }
}
