import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/core/failure/failure.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/data_source/spotfy_remote_data_source.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/model/spotify_model.dart';

class SpotifyProvider extends ChangeNotifier {
  Failure? failure;
  List<Items>? items;
  dynamic res;
  SpotifyModel? spotifyModel;
  SpotifyProvider({this.failure, this.spotifyModel, this.items});
  getSpotifyByCategoryId(String id) async {
    SpotifyRemoteDataSourceImp spotifyRemoteDataSourceImp =
        SpotifyRemoteDataSourceImp(id: id);
    res = await spotifyRemoteDataSourceImp.getAllPlayList('afro');
    items = res.playlists!.items;

    if (res != null) {
   
      ChangeNotifier();
      return items;
    } else {
      throw ServerFailure(errorMessage: 'The problem is in our side');
    }
  }
}
