class Post {
  String? firstName;
  String? lastname;
  String? content;
  String? data;
  String? img_url;

  Post({this.firstName, this.lastname, this.content, this.data, this.img_url});

  Post.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastname = json['lastname'];
    content = json['content'];
    data = json['data'];
    img_url = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastname'] = this.lastname;
    data['content'] = this.content;
    data['data'] = this.data;
    data['img_url'] = this.img_url;
    return data;
  }
}