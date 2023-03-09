import 'dart:convert';


import 'package:firebase_database/firebase_database.dart';

import '../model/post_model.dart';

class RTDBService{
  static final _database = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> addPost(Post post) async{
    _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }

  static Future<List<Post>> getPosts() async{
    List<Post> items = [];
    Query _query = _database.ref.child("posts");
    DatabaseEvent event = await _query.once();
    var snapshot = event.snapshot;

    for(var child in snapshot.children){
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(firstName: map['firstName'], lastname: map['lastname'], content: map['content'], data: map['data'], img_url: map['img_url']);
      items.add(post);
    }
    return items;
  }
}