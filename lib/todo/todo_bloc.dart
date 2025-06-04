import 'package:bloc/bloc.dart';
import 'package:proj_bloc/todo/todo_event.dart';
import 'package:proj_bloc/todo/todo_state.dart';

import '../user_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserRepository repository;

  TodoBloc(this.repository) : super(TodoInitial()) {
    on<FetchTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await repository.fetchUserTodos(event.userId);
        emit(TodoLoaded(todos));
      } catch (e, stacktrace) {
        emit(TodoError('Failed to load todos: ${e.toString()}'));
      }
    });
  }
}

