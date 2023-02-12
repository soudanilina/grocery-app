class HerbModel {
  String? name;
  String? image;
  double? price;
  int? quantity;

  HerbModel({this.name, this.image, this.price, this.quantity});

  HerbModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
