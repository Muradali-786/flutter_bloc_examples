import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_event.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_state.dart';
import 'package:flutter_bloc_example/repository/repository.dart';
import 'package:flutter_bloc_example/utils/post_status.dart';

import '../../model/post_model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  Repository repository = Repository();
  List<PostModel> temPostList = [];
  PostBloc() : super(const PostState()) {
    on<FetchEvent>(_fetchPostApi);
    on<SearchEvent>(_onSearch);
  }

  void _fetchPostApi(FetchEvent event, Emitter<PostState> emit) async {
    await repository.fetchApi().then((value) {
      emit(
        state.copyWith(
            postList: value.toList(),
            status: PostStatus.success,
            message: 'success'),
      );
    }).onError((error, stackTrace) {
      emit(
        state.copyWith(status: PostStatus.error, message: error.toString()),
      );
    });
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
