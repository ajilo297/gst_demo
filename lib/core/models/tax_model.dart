class TaxModel {
  final String itemId;
  final String name;
  final num price;
  final num cgst;
  final num sgst;
  final num igst;
  final DateTime dateTime;
  final TxnType type;

  TaxModel({
    this.cgst,
    this.dateTime,
    this.igst,
    this.itemId,
    this.name,
    this.price,
    this.sgst,
    this.type,
  });
}

enum TxnType { SALE, PURCHASE }
