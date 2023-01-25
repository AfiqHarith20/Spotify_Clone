import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotify_clone_provider/methods/get_response.dart';
import 'package:spotify_clone_provider/models/song_model.dart';
import 'package:spotify_clone_provider/models/user.dart';

import '../api/url.dart';

class SearchRespository {
  Future<List<User>> getUsers(String tag) async {
    final query = {
      "page": 0.toString(),
      "limit": 50.toString(),
      "q": tag,
    };

    Response res =
        await getResponse(Uri.https('${baseUrl}search/', query.toString()));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return (body['results'] as List).map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed fetch users');
    }
  }

  Future<List<SongModel>> getSongs(String tag) async {
    final query = {
      "page": 0.toString(),
      "limit": 50.toString(),
      "q": tag,
    };

    Response res =
        await getResponse(Uri.https('${baseUrl}albums/', query.toString()));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return (body['results'] as List)
          .map((e) => SongModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed fetch users');
    }
  }
}
