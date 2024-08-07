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
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PostStatus.error:
              return Center(child: Text(state.message.toString()));
            case PostStatus.success:
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
                  state.response.isEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: state.temPostList.isEmpty
                                ? state.postList.length
                                : state.temPostList.length,
                            itemBuilder: (context, index) {
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
                ],
              );
          }
        },
      ),
    );
  }
}
