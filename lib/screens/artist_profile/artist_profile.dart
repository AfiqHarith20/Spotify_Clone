import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_provider/controllers/main_controller.dart';
import 'package:spotify_clone_provider/models/loading_enum.dart';
import 'package:spotify_clone_provider/screens/artist_profile/cubit/artist_profile_cubit.dart';
import 'package:spotify_clone_provider/utils/bottom_sheet_widget.dart';
import 'package:spotify_clone_provider/utils/loading.dart';
import 'package:spotify_clone_provider/utils/sliver_appbar.dart';

class ArtistProfile extends StatelessWidget {
  final String username;
  final MainController con;
  const ArtistProfile({
    Key? key,
    required this.username,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtistProfileCubit()..getUser(username),
      child: BlocBuilder<ArtistProfileCubit, ArtistProfileState>(
        builder: (context, state) {
          if (state.status == LoadPage.loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state.status == LoadPage.loaded) {
            return Scaffold(
              extendBody: true,
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: MyDelegate(
                      user: state.user,
                      con: con,
                      songs: state.songs,
                    ),
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Popular",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((_, i) {
                      bool isPlaying = con.player.getCurrentAudioTitle ==
                          state.songs[i].songname;
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<ArtistProfileCubit>(context)
                              .playSongs(con, i);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(children: [
                                  Text(
                                    (i + 1).toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(3),
                                    child: CachedNetworkImage(
                                      imageUrl: state.songs[i].coverImageUrl!,
                                      width: 50,
                                      height: 50,
                                      maxHeightDiskCache: 100,
                                      maxWidthDiskCache: 100,
                                      memCacheHeight: (50 *
                                              MediaQuery.of(context)
                                                  .devicePixelRatio)
                                          .round(),
                                      memCacheWidth: (50 *
                                              MediaQuery.of(context)
                                                  .devicePixelRatio)
                                          .round(),
                                      progressIndicatorBuilder:
                                          (context, url, progress) =>
                                              const LoadingImage(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.songs[i].songname!,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: isPlaying
                                                      ? Colors.lightGreen[700]
                                                      : Colors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          ),
                                          Text(
                                            state.songs[i].duration!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  color: Colors.grey,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
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
                                              con: con, song: state.songs[i]);
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
