import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:spotify_clone_provider/controllers/main_controller.dart';
import 'package:spotify_clone_provider/models/song_model.dart';
import 'package:spotify_clone_provider/utils/bottom_sheet_widget.dart';
import 'package:spotify_clone_provider/utils/like_button/like_button.dart';
import 'package:spotify_clone_provider/utils/loading.dart';

class CurrentPlayer extends StatefulWidget {
  final MainController con;
  const CurrentPlayer({
    super.key,
    required this.con,
  });

  @override
  State<CurrentPlayer> createState() => _CurrentPlayerState();
}

class _CurrentPlayerState extends State<CurrentPlayer> {
  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ClipRRect(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: width,
        child: StreamBuilder(
          stream: widget.con.player.current,
          builder: (context, AsyncSnapshot<Playing?> snapshot) {
            if (snapshot.hasData) {
              final myAudio = widget.con.find(
                widget.con.audios,
                snapshot.data!.audio.assetAudioPath,
              );
              return ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 300,
                    sigmaY: 300,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.black, Colors.black],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12),
                                child: Row(children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          const Text(
                                            "NOW PLAYING",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            myAudio.metas.artist!,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          useRootNavigator: true,
                                          isScrollControlled: true,
                                          elevation: 100,
                                          backgroundColor: Colors.black38,
                                          context: context,
                                          builder: (context) {
                                            return BottomSheetWidget(
                                              con: widget.con,
                                              isNext: true,
                                              song: SongModel(
                                                songid: myAudio.metas.id,
                                                songname: myAudio.metas.title,
                                                userid: myAudio.metas.album,
                                                trackid: myAudio.path,
                                                duration: '',
                                                coverImageUrl:
                                                    myAudio.metas.image!.path,
                                                name: myAudio.metas.artist,
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26.0,
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: CachedNetworkImage(
                                imageUrl: myAudio.metas.image!.path,
                                fit: BoxFit.cover,
                                memCacheHeight:
                                    (200 * devicePexelRatio).round(),
                                memCacheWidth: (200 * devicePexelRatio).round(),
                                maxHeightDiskCache:
                                    (200 * devicePexelRatio).round(),
                                maxWidthDiskCache:
                                    (200 * devicePexelRatio).round(),
                                progressIndicatorBuilder: (context, url, l) =>
                                    const LoadingImage(
                                  icon: Icon(
                                    LineIcons.compactDisc,
                                    size: 120,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Text(
                                          myAudio.metas.title!,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Text(
                                          myAudio.metas.artist!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.grey,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                LikeButton(
                                  name: myAudio.metas.title!,
                                  fullname: myAudio.metas.artist!,
                                  username: myAudio.metas.album!,
                                  id: myAudio.metas.id!,
                                  track: myAudio.path,
                                  isIcon: false,
                                  cover: myAudio.metas.image!.path,
                                ),
                                const SizedBox(width: 24),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
