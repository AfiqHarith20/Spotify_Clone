import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone_provider/controllers/main_controller.dart';
import 'package:spotify_clone_provider/screens/current_playing/current_playing_song.dart';

class PlayListWidget extends StatefulWidget {
  final MainController con;
  final List<Audio> audios;
  const PlayListWidget({
    Key? key,
    required this.con,
    required this.audios,
  }) : super(key: key);

  @override
  State<PlayListWidget> createState() => _PlayListWidgetState();
}

class _PlayListWidgetState extends State<PlayListWidget> {
  Audio findSong(title) {
    final currentlyPlayingAudio = widget.con.findByname(widget.audios, title);

    return currentlyPlayingAudio;
  }

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Playlist',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Builder(builder: (context) {
          final CurrentPlayingAudio = widget.con.findByname(
            widget.audios,
            widget.con.player.getCurrentAudioTitle,
          );
          int indexOfCurrentAudio = widget.audios.indexOf(CurrentPlayingAudio);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text(
                    "Playing Now",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
