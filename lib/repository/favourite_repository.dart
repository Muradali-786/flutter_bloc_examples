import 'package:flutter_bloc_example/model/favourite_model.dart';

class FavouriteRepository {
  Future<List<FavouriteModel>> fetchItemList() async {
    await Future.delayed(const Duration(seconds: 3));
    return List.of(_generateItemList(10));
  }

  List<FavouriteModel> _generateItemList(int length) {
    return List.generate(
      length,
      (item) => FavouriteModel(
        id: item.toString(),
        value: "item$item",
      ),
    );
  }
}
