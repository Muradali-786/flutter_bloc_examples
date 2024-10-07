import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_event.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_state.dart';
import 'package:flutter_bloc_example/repository/repository.dart';
import 'package:flutter_bloc_example/utils/post_status.dart';

import '../../model/post_model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  Repository repository = Repository();

  List<PostModel> temPostList = [];
  List<PostModel> newPostList = [];
  PostBloc() : super(const PostState()) {
    on<FetchEvent>(_fetchPostApi);
    on<SearchEvent>(_onSearch);
  }

  void _fetchPostApi(FetchEvent event, Emitter<PostState> emit) async {
    if (state.status == PostStatus.loading || !state.hasMore) return;
    emit(state.copyWith(status: PostStatus.loading));
    try {
      await repository.fetchApi(state.page, state.limit).then((data) {
        if (data.isEmpty) {
          emit(state.copyWith(hasMore: false));
        } else {
          newPostList.addAll(data);

          emit(
            state.copyWith(
              postList: newPostList,
              status: PostStatus.success,
              message: 'success',
              page: state.page + 1,
            ),
          );
        }
      }).onError((error, stackTrace) {
        emit(
          state.copyWith(status: PostStatus.error, message: error.toString()),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.error, message: e.toString()),
      );
    }
  }

  void _onSearch(SearchEvent event, Emitter<PostState> emit) {
    // temPostList = state.postList.where((map)=>map.id.toString() == event.stText).toList();

    temPostList = state.postList
        .where((e) => e.email
            .toString()
            .toLowerCase()
            .contains(event.stText.toLowerCase()))
        .toList();
    if (event.stText.isEmpty) {
      emit(state.copyWith(temPostList: [], response: ''));
    } else {
      if (temPostList.isEmpty) {
        emit(state.copyWith(temPostList: [], response: 'No Data Found'));
      } else {
        emit(state.copyWith(temPostList: temPostList));
      }
    }
  }
}
