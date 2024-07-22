import 'package:equatable/equatable.dart';
import '../../model/post_model.dart';
import '../../utils/post_status.dart';

class PostState extends Equatable {
  final List<PostModel> postList;
  final List<PostModel> temPostList;
  final PostStatus status;
  final String message;
  final String response;
  const PostState(
      {this.postList = const <PostModel>[],
      this.temPostList = const <PostModel>[],
      this.status = PostStatus.loading,
      this.message = '',
      this.response = ''});

  PostState copyWith({
    List<PostModel>? postList,
    PostStatus? status,
    String? message,
    List<PostModel>? temPostList,
    String? response,
  }) {
    return PostState(
      postList: postList ?? this.postList,
      temPostList: temPostList ?? this.temPostList,
      status: status ?? this.status,
      message: message ?? this.message,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [postList, status, message, temPostList, response];
}
