abstract class TodoEvent {}

class FetchTodos extends TodoEvent {
  final int userId;
  FetchTodos(this.userId);
}