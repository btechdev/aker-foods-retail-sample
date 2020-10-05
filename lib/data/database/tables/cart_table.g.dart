// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartTableAdapter extends TypeAdapter<CartTable> {
  @override
  final int typeId = 1;

  @override
  CartTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartTable(
      promoCode: fields[0] as String,
      paymentMode: fields[1] as int,
      deliveryAddress: fields[2] as String,
      products: (fields[3] as List)?.cast<CartProductTable>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartTable obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.promoCode)
      ..writeByte(1)
      ..write(obj.paymentMode)
      ..writeByte(2)
      ..write(obj.deliveryAddress)
      ..writeByte(3)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
