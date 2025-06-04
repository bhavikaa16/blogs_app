import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:proj_bloc/user/user_event.dart';
import 'package:proj_bloc/user/user_state.dart';
import 'package:proj_bloc/user_repository.dart';

import '../model/user_model.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  final  UserRepository userRepository;
  List<User>_allUsers=[];
  int _skip=0;
  final int _limit=10;
  bool _hasMore=true;
  bool _isFetching = false;

  UserBloc(this.userRepository):super(UserLoading()){
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void>_onFetchUsers(FetchUsers event,Emitter<UserState>emit)async{
    if (_isFetching || (!_hasMore && !event.isInitial)) return;

    _isFetching = true;

    try{
      if(event.isInitial){
        emit(UserLoading());
        _skip=0;
        _hasMore=true;
        _allUsers.clear();
      }
      if(!_hasMore)return;
      final response = await userRepository.fetchUsers(limit: _limit,skip:  _skip);
      print("🟣 Fetching users with skip=$_skip, limit=$_limit");
      print("🟣 Response users length: ${response.length}");
      _allUsers.addAll(response);
      _skip += _limit;
      _hasMore = response.length == _limit;
      emit(UserSuccess(users: _allUsers, hasMore: _hasMore, skip: _skip));
    } catch (e) {
      emit(UserError("Failed to load users: $e"));
    }
    finally {
      _isFetching = false;
    }
  }
  Future<void>_onSearchUsers(SearchUsers event,Emitter<UserState>emit)async{
    try{
      emit(UserLoading());
      if (_allUsers.isEmpty && _skip == 0) {
        final response = await userRepository.fetchUsers(limit: _limit, skip: 0);
        _allUsers.addAll(response);
        _skip += _limit;
        _hasMore = response.length == _limit;
      }

      final query = event.query.toLowerCase();
      final results = _allUsers.where((user) =>
      user.firstName.toLowerCase().contains(query) ||
          user.lastName.toLowerCase().contains(query)).toList();

      emit(UserSuccess(users: results, hasMore: false, skip: 0));
    } catch (e) {
      emit(UserError("Search failed: $e"));
    }
  }
}
