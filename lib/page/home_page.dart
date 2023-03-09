import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../service/auth_service.dart';
import '../service/rtdb_service.dart';
import 'create_page.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  Future _callCreatePage() async{
    Map results = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext contect){
      return CreatePage();
    }));

    if(results != null && results.containsKey('data')){
      print(results['data']);
      _apiPostList();
    }
  }

  _apiPostList() async{
    setState(() {
      isLoading = true;
    });
    var list = await RTDBService.getPosts();
    items.clear();
    setState(() {
      items = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
        actions: [
          IconButton(
              onPressed: (){
                AuthService.signOutUser(context);
              },
              icon: Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index){
              return itemOfPost(items[index]);
            },
          ),

          isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : SizedBox.shrink()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          _callCreatePage();
        },
      ),
    );
  }

  Widget itemOfPost(Post post){
    return  Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: EdgeInsets.only(right: 20),
            width: double.infinity,
            height: 150,
            child: post.img_url != null
                ? Image.network(post.img_url!, fit: BoxFit.cover,)
                :Image.asset("assets/images/ic_default.jpg", fit: BoxFit.cover,),
          ),

          Row(
            children: [
              Text(post.firstName!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

              SizedBox(width: 10,),

              Text(post.lastname!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(height: 10,),
          Text(post.data!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

          SizedBox(height: 10,),
          Text(post.content!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
