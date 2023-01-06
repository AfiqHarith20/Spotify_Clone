<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_provider/controllers/main_controller.dart';
import 'package:spotify_clone_provider/models/loading_enum.dart';
import 'package:spotify_clone_provider/screens/search_results/cubit/search_results_cubit.dart';
=======
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:spotify_clone_provider/controllers/main_controller.dart';
import 'package:spotify_clone_provider/models/loading_enum.dart';
import 'package:spotify_clone_provider/screens/artist_profile/artist_profile.dart';
import 'package:spotify_clone_provider/screens/search_results/cubit/search_results_cubit.dart';
import 'package:spotify_clone_provider/utils/bottom_sheet_widget.dart';
import 'package:spotify_clone_provider/utils/loading.dart';
>>>>>>> update-4
import 'package:spotify_clone_provider/utils/recent_search.dart';

class SearchResultPage extends StatelessWidget {
  final MainController con;
  const SearchResultPage({
    Key? key,
    required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    return BlocProvider(
      create: (context) => SearchResultsCubit(),
      child: BlocBuilder<SearchResultsCubit, SearchResultsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              onPressed: () {
                BlocProvider.of<SearchResultsCubit>(context).isSongToggle();
              },
<<<<<<< HEAD
              onChange: (String? s) {
=======
              onChanged: (String? s) {
>>>>>>> update-4
                if (s == '' || s == null) {
                  BlocProvider.of<SearchResultsCubit>(context).isNullToggle();
                } else {
                  if (state.isNull) {
                    BlocProvider.of<SearchResultsCubit>(context).isNullToggle();
                  }
                  BlocProvider.of<SearchResultsCubit>(context).SearchSongs(s);
                }
              },
              isSong: state.isSong,
            ),
            body: Builder(
              builder: (context) {
                if (state.status == LoadPage.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.status == LoadPage.loaded) {
                  if (state.isNull) {
                    return RecentSearch(con: con);
                  } else if (state.isSong) {
                    return ListView.builder(
                      itemCount: state.songs.length,
                      itemBuilder: (context, i) {
                        bool isPlaying = con.player.getCurrentAudioTitle ==
                            state.songs[i].songname;
<<<<<<< HEAD
                        return InkWell();
=======
                        return InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<SearchResultsCubit>(context)
                                .playSongs(con, i);
                            var box = Hive.box('Recentsearch');
                            box.put(state.songs[i].songname, {
                              "songname": state.songs[i].songname,
                              "fullname": state.songs[i].name,
                              "username": state.songs[i].userid,
                              "cover": state.songs[i].coverImageUrl,
                              "track": state.songs[i].trackid,
                              "id": state.songs[i].songid,
                              "type": "SONG"
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              bottom: 12.0,
                              top: 12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              state.songs[i].coverImageUrl!,
                                          width: 50,
                                          height: 50,
                                          memCacheHeight: (50 *
                                                  MediaQuery.of(context)
                                                      .devicePixelRatio)
                                              .round(),
                                          memCacheWidth: (50 *
                                                  MediaQuery.of(context)
                                                      .devicePixelRatio)
                                              .round(),
                                          progressIndicatorBuilder:
                                              (context, url, l) =>
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
                                                          ? Colors
                                                              .lightGreenAccent[700]
                                                          : Colors.white,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                state.songs[i].duration!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  splashRadius: 20,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        useRootNavigator: true,
                                        isScrollControlled: true,
                                        elevation: 100,
                                        backgroundColor: Colors.black38,
                                        context: context,
                                        builder: (context) {
                                          return BottomSheetWidget(
                                            con: con,
                                            song: state.songs[i],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            var box = Hive.box('Recentsearch');
                            box.put(state.users[i].name, {
                              "songname": state.users[i].name,
                              "fullname": state.users[i].username,
                              "username": '',
                              "cover": state.users[i].avatar,
                              "track": '',
                              "id": '',
                              "type": "ARTIST",
                            });
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ArtistProfile(
                                    username: state.users[i].username!,
                                    con: con,
                                  ),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              bottom: 12.0,
                              top: 12.0,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: CachedNetworkImage(
                                    imageUrl: state.users[i].avatar!,
                                    width: 50,
                                    height: 50,
                                    memCacheHeight:
                                        (70 * devicePexelRatio).round(),
                                    memCacheWidth:
                                        (70 * devicePexelRatio).round(),
                                    maxHeightDiskCache:
                                        (70 * devicePexelRatio).round(),
                                    maxWidthDiskCache:
                                        (70 * devicePexelRatio).round(),
                                    progressIndicatorBuilder:
                                        (context, url, l) =>
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
                                          state.users[i].name!,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.white,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          state.users[i].username!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.grey,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
>>>>>>> update-4
                      },
                    );
                  }
                }
<<<<<<< HEAD
=======
                if (state.status == LoadPage.error) {
                  return const Center(
                    child: Text(
                      "Error",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                return Container();
>>>>>>> update-4
              },
            ),
          );
        },
      ),
    );
  }
}
<<<<<<< HEAD
=======

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String? s) onChanged;
  final bool isSong;
  final void Function() onPressed;
  const CustomAppBar({
    Key? key,
    required this.onChanged,
    required this.isSong,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey.shade800,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Container(
                color: Colors.grey.shade800,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.grey.shade800,
                    border: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ),
              Container(
                color: Colors.grey.shade800,
                child: IconButton(
                  splashRadius: 20,
                  icon: isSong
                      ? const Icon(
                          LineIcons.music,
                          color: Colors.white,
                        )
                      : const Icon(
                          LineIcons.user,
                          color: Colors.white,
                        ),
                  onPressed: onPressed,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
>>>>>>> update-4
