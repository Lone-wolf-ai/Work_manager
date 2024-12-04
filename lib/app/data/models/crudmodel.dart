class Crudmodel {
  String? name, description; // Fixed typo in description
  double? price;

  Crudmodel({
    required this.name,
    this.description, // Fixed typo in description
    required this.price,
  });

  Crudmodel.fromMap(Map<String, dynamic> map) {
    if (map.containsKey("name")) {
      this.name = map["name"];
    }
    if (map.containsKey("description")) {
      this.description = map["description"];
    }
    if (map.containsKey("price")) {
      this.price = map["price"];
    }
  }
}