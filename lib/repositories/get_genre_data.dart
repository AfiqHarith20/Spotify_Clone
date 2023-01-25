import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotify_clone_provider/api/url.dart';
import 'package:spotify_clone_provider/methods/get_response.dart';
import 'package:spotify_clone_provider/models/song_model.dart';
import 'package:spotify_clone_provider/models/user.dart';

class GenreRepository {
  Future<List<User>> getUsers(String tag) async {
    final query = {
      'offset': 0.toString(),
      'limit': 50.toString(),
    };

    Response res = await getResponse(
        Uri.https('${baseUrl}artists/genres/$tag', query.toString()));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return (body['results'] as List).map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed fetch users');
    }
  }

  Future<List<SongModel>> getSongs(String genres) async {
    final query = {
      'offset': 0.toString(),
      'limit': 50.toString(),
    };

    Response res = await getResponse(
        Uri.https('${baseUrl}genres/$genres', query.toString()));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return (body['results'] as List)
          .map((e) => SongModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed fetch songs');
    }
  }
}
