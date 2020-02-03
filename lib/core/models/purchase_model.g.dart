// GENERATED CODE - DO NOT MODIFY BY HAND

part of purchase_model;

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PurchaseModelAdapter extends TypeAdapter<PurchaseModel> {
  @override
  final typeId = 0;

  @override
  PurchaseModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PurchaseModel(
      cgst: fields[3] as num,
      dateTime: fields[6] as DateTime,
      igst: fields[5] as num,
      itemId: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as num,
      sgst: fields[4] as num,
    );
  }

  @override
  void write(BinaryWriter writer, PurchaseModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.itemId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.cgst)
      ..writeByte(4)
      ..write(obj.sgst)
      ..writeByte(5)
      ..write(obj.igst)
      ..writeByte(6)
      ..write(obj.dateTime);
  }
}
