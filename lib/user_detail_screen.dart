import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_bloc/model/post_model.dart';
import 'package:proj_bloc/model/to_do_model.dart';
import 'package:proj_bloc/post/post_bloc.dart';
import 'package:proj_bloc/post/post_event.dart';
import 'package:proj_bloc/post/post_state.dart';
import 'package:proj_bloc/post_screen.dart';
import 'package:proj_bloc/theme_cubit.dart';
import 'package:proj_bloc/todo/todo_bloc.dart';
import 'package:proj_bloc/todo/todo_event.dart';
import 'package:proj_bloc/todo/todo_state.dart';

import 'model/user_model.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});



  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {


  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPosts(widget.user.id));
    context.read<TodoBloc>().add(FetchTodos(widget.user.id));
  }
  Future<void> _refreshData() async {
    context.read<PostBloc>().add(FetchPosts(widget.user.id));
    context.read<TodoBloc>().add(FetchTodos(widget.user.id));
  }


        void _navigateToCreatePost() async {

      final newPost = await Navigator.push<PostModel>(
            context,
            MaterialPageRoute(
              builder: (_) => PostScreen(user: widget.user),
            ),
          );

          if (newPost != null) {
            context.read<PostBloc>().add(AddLocalPost(newPost));
          }
        }
  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
          length: 2,
          child:Scaffold(
        appBar: AppBar(
        title: Text('${widget.user.firstName} ${widget.user.lastName}'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ],
          bottom: const TabBar(
        tabs: [
        Tab(text: 'Posts'),
            Tab(text: 'Todos'),
            ],
              labelColor: Colors.white,            // Color for the selected tab text
              unselectedLabelColor: Colors.grey
            ,
          ),
      ),
    floatingActionButton: FloatingActionButton(
    onPressed: _navigateToCreatePost,
    child: const Icon(Icons.add),
    ),
    body:  RefreshIndicator(
    onRefresh: _refreshData,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const SizedBox(height: 16),
    Row(mainAxisAlignment: MainAxisAlignment.start,
      children: [ Padding(
    padding: const EdgeInsets.all(8.0),

      child: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(widget.user.image),
      ),
    ),

        const SizedBox(height: 10,width: 15,),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(widget.user.fullName,style: Theme
              .of(context)
              .textTheme
              .bodyLarge),
          Text(widget.user.email, style: Theme
              .of(context)
              .textTheme
              .bodyLarge),
        ]),],),


    const SizedBox(height: 20),
    Expanded(
    child: TabBarView(
    children: [
    BlocBuilder<PostBloc, PostState>(
    builder: (context, state) {
    if (state is PostLoading) {
    return const Center(child: CircularProgressIndicator());
    } else if (state is PostLoaded) {
    if (state.posts.isEmpty) {
    return const Center(child: Text("No posts found."));
    }
    return ListView.builder(
    itemCount: state.posts.length,
    itemBuilder: (context, index) {
    final post = state.posts[index];
    return ListTile(
    title: Text(post.title),
    subtitle: Text(post.body),
    );
    },
    );
    } else if (state is PostError) {
    return Center(child: Text(state.message));
    } else {
    return const Center(child: Text("No data"));
    }
    },
    ),
    BlocBuilder<TodoBloc, TodoState>(
    builder: (context, state) {
    if (state is TodoLoading) {
    return const Center(child: CircularProgressIndicator());
    } else if (state is TodoLoaded) {
    if (state.todos.isEmpty) {
    return const Center(child: Text("No todos found."));
    }
    return ListView.builder(
    itemCount: state.todos.length,
    itemBuilder: (context, index) {
    final todo = state.todos[index];
    return CheckboxListTile(
    title: Text(todo.todo),
    value: todo.completed,
    onChanged: null, // readonly
    );
    },
    );
    } else if (state is TodoError) {
    return Center(child: Text(state.message));
    } else {
    return const Center(child: Text("No data"));
    }
    },
    ),
    ],
    ),
    ),
    ],
    ),
    ),

          ));
    }
}