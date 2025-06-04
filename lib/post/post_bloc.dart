import 'package:bloc/bloc.dart';
import 'package:proj_bloc/post/post_event.dart';
import 'package:proj_bloc/post/post_state.dart';

import '../user_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UserRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.fetchUserPosts(event.userId);
        emit(PostLoaded(posts));
      } catch (e, stacktrace) {
        print('PostBloc Error: $e\n$stacktrace');
        emit(PostError('Failed to load posts: ${e.toString()}'));
      }},);
    on<AddLocalPost>((event, emit) {
      if (state is PostLoaded) {
        final currentPosts = (state as PostLoaded).posts;
        emit(PostLoaded([event.post, ...currentPosts]));
      }
    });

  }}
