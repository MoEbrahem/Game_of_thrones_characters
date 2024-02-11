class Character {
  late int id;
  late String firstname;
  late String lastname;
  late String fullname;
  late String title;
  late String family;
  late String image;
  late String imageURL;

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstName'];
    lastname = json['lastName'];
    fullname = json['fullName'];
    title = json['title'];
    family = json['family'];
    image = json['image'];
    imageURL = json['imageUrl'];
  }
}

// class Quotes {
//   late List<String>? quote;
//   late String name;

//   Quotes.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     quote = json['quotes'];
//   }
// }
