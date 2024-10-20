import 'package:json_annotation/json_annotation.dart';

part 'generated/invoice.g.dart';

@JsonSerializable()

class Invoice {
  int? id;
  String? url;
  String? infos;

  Invoice({this.id, this.url, this.infos});

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}
