import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotify_clone_provider/api/url.dart';
import 'package:spotify_clone_provider/methods/get_response.dart';
import 'package:spotify_clone_provider/models/song_model.dart';

class GetOneSong {
  Future<SongModel> getSongs(String name) async {
    Response res =
        await getResponse(Uri.http(baseUrl, '$basePath/songs/one/$name'));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return SongModel.fromJson(body['result'][0]);
    } else {
      throw Exception("Failed fetch users");
    }
  }
}
