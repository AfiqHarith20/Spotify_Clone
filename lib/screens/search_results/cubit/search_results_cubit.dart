import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_provider/controllers/main_controller.dart';
import 'package:spotify_clone_provider/models/loading_enum.dart';
import 'package:spotify_clone_provider/models/song_model.dart';
import 'package:spotify_clone_provider/models/user.dart';
import 'package:spotify_clone_provider/repositories/get_search_results.dart';

part 'search_results_state.dart';

class SearchResultsCubit extends Cubit<SearchResultsState> {
  final repo = SearchRespository();

  SearchResultsCubit() : super(SearchResultsState.initial());
  void SearchSongs(String tag) async {
    if (state.isSong) {
      try {
        emit(state.copyWith(status: LoadPage.loading));
        var songs = await repo.getSongs(tag.toString());
        emit(state.copyWith(
          status: LoadPage.loaded,
          songs: songs,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: LoadPage.error,
        ));
      }
    } else {
      try {
        emit(state.copyWith(status: LoadPage.loading));
        var users = await repo.getUsers(tag.toString());
        emit(state.copyWith(
          status: LoadPage.loaded,
          users: users,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: LoadPage.error,
        ));
      }
    }
  }

  void playSongs(MainController controller, int initial) {
    controller.playSong(
        controller.convertLocalSongToAudio(state.songs), initial);
  }

  void isNullToggle() {
    emit(state.copyWith(isNull: !state.isNull));
  }

  void isSongToggle() {
    emit(state.copyWith(isSong: !state.isSong));
  }
}
