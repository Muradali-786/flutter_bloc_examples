import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_bloc.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_event.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_state.dart';
import 'package:flutter_bloc_example/utils/post_status.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ApiExample extends StatefulWidget {
  const ApiExample({super.key});

  @override
  State<ApiExample> createState() => _ApiExampleState();
}

class _ApiExampleState extends State<ApiExample> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text('Pagination Using BLoC',style: TextStyle(color:Colors.black87),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<PostBloc, PostState>(
          buildWhen: (previous, current) =>
              previous.status != current.status && previous.page == 1,
          builder: (context, state) {
            switch (state.status) {
              case PostStatus.loading:
                return const Center(child: LoadingSpinner());

              case PostStatus.error:
                return Center(child: Text(state.message.toString()));
              case PostStatus.success:
                return CustomItem(controller: controller);
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class CustomItem extends StatelessWidget {
  final TextEditingController controller;
  const CustomItem({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      buildWhen: (c, p) => c.status != p.status,
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Search With Email',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  border: OutlineInputBorder()),
              onChanged: (e) {
                context
                    .read<PostBloc>()
                    .add(SearchEvent(stText: controller.text.toString()));
              },
            ),
            const SizedBox(
              height: 8,
            ),
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    state.status != PostStatus.loading) {
                  context.read<PostBloc>().add(FetchEvent());
                }
                return false;
              },
              child: state.response.isEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: state.temPostList.isEmpty
                            ? state.postList.length + (state.hasMore ? 1 : 0)
                            : state.temPostList.length,
                        itemBuilder: (context, index) {
                          if (index == state.postList.length && state.hasMore) {
                            return const Center(
                              child: LoadingSpinner(),
                            );
                          }
                          final e = state.temPostList.isEmpty
                              ? state.postList[index]
                              : state.temPostList[index];
                          return Card(
                            elevation: 3,
                            color: Colors.white,
                            child: ListTile(
                              dense: true,
                              leading: Text(
                                e.id.toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              title: Text(
                                e.email.toString(),
                                style: TextStyle(color: Color(0xff2845d1)),
                              ),
                              subtitle: Text(
                                e.body.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(state.response.toString()),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: SpinKitCircle(
        color: Color(0xff2845d1),
        size: 30.0,
      ),
    );
  }
}
