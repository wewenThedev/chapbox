import 'package:json_annotation/json_annotation.dart';
import 'user.dart';

//part 'generated/order.g.dart';
part 'order.g.dart';

enum RecoveryMode { pickup, delivery }

enum OrderStatus { pending, processing, failed, successful, canceled }

@JsonSerializable(explicitToJson: true)
class Order {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'guest_firstname', includeIfNull: false)
  final String? guestFirstname;

  @JsonKey(name: 'guest_lastname', includeIfNull: false)
  final String? guestLastname;

  @JsonKey(name: 'guest_phone', includeIfNull: false)
  final String? guestPhone;

  @JsonKey(name: 'guest_email', includeIfNull: false)
  final String? guestEmail;

  @JsonKey(name: 'total_ht')
  final double totalHt;

  @JsonKey(name: 'total_ttc')
  final double totalTtc;

  @JsonKey(name: 'ordering_date')
  final DateTime orderingDate;

  @JsonKey(name: 'shipping_date', includeIfNull: false)
  final DateTime? shippingDate;

  @JsonKey(name: 'recovery_mode', unknownEnumValue: RecoveryMode.delivery)
  final RecoveryMode recoveryMode;

  @JsonKey(name: 'shipping_address', includeIfNull: false)
  final String? shippingAddress;

  @JsonKey(name: 'status', unknownEnumValue: OrderStatus.pending)
  final OrderStatus status;

  // Relations
  @JsonKey(ignore: true)
  User? user;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  Order({
    required this.id,
    required this.userId,
    this.guestFirstname,
    this.guestLastname,
    this.guestPhone,
    this.guestEmail,
    required this.totalHt,
    required this.totalTtc,
    required this.orderingDate,
    this.shippingDate,
    this.recoveryMode = RecoveryMode.delivery,
    this.shippingAddress,
    this.status = OrderStatus.pending,
    this.user,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  // Helper pour le calcul de la TVA
  double get tvaAmount => totalTtc - totalHt;

  // Vérifie si c'est une commande guest
  bool get isGuestOrder => guestEmail != null || guestPhone != null;

  // Formatage de la date de commande
  String get formattedOrderDate =>
      '${orderingDate.day}/${orderingDate.month}/${orderingDate.year}';

  // Durée depuis la commande
  Duration get orderAge => DateTime.now().difference(orderingDate);

  // Méthode pour mettre à jour le statut
  Order copyWithStatus(OrderStatus newStatus) {
    return Order(
      id: id,
      userId: userId,
      totalHt: totalHt,
      totalTtc: totalTtc,
      orderingDate: orderingDate,
      status: newStatus,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      // ... autres champs
    );
  }
}

// Convertisseurs pour les enums
class RecoveryModeConverter extends JsonConverter<RecoveryMode, String> {
  const RecoveryModeConverter();

  @override
  RecoveryMode fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'pickup':
        return RecoveryMode.pickup;
      case 'delivery':
        return RecoveryMode.delivery;
      default:
        return RecoveryMode.delivery;
    }
  }

  @override
  String toJson(RecoveryMode object) => object.toString().split('.').last;
}

class OrderStatusConverter extends JsonConverter<OrderStatus, String> {
  const OrderStatusConverter();

  @override
  OrderStatus fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'processing':
        return OrderStatus.processing;
      case 'failed':
        return OrderStatus.failed;
      case 'successful':
        return OrderStatus.successful;
      case 'canceled':
        return OrderStatus.canceled;
      default:
        return OrderStatus.pending;
    }
  }

  @override
  String toJson(OrderStatus object) => object.toString().split('.').last;
}
