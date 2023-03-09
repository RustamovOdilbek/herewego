import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../service/rtdb_service.dart';

class CreatePage extends StatefulWidget {
  static final String id = "create_page";

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var isLoading = false;
  var firstNameController = TextEditingController();
  var lastnameController = TextEditingController();
  var contentController = TextEditingController();
  var dataController = TextEditingController();

  _createPost(){
    String fullaname = firstNameController.text.toString();
    String lastname = lastnameController.text.toString();
    String content = contentController.text.toString();
    String data = dataController.text.toString();
    if(fullaname.isEmpty || lastname.isEmpty || content.isEmpty || data.isEmpty) return;

    _apiCreatePost(fullaname, lastname, content, data);
  }

  _apiCreatePost(String fullaname, String lastname, String content, String data){
    setState(() {
      isLoading = true;
    });

    var post = Post(firstName: fullaname, lastname: lastname, content: content, data: data);

    RTDBService.addPost(post).then((value) => {
      _resAddPost(),
    });
  }
  _resAddPost(){
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: "Fullname",

                  ),
                ),

                SizedBox(height: 20,),

                TextField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    hintText: "lastname",

                  ),
                ),

                SizedBox(height: 20,),

                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: "content",

                  ),
                ),

                SizedBox(height: 20,),

                TextField(
                  controller: dataController,
                  decoration: InputDecoration(
                    hintText: "Data",

                  ),
                ),

                SizedBox(height: 20,),
                
                MaterialButton(
                    onPressed: (){
                      _createPost();
                    },
                  color: Colors.deepOrangeAccent,
                  child: Text("Add", style: TextStyle(color: Colors.white),),

                )
              ],
            ),

            isLoading ? Center(
              child: CircularProgressIndicator(),
            ) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
