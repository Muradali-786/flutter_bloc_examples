import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class FetchEvent extends PostEvent {}

class SearchEvent extends PostEvent {
  String stText;
  SearchEvent({this.stText = ''});

  @override
  List<Object?> get props => [stText];
}
