import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int? id;
  int? shoppingDetailsId; // Foreign key
  int? userId; // Foreign key
  String? guestFirstname;
  String? guestLastname;
  String? guestPhone;
  String? guestEmail;
  double? totalHt; // Montant total hors taxes
  double? totalTtc; // Montant total toutes taxes comprises
  DateTime? orderingDate;
  DateTime? shippingDate;
  String? shippingAddress;
  String? status;

  Order({this.id, this.shoppingDetailsId, this.userId, this.guestFirstname, this.guestLastname, this.guestPhone, this.guestEmail, this.totalHt, this.totalTtc, this.orderingDate, this.shippingDate, this.shippingAddress, this.status});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
