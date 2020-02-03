import 'package:flutter/material.dart';
import 'package:gst_demo/core/base/base_view_model.dart';
import 'package:gst_demo/core/models/purchase_model.dart';
import 'package:gst_demo/core/services/hive_service.dart';
import 'package:gst_demo/core/services/navigator_service.dart';
import 'package:gst_demo/views/purchase/purchase_view.dart';

class PurchaseListViewModel extends BaseViewModel {
  final NavigatorService _navigatorService;
  final HiveService _hiveService;

  List<PurchaseModel> _purchaseList = [];

  PurchaseListViewModel({
    @required HiveService hiveService,
    @required NavigatorService navigatorService,
  })  : _hiveService = hiveService,
        this._navigatorService = navigatorService;

  List<PurchaseModel> get purchaseModels => this._purchaseList;
  set purchaseModels(List<PurchaseModel> models) {
    this._purchaseList = models;
    notifyListeners();
  }

  Future loadPurchases() async {
    log.i('loadPurchase');
    purchaseModels = await _hiveService.getPurchases();
    purchaseModels.sort((p1, p2) {
      return p1.dateTime.compareTo(p2.dateTime);
    });
  }

  void navigateToAddPurchase() async {
    log.i('navigateToAddPurchase');
    await _navigatorService.navigateToPage(
      MaterialPageRoute(
        builder: (context) {
          return PurchaseView();
        },
      ),
    );
    loadPurchases();
  }
}
