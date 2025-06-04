import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent{
  final bool isInitial;
  const FetchUsers({this.isInitial=false});
  @override
  // TODO: implement props
  List<Object?> get props => [isInitial];
  }



class SearchUsers extends UserEvent{
  final String query;
  const SearchUsers(this.query);

  @override
  // TODO: implement hashCode
  List<Object?> get props=>[query];
}

class LoadMoreUsers extends UserEvent{
  const LoadMoreUsers();
}