import 'dart:convert';

import 'package:flutter_spotify_africa_assessment/core/api_key.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/model/spotify_model.dart';
import 'package:http/http.dart' as http;

abstract class SpotifyRemoteDataSource {
  Future<SpotifyModel>? getAllPlayList(String id);
  Future<SpotifyModel>? getSingleCategory(String categoryId);
}

class SpotifyRemoteDataSourceImp implements SpotifyRemoteDataSource {
  String id;
  SpotifyRemoteDataSourceImp({required this.id});
  @override
  Future<SpotifyModel>? getAllPlayList(String id) async {
    final response = await http.get(
        Uri.parse(
          'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/$id/playlists',
        ),
        headers: {'x-functions-key': apiKey});
    if (response.statusCode == 200) {
      return SpotifyModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  @override
  Future<SpotifyModel>? getSingleCategory(String categoryId) {
    throw UnimplementedError();
  }
}
