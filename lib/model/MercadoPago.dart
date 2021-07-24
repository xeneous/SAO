class Item {
  final String title;
  final String description;
  final int quantity;
  final String currencyId;
  final double unitPrice;

  Item(
      {this.title,
      this.description,
      this.quantity,
      this.currencyId,
      this.unitPrice});

  factory Item.fromJson(Map<String, dynamic> data) {
    return Item(
        title: data["title"],
        description: data["description"],
        quantity: data["quantity"],
        currencyId: data["currencyId"],
        unitPrice: data["unitPrice"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "quantity": quantity,
      "currencyId": currencyId,
      "unitPrice": unitPrice
    };
  }
}

class Payer {
  final String email;

  Payer({this.email});

  factory Payer.fromJson(Map<String, dynamic> data) {
    return Payer(
      email: data["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}

class Order {
  final Item items;
  final Payer payer;

  Order({this.items, this.payer});

  factory Order.fromJson(Map<String, dynamic> data) {
    return Order(
        items: Item.fromJson(data['item']),
        payer: Payer.fromJson(data['payer']));
  }

  Map<String, dynamic> toJson() {
    return {"items": items, "payer": payer};
  }
}
