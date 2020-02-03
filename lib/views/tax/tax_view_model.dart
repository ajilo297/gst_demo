import 'package:flutter/material.dart';
import 'package:gst_demo/core/base/base_view_model.dart';
import 'package:gst_demo/core/models/purchase_model.dart';
import 'package:gst_demo/core/models/sales_model.dart';
import 'package:gst_demo/core/models/tax_model.dart';
import 'package:gst_demo/core/services/hive_service.dart';

class TaxViewModel extends BaseViewModel {
  final HiveService _hiveService;

  List<TaxModel> _data;

  TaxViewModel({
    @required HiveService hiveService,
  }) : this._hiveService = hiveService;

  List<TaxModel> get data => this._data ?? [];
  set data(List<TaxModel> model) {
    this._data = model;
    notifyListeners();
  }

  double get sumPrice => this
      .data
      .map<double>((d) {
        return d.price * (d.type == TxnType.PURCHASE ? -1 : 1);
      })
      .toList()
      .fold(0, (d1, d2) {
        return d1 + d2;
      });

  double get sumIgst => this
      .data
      .map<double>((d) {
        return d.igst * (d.type == TxnType.PURCHASE ? -1 : 1);
      })
      .toList()
      .fold(0, (d1, d2) {
        return d1 + d2;
      });

  double get sumSgst => this
      .data
      .map<double>((d) {
        return d.sgst * (d.type == TxnType.PURCHASE ? -1 : 1);
      })
      .toList()
      .fold(0, (d1, d2) {
        return d1 + d2;
      });

  double get sumCgst => this
      .data
      .map<double>((d) {
        return d.cgst * (d.type == TxnType.PURCHASE ? -1 : 1);
      })
      .toList()
      .fold(0, (d1, d2) {
        return d1 + d2;
      });

  double get sumTotal => this.sumCgst + sumIgst + sumSgst + sumPrice;

  void getData() async {
    log.i('getData');
    List<PurchaseModel> purchases = await _hiveService.getPurchases();
    List<SalesModel> sales = await _hiveService.getSales();

    List<TaxModel> taxModels = [];
    purchases.forEach((model) {
      TaxModel taxModel = TaxModel(
        cgst: model.cgst,
        dateTime: model.dateTime,
        igst: model.igst,
        itemId: model.itemId,
        name: model.name,
        price: model.price,
        sgst: model.sgst,
        type: TxnType.PURCHASE,
      );
      taxModels.add(taxModel);
    });

    sales.forEach((model) {
      TaxModel taxModel = TaxModel(
        cgst: model.cgst,
        dateTime: model.dateTime,
        igst: model.igst,
        itemId: model.itemId,
        name: model.name,
        price: model.price,
        sgst: model.sgst,
        type: TxnType.SALE,
      );
      taxModels.add(taxModel);
    });

    taxModels.sort((t1, t2) => t1.dateTime.compareTo(t2.dateTime));
    this.data = taxModels;
  }
}
