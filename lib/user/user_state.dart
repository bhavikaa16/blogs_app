 import 'package:equatable/equatable.dart';
import 'package:proj_bloc/model/post_model.dart';
import 'package:proj_bloc/model/to_do_model.dart';

 import 'package:proj_bloc/user/user_bloc.dart';
 import 'package:proj_bloc/user/user_event.dart';
 import 'package:proj_bloc/user/user_state.dart';


 import '../model/user_model.dart';

 abstract class  UserState extends Equatable{
const UserState();
  @override

  List<Object?> get props=>[];
}

class UserLoading extends UserState{}

class UserSuccess extends UserState {
  final List<User>users;
  final bool hasMore;
  final int skip;
  final String searchQuery;

  const UserSuccess({
    required this.users,
    required this.hasMore,
    required this.skip,
    this.searchQuery = '',
  });

  UserSuccess copyWith({
    List<User>? users,
    bool? hasMore,
    int? skip,
    String? searchQuery,

  }) {return UserSuccess(users: users?? this.users,
      hasMore: hasMore?? this.hasMore,
      skip: skip?? this.skip,
      searchQuery: searchQuery?? this.searchQuery,);


  }
  @override
  // TODO: implement props
  List<Object?> get props => [users,hasMore,skip,searchQuery];

}
class UserDetailLoaded extends UserState{
   final User user;
   final List<PostModel>posts;
   final List<TodoModel>todos;

   const UserDetailLoaded({
     required this.user,
     required this.posts,
     required this.todos,
});
   @override
  // TODO: implement props
  List<Object?> get props => [user,posts,todos];

}
class PostCreated extends UserState{
   final PostModel newPost;
   const PostCreated(this.newPost);
   @override
  // TODO: implement props
  List<Object?> get props => [newPost];

}
class UserError extends UserState{
   final String message;
   const UserError(this.message);
   @override
  // TODO: implement props
  List<Object?> get props => [message];
}

