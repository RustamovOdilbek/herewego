import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/post_model.dart';
import '../service/log_service.dart';
import '../service/rtdb_service.dart';
import '../service/stor_service.dart';

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

  File? _image;
  final picker = ImagePicker();

  _createPost(){
    String fullaname = firstNameController.text.toString();
    String lastname = lastnameController.text.toString();
    String content = contentController.text.toString();
    String data = dataController.text.toString();
    if(fullaname.isEmpty || lastname.isEmpty || content.isEmpty || data.isEmpty) return;


    _apiUploadImage(fullaname,  lastname,  content,  data);
  }

  _apiUploadImage(String fullaname, String lastname, String content, String data){
    LogService.e("Rerfe");
    setState(() {
      isLoading = true;
    });
    setState(() {
      isLoading = true;
    });

    StoreService.uploadImage(_image!).then((img_url) => {
      _apiCreatePost(fullaname,  lastname,  content,  data, img_url),
    });
  }
  _apiCreatePost(String fullaname, String lastname, String content, String data, String img_url){

    var post = Post(firstName: fullaname, lastname: lastname, content: content, data: data, img_url: img_url);

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

  Future _getImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        LogService.e("No image selected");
      }
    });

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
                GestureDetector(
                  onTap: (){
                    _getImage();
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    child: _image != null
                        ?  Image.file(_image!, fit: BoxFit.cover,)
                        : Image.asset("assets/images/ic_camera.png"),
                  ),
                ),

                SizedBox(height: 20,),

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
