import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:spotify_clone_provider/api/url.dart';
import 'package:spotify_clone_provider/models/user.dart';

import '../methods/get_response.dart';
import '../models/song_model.dart';

class GetHomePage {
  Future<List<User>> getUsers() async {
    final Map<String, String> query = {
      "page": 0.toString(),
      "limit": 26.toString()
    };
    Response res = await getResponse(Uri.https(baseUrl, basePath + '', query));
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      print(body);
      final users = (body['results'] as List)
          .map<User>((user) => User.fromJson(user))
          .toList();

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<SongModel>> getSongs() async {
    final query = {"limit": 30.toString()};
    final value = await getResponse(Uri.https(
      baseUrl,
      basePath + '',
      query,
    ));
    if (value.statusCode == 200) {
      final body = jsonDecode(value.body);

      final songs = (body['results'] as List)
          .map((user) => SongModel.fromJson(user))
          .toList();

      return songs;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
