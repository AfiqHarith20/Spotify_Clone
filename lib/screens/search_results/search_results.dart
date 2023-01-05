import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_provider/controllers/main_controller.dart';
import 'package:spotify_clone_provider/models/loading_enum.dart';
import 'package:spotify_clone_provider/screens/search_results/cubit/search_results_cubit.dart';
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
              onChange: (String? s) {
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
                        return InkWell();
                      },
                    );
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}
