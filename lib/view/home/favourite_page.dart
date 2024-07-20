import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/favourite/favourite_bloc.dart';
import 'package:flutter_bloc_example/bloc/favourite/favourite_event.dart';
import 'package:flutter_bloc_example/bloc/favourite/favourite_state.dart';
import 'package:flutter_bloc_example/model/favourite_model.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteBloc>().add(FetchFavItemList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite App'),
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              return Visibility(
                visible: state.tempFavouriteList.isNotEmpty ? true : false,
                child: IconButton(
                  onPressed: () {
                    context.read<FavouriteBloc>().add(DeleteItemList());
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          switch (state.listStatus) {
            case ListStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ListStatus.failure:
              return const Center(child: Text('Error'));
            case ListStatus.success:
              return ListView.builder(
                itemCount: state.favouriteList.length,
                itemBuilder: (context, index) {
                  final item = state.favouriteList[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                          value: state.tempFavouriteList.contains(item)?true:false,
                          onChanged: (val) {

                            if(val!){
                              context
                                  .read<FavouriteBloc>()
                                  .add(CheckItem(modell: item));
                            }else{
                              context
                                  .read<FavouriteBloc>()
                                  .add(UnCheckItem(model: item));
                            }

                          }),
                      title: Text(item.value.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          FavouriteModel model = FavouriteModel(
                            id: item.id,
                            value: item.value,
                            isFav: item.isFav ? false : true,
                            isDeleting: item.isDeleting,
                          );
                          context
                              .read<FavouriteBloc>()
                              .add(FavItem(task: model));
                        },
                        icon: Icon(item.isFav
                            ? Icons.favorite
                            : Icons.favorite_outline),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
