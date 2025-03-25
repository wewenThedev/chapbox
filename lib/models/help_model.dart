// To parse this JSON data, do
//
//     final shoppingDetails = shoppingDetailsFromJson(jsonString);
/*
import 'dart:convert';

ShoppingDetails shoppingDetailsFromJson(String str) => ShoppingDetails.fromJson(json.decode(str));

String shoppingDetailsToJson(ShoppingDetails data) => json.encode(data.toJson());

class ShoppingDetails {
    int id;
    int cartId;
    int shopId;
    int productId;
    DateTime addedAt;
    int quantity;
    String cost;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    dynamic orderId;
    Cart cart;
    Product product;
    Shop shop;
    dynamic order;

    ShoppingDetails({
        required this.id,
        required this.cartId,
        required this.shopId,
        required this.productId,
        required this.addedAt,
        required this.quantity,
        required this.cost,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.orderId,
        required this.cart,
        required this.product,
        required this.shop,
        required this.order,
    });

    ShoppingDetails copyWith({
        int? id,
        int? cartId,
        int? shopId,
        int? productId,
        DateTime? addedAt,
        int? quantity,
        String? cost,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic deletedAt,
        dynamic orderId,
        Cart? cart,
        Product? product,
        Shop? shop,
        dynamic order,
    }) => 
        ShoppingDetails(
            id: id ?? this.id,
            cartId: cartId ?? this.cartId,
            shopId: shopId ?? this.shopId,
            productId: productId ?? this.productId,
            addedAt: addedAt ?? this.addedAt,
            quantity: quantity ?? this.quantity,
            cost: cost ?? this.cost,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
            orderId: orderId ?? this.orderId,
            cart: cart ?? this.cart,
            product: product ?? this.product,
            shop: shop ?? this.shop,
            order: order ?? this.order,
        );

    factory ShoppingDetails.fromJson(Map<String, dynamic> json) => ShoppingDetails(
        id: json["id"],
        cartId: json["cart_id"],
        shopId: json["shop_id"],
        productId: json["product_id"],
        addedAt: DateTime.parse(json["added_at"]),
        quantity: json["quantity"],
        cost: json["cost"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        orderId: json["order_id"],
        cart: Cart.fromJson(json["cart"]),
        product: Product.fromJson(json["product"]),
        shop: Shop.fromJson(json["shop"]),
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "shop_id": shopId,
        "product_id": productId,
        "added_at": addedAt.toIso8601String(),
        "quantity": quantity,
        "cost": cost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "order_id": orderId,
        "cart": cart.toJson(),
        "product": product.toJson(),
        "shop": shop.toJson(),
        "order": order,
    };
}

class Cart {
    int id;
    int userId;
    String deviceId;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Cart({
        required this.id,
        required this.userId,
        required this.deviceId,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    Cart copyWith({
        int? id,
        int? userId,
        String? deviceId,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic deletedAt,
    }) => 
        Cart(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            deviceId: deviceId ?? this.deviceId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
        );

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["user_id"],
        deviceId: json["device_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "device_id": deviceId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}

class Product {
    int id;
    String name;
    int brandId;
    String description;
    int weight;
    int categoryId;
    String containerType;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Product({
        required this.id,
        required this.name,
        required this.brandId,
        required this.description,
        required this.weight,
        required this.categoryId,
        required this.containerType,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    Product copyWith({
        int? id,
        String? name,
        int? brandId,
        String? description,
        int? weight,
        int? categoryId,
        String? containerType,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic deletedAt,
    }) => 
        Product(
            id: id ?? this.id,
            name: name ?? this.name,
            brandId: brandId ?? this.brandId,
            description: description ?? this.description,
            weight: weight ?? this.weight,
            categoryId: categoryId ?? this.categoryId,
            containerType: containerType ?? this.containerType,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
        );

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        brandId: json["brand_id"],
        description: json["description"],
        weight: json["weight"],
        categoryId: json["category_id"],
        containerType: json["container_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brand_id": brandId,
        "description": description,
        "weight": weight,
        "category_id": categoryId,
        "container_type": containerType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}

class Shop {
    int id;
    String city;
    String phone;
    int addressId;
    int supermarketId;
    int shopManagerId;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Shop({
        required this.id,
        required this.city,
        required this.phone,
        required this.addressId,
        required this.supermarketId,
        required this.shopManagerId,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    Shop copyWith({
        int? id,
        String? city,
        String? phone,
        int? addressId,
        int? supermarketId,
        int? shopManagerId,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic deletedAt,
    }) => 
        Shop(
            id: id ?? this.id,
            city: city ?? this.city,
            phone: phone ?? this.phone,
            addressId: addressId ?? this.addressId,
            supermarketId: supermarketId ?? this.supermarketId,
            shopManagerId: shopManagerId ?? this.shopManagerId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
        );

    factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        city: json["city"],
        phone: json["phone"],
        addressId: json["address_id"],
        supermarketId: json["supermarket_id"],
        shopManagerId: json["shop_manager_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "phone": phone,
        "address_id": addressId,
        "supermarket_id": supermarketId,
        "shop_manager_id": shopManagerId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
*/
