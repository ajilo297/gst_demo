import 'package:flutter/material.dart';
import 'package:gst_demo/core/base/base_view_model.dart';
import 'package:gst_demo/core/models/purchase_model.dart';
import 'package:gst_demo/core/models/sales_model.dart';
import 'package:gst_demo/core/models/tax_model.dart';
import 'package:gst_demo/core/services/hive_service.dart';

class TaxViewModel extends BaseViewModel {
  final HiveService _hiveService;
  DateTime _selectedDate = DateTime.now();

  List<TaxModel> _data;

  TaxViewModel({
    @required HiveService hiveService,
  }) : this._hiveService = hiveService;

  DateTime get selectedDate => this._selectedDate;
  set selectedDate(DateTime dateTime) {
    this._selectedDate = dateTime;
    notifyListeners();
    getData();
  }

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
    List<PurchaseModel> purchases =
        await _hiveService.getPurchases(dateTime: selectedDate);
    List<SalesModel> sales =
        await _hiveService.getSales(dateTime: selectedDate);

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

  void onYearChanged(int year) {
    log.i('onYearChanged: year: $year');
    DateTime dateTime = DateTime(year, selectedDate.month);
    selectedDate = dateTime;
  }

  void onMonthChanged(int month) {
    log.i('onMonthChanged: month: $month');
    DateTime dateTime = DateTime(selectedDate.year, month);
    selectedDate = dateTime;
  }

  String getMonthString(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Janurary';
    }
  }

  List<int> get validYears {
    List<int> years = [];

    for (int i = 2000; i <= DateTime.now().year; i += 1) {
      years.add(i);
    }

    return years;
  }

  List<int> get validMonths {
    List<int> months = [];

    for (int i = 1; i <= 12; i += 1) {
      months.add(i);
    }

    return months;
  }
}
