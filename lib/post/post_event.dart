import '../model/post_model.dart';

abstract class PostEvent {}

class FetchPosts extends PostEvent {
  final int userId;
  FetchPosts(this.userId);
}

class AddLocalPost extends PostEvent {
  final PostModel post;
  AddLocalPost(this.post);
}