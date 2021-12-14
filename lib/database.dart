
class Grocery {
  final int? id;
  final String name;
  final String age;
  final String rollnum;
  final String mobile;

  Grocery({this.id, required this.name,required this.age,required this.rollnum,required this.mobile});

  factory Grocery.fromMap(Map<String, dynamic> json) =>Grocery(
    id: json['id'],
    name: json['name'],
    age: json['age'],
    rollnum : json['rollnum'],
    mobile: json['mobile'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age' : age,
      'rollnum' : rollnum,
      'mobile' : mobile,
    };
  }
}