library purchase_model;

import 'package:hive/hive.dart';

part 'purchase_model.g.dart';

@HiveType(typeId: 0)
class PurchaseModel extends HiveObject {
  @HiveField(0)
  String itemId;
  @HiveField(1)
  String name;
  @HiveField(2)
  num price;
  @HiveField(3)
  num cgst;
  @HiveField(4)
  num sgst;
  @HiveField(5)
  num igst;
  @HiveField(6)
  DateTime dateTime;

  PurchaseModel({
    this.cgst,
    this.dateTime,
    this.igst,
    this.itemId,
    this.name,
    this.price,
    this.sgst,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (cgst != null) {
      map['cgst'] = cgst;
    }
    if (dateTime != null) {
      map['dateTime'] = dateTime;
    }
    if (igst != null) {
      map['igst'] = igst;
    }
    if (itemId != null) {
      map['itemId'] = itemId;
    }
    if (name != null) {
      map['name'] = name;
    }
    if (price != null) {
      map['price'] = price;
    }
    if (sgst != null) {
      map['sgst'] = sgst;
    }
    return map;
  }
}
