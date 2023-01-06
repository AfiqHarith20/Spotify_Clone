import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone_provider/controllers/main_controller.dart';

class PlaylistSongs extends StatelessWidget {
  final MainController con;
  final String name;
  final String coverImage;
  const PlaylistSongs({
    Key? key,
    required this.con,
    required this.name,
    required this.coverImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    List<dynamic> data = [];
    return Scaffold();
  }
}
