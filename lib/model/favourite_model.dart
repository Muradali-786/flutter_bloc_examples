import 'package:equatable/equatable.dart';

class FavouriteModel extends Equatable {
  final String? id;
  final String? value;
  final bool isFav;
  final bool isDeleting;

  const FavouriteModel({
    required this.id,
    required this.value,
    this.isFav = false,
    this.isDeleting = false,
  });
  FavouriteModel copyWith(
      {String? id, String? value, bool? isFav, bool? isDeleting}) {
    return FavouriteModel(
      id: id ?? this.id,
      value: value ?? this.value,
      isFav: isFav ?? this.isFav,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  @override
  List<Object?> get props => [id, value, isFav, isDeleting];
}
