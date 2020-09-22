// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductTableAdapter extends TypeAdapter<ProductTable> {
  @override
  final int typeId = 3;

  @override
  ProductTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductTable(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      categoryId: fields[3] as int,
      subcategoryId: fields[4] as int,
      baseQuantity: fields[5] as double,
      salesUnit: fields[6] as String,
      amount: fields[7] as double,
      discountedAmount: fields[8] as double,
      imageUrl: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductTable obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.subcategoryId)
      ..writeByte(5)
      ..write(obj.baseQuantity)
      ..writeByte(6)
      ..write(obj.salesUnit)
      ..writeByte(7)
      ..write(obj.amount)
      ..writeByte(8)
      ..write(obj.discountedAmount)
      ..writeByte(9)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
