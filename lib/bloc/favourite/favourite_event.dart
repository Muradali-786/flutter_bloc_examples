import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_example/model/favourite_model.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object?> get props => [];
}

class FetchFavItemList extends FavouriteEvent {}

class FavItem extends FavouriteEvent {
  final FavouriteModel task;
  const FavItem({required this.task});
  @override
  List<Object?> get props => [task];
}

class CheckItem extends FavouriteEvent {
  final FavouriteModel modell;
  const CheckItem({required this.modell});
  @override
  List<Object?> get props => [modell];
}

class UnCheckItem extends FavouriteEvent {
  final FavouriteModel model;
  const UnCheckItem({required this.model});
  @override
  List<Object?> get props => [model];
}

class DeleteItemList extends FavouriteEvent {}
