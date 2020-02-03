import 'package:flutter/material.dart';
import 'package:gst_demo/core/base/base_view_model.dart';
import 'package:gst_demo/core/services/hive_service.dart';
import 'package:gst_demo/core/services/navigator_service.dart';
import 'package:gst_demo/views/purchase_list/purchase_list_view.dart';
import 'package:gst_demo/views/sale/sale_view.dart';
import 'package:gst_demo/views/tax/tax_view.dart';

class HomeViewModel extends BaseViewModel {
  final NavigatorService _navigatorService;
  final HiveService _hiveService;

  HomeViewModel({
    @required NavigatorService navigatorService,
    @required HiveService hiveService,
  })  : this._navigatorService = navigatorService,
        this._hiveService = hiveService;

  void navigateToPurchase() {
    _navigate(PurchaseListView());
  }

  void navigateToSale() {
    _navigate(SaleView());
  }

  void navigateToTax() {
    _navigate(TaxView());
  }

  void clear() {
    log.i('clear');
    _hiveService.clearData();
  }

  void _navigate(Widget page) {
    _navigatorService.navigateToPage(MaterialPageRoute(
      builder: (context) => page,
    ));
  }
}
