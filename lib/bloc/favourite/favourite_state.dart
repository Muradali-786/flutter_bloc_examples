import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_example/model/favourite_model.dart';

enum ListStatus { loading, success, failure }

class FavouriteState extends Equatable {
  final List<FavouriteModel> favouriteList;
  final List<FavouriteModel> tempFavouriteList;
  final ListStatus listStatus;

  const FavouriteState({
    this.favouriteList = const [],
    this.tempFavouriteList = const [],
    this.listStatus = ListStatus.loading,
  });
  FavouriteState copyWith(
      {List<FavouriteModel>? favouriteList,
      ListStatus? listStatus,
      List<FavouriteModel>? tempFavouriteList}) {
    return FavouriteState(
        favouriteList: favouriteList ?? this.favouriteList,
        tempFavouriteList: tempFavouriteList ?? this.tempFavouriteList,
        listStatus: listStatus ?? this.listStatus);
  }

  @override
  List<Object?> get props => [favouriteList, listStatus,tempFavouriteList];
}
