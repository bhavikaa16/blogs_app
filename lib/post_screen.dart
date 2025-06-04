import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_bloc/model/post_model.dart';
import 'package:proj_bloc/model/user_model.dart';

class PostScreen extends StatefulWidget {
  final User user;
  const PostScreen({super.key, required this.user});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isSubmitting = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);


      final newPost = PostModel(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        body: _bodyController.text,
        userId: widget.user.id,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
      Navigator.pop(context, newPost);
    }
  }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
                validator: (value) => value!.isEmpty ? 'Enter body content' : null,
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? CircularProgressIndicator()
                    : const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
