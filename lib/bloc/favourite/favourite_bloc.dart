import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_example/bloc/favourite/favourite_event.dart';
import 'package:flutter_bloc_example/bloc/favourite/favourite_state.dart';
import 'package:flutter_bloc_example/model/favourite_model.dart';

import '../../repository/favourite_repository.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<FavouriteModel> favItemList = [];
  List<FavouriteModel> tempItemList = [];

  final FavouriteRepository favouriteRepository;
  FavouriteBloc({required this.favouriteRepository})
      : super(const FavouriteState()) {
    on<FetchFavItemList>(_fetchFavItemList);
    on<FavItem>(_addToFav);
    on<CheckItem>(_checkItem);
    on<UnCheckItem>(_unCheckItem);
    on<DeleteItemList>(_deleteItemList);
  }

  void _fetchFavItemList(
      FavouriteEvent event, Emitter<FavouriteState> states) async {
    favItemList = await favouriteRepository.fetchItemList();

    emit(
      state.copyWith(
        favouriteList: List.from(favItemList),
        listStatus: ListStatus.success,
      ),
    );
  }

  void _addToFav(FavItem event, Emitter<FavouriteState> states) {
    final index = favItemList.indexWhere((e) => e.id == event.task.id);

    if (event.task.isFav) {
      if (tempItemList.contains(favItemList[index])) {
        tempItemList.remove(favItemList[index]);
        tempItemList.add(event.task);
      }
    } else {
      if (tempItemList.contains(favItemList[index])) {
        tempItemList.remove(favItemList[index]);
        tempItemList.add(event.task);
      }
    }

    favItemList[index] = event.task;

    emit(state.copyWith(
      favouriteList: List.from(favItemList),
     tempFavouriteList: List.from( tempItemList),
    ));
  }

  void _checkItem(CheckItem event, Emitter<FavouriteState> states) {
    tempItemList.add(event.modell);

    emit(state.copyWith(
      tempFavouriteList: List.from(tempItemList),
    ));
  }

  void _unCheckItem(UnCheckItem event, Emitter<FavouriteState> states) {
    tempItemList.remove(event.model);

    emit(state.copyWith(
      tempFavouriteList: List.from(tempItemList),
    ));
  }

  void _deleteItemList(DeleteItemList event, Emitter<FavouriteState> states) {
    for (int i = 0; i < tempItemList.length; i++) {
      favItemList.remove(tempItemList[i]);
    }
    tempItemList.clear();

    emit(state.copyWith(
      favouriteList: List.from(favItemList),
      tempFavouriteList: List.from(tempItemList),
    ));
  }
}
