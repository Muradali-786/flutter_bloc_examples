import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_bloc.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_event.dart';
import 'package:flutter_bloc_example/bloc/post_bloc/post_state.dart';
import 'package:flutter_bloc_example/utils/post_status.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Filter Api List Using Bloc'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        buildWhen: (previous, current) => previous.status != current.status && previous.page==1,
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case PostStatus.error:
              return Center(child: Text(state.message.toString()));
            case PostStatus.success:
              return CustomItem(controller: controller);
            default:
              return const SizedBox.shrink();
          }
        },
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
      buildWhen: (c, p) => c.hasMore != p.hasMore || c.status != p.status,
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Search With Email',
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  border: OutlineInputBorder()),
              onChanged: (e) {
                context
                    .read<PostBloc>()
                    .add(SearchEvent(stText: controller.text.toString()));
              },
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
                              child: CircularProgressIndicator(),
                            );
                          }
                          final e = state.temPostList.isEmpty
                              ? state.postList[index]
                              : state.temPostList[index];
                          return Card(
                            child: ListTile(
                              leading: Text(e.id.toString()),
                              title: Text(e.email.toString()),
                              subtitle: Text(e.body.toString()),
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
