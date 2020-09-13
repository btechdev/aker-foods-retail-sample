class ProductEntity {
  final String id;
  final String name;
  final String quantity;
  final double price;
  final double discount;
  final double couponDiscount;
  final ProductStatus status;

  ProductEntity({
    this.id,
    this.name,
    this.quantity,
    this.price,
    this.discount,
    this.couponDiscount,
    this.status,
  });
}

enum ProductStatus { available, outOfStock, unknown }

extension ProductStatusExtension on ProductStatus {
  String getString() {
    switch (this) {
      case ProductStatus.available:
        return 'AVAILABLE';

      case ProductStatus.outOfStock:
        return 'OUT_OF_STOCK';

      default:
        return 'UNKNOWN';
    }
  }

  static ProductStatus getEnum(String status) {
    switch (status) {
      case 'AVAILABLE':
        return ProductStatus.available;

      case 'OUT_OF_STOCK':
        return ProductStatus.outOfStock;

      default:
        return ProductStatus.unknown;
    }
  }
}
