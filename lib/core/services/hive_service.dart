import 'package:gst_demo/core/base/base_service.dart';
import 'package:gst_demo/core/models/purchase_model.dart';
import 'package:gst_demo/core/models/sales_model.dart';
import 'package:hive/hive.dart';

class HiveService extends BaseService {
  HiveService() {
    _init();
  }

  void _init() async {
    log.i('_init');

    Hive.registerAdapter(PurchaseModelAdapter());
    log.i('_init: register purchaseAdapter');
    Hive.registerAdapter(SalesModelAdapter());
    log.i('_init: register salesAdapter');

    await Hive.openBox<PurchaseModel>('purchase');
    log.i('_init: openPurchaseBox');
    await Hive.openBox<SalesModel>('sales');
    log.i('_init: openSalesBox');
  }

  Future<List<PurchaseModel>> getUnsoldItems() async {
    List<PurchaseModel> purchaseModels = await getPurchases();
    List<SalesModel> saleModels = await getSales();

    return purchaseModels.where((purchase) {
      bool isSold = false;
      for (SalesModel sale in saleModels) {
        if (sale.itemId == purchase.itemId) {
          isSold = true;
          break;
        }
      }
      return !isSold;
    }).toList();
  }

  Future<List<PurchaseModel>> getPurchases() async {
    Box<PurchaseModel> box = await Hive.openBox<PurchaseModel>('purchase');
    List<PurchaseModel> models = box.keys.map((k) {
      return box.get(k);
    }).toList();
    return models;
  }

  Future<List<SalesModel>> getSales() async {
    Box<SalesModel> box = await Hive.openBox<SalesModel>('sales');
    List<SalesModel> models = box.keys.map((k) {
      return box.get(k);
    }).toList();
    return models;
  }

  Future savePurchase(PurchaseModel model) async {
    Box<PurchaseModel> box = await Hive.openBox<PurchaseModel>('purchase');
    box.add(model);
  }

  Future saveSale(SalesModel model) async {
    Box<SalesModel> box = await Hive.openBox<SalesModel>('sales');
    box.add(model);
  }

  Future clearData() async {
    Box<PurchaseModel> purchaseBox = await Hive.openBox<PurchaseModel>('purchase');
    Box<SalesModel> saleBox = await Hive.openBox<SalesModel>('sales');
    purchaseBox.clear();
    saleBox.clear();
  }
}
