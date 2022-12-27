import 'dart:convert';

import 'package:spotify_clone_provider/methods/get_response.dart';
import 'package:spotify_clone_provider/models/song_model.dart';
import 'package:spotify_clone_provider/models/user_model.dart';

import '../api/url.dart';

class GetArtistsData {
  Future<UserModel> getUserData(String id) async {
    final value = await getResponse(
      Uri.https(baseUrl, basePath + ''),
    );

    if (value.statusCode == 200) {
      final body = jsonDecode(value.body);

      return UserModel.formJson(body['result']);
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<List<SongModel>> getSong(String id) async {
    final value = await getResponse(Uri.https(baseUrl, basePath + '' + id, {
      'page': 0.toString(),
      'limit': 100.toString(),
    }));
    if (value.statusCode == 200) {
      final body = jsonDecode(value.body);
      return ((body['results'] as List)
          .map((e) => SongModel.fromJson(e))
          .toList());
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
