import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_bloc/theme_cubit.dart';
import 'package:proj_bloc/user/user_bloc.dart';
import 'package:proj_bloc/user/user_event.dart';
import 'package:proj_bloc/user/user_state.dart';

class Userlistscreen extends StatefulWidget {


  const Userlistscreen({Key? key}):super(key: key);

  @override
  State<Userlistscreen> createState() => _UserlistscreenState();
}

class _UserlistscreenState extends State<Userlistscreen> {
  final ScrollController _scrollController=ScrollController();
  final TextEditingController _searchController=TextEditingController();
  @override

  void initState(){
    super.initState();
    context.read<UserBloc>().add(FetchUsers(isInitial: true));
    _scrollController.addListener(_onScroll);

  }
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300) {
      final state = context.read<UserBloc>().state;
      if (state is UserSuccess && state.hasMore) {
        context.read<UserBloc>().add(FetchUsers(isInitial: false));
      }
    }
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      context.read<UserBloc>().add(FetchUsers(isInitial: true));
    } else {
      context.read<UserBloc>().add(SearchUsers(query));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [

          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              final currentMode = context.read<ThemeCubit>().state;
              context.read<ThemeCubit>().toggleTheme();
            },
          ),



          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/create-post');
          }, icon: const Icon(Icons.add)),
        ],
        title: Text('Users'),

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by name...',
                hintStyle: TextStyle(fontSize: 15),
                prefixIcon: Icon(Icons.search),
            
            
              ),
                    onChanged: _onSearch,),
          ),
Expanded(child: 
          BlocBuilder<UserBloc,UserState>(
  builder:(context,state){
    if(state is UserLoading){
      return Center(child: const CircularProgressIndicator());
    }
    else if(state is UserError){
      return Center(child: Text(state.message));
    }
    else if(state is UserSuccess){
      if (state.users.isEmpty) {
        return const Center(child: Text('No users found.'));
      }
      else{
      return ListView.builder(controller: _scrollController,

    itemCount: state.users.length+(state.hasMore ? 1:0),
    itemBuilder: (context,index)
    {
        if(index>=state.users.length){
    return const Padding(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Center(child: SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(strokeWidth: 2),),
    ), );}

    final user = state.users[index];
        return ListTile(
        leading :CircleAvatar(backgroundImage:NetworkImage(user.image)),
       title :Text('${user.firstName} ${user.lastName}'),
       subtitle:Text(user.email),
       onTap:(){Navigator.pushNamed(context,'/user-detail',arguments:user,
    );
    }
    );

    },
    );}}
    return const SizedBox();}),)],),
    );}


    @override
    void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
    }
  }
    

          


