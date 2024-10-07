import 'package:equatable/equatable.dart';
import '../../model/post_model.dart';
import '../../utils/post_status.dart';

class PostState extends Equatable {
  final List<PostModel> postList;
  final List<PostModel> temPostList;
  final PostStatus status;
  final String message;
  final String response;
  final int limit;
  final int page;
  final bool hasMore;
  const PostState({
    this.postList = const <PostModel>[],
    this.temPostList = const <PostModel>[],
    this.status = PostStatus.initial,
    this.message = '',
    this.response = '',
    this.limit = 6,
    this.page = 1,
    this.hasMore = true,
  });

  PostState copyWith({
    List<PostModel>? postList,
    PostStatus? status,
    String? message,
    List<PostModel>? temPostList,
    String? response,
    int? limit,
    int? page,
    bool? hasMore,
  }) {
    return PostState(
        postList: postList ?? this.postList,
        temPostList: temPostList ?? this.temPostList,
        status: status ?? this.status,
        message: message ?? this.message,
        response: response ?? this.response,
        limit: limit ?? this.limit,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore);
  }

  @override
  List<Object?> get props =>
      [postList, status, message, temPostList, response, limit, page, hasMore];
}
