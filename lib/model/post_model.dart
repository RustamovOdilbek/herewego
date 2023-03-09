class Post {
  String? firstName;
  String? lastname;
  String? content;
  String? data;

  Post({this.firstName, this.lastname, this.content, this.data});

  Post.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastname = json['lastname'];
    content = json['content'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastname'] = this.lastname;
    data['content'] = this.content;
    data['data'] = this.data;
    return data;
  }
}