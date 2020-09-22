// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartProductTableAdapter extends TypeAdapter<CartProductTable> {
  @override
  final int typeId = 2;

  @override
  CartProductTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartProductTable(
      count: fields[0] as int,
      product: fields[1] as ProductTable,
    );
  }

  @override
  void write(BinaryWriter writer, CartProductTable obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartProductTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
