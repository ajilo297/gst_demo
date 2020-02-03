import 'package:flutter/material.dart';
import 'package:gst_demo/core/base/base_view_model.dart';
import 'package:gst_demo/core/models/purchase_model.dart';
import 'package:gst_demo/core/services/hive_service.dart';
import 'package:uuid_enhanced/uuid.dart';

class PurchaseViewModel extends BaseViewModel {
  final HiveService _hiveService;
  final GlobalKey<FormState> _formState = GlobalKey();
  String uuid;

  final TextEditingController cgstController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController igstController = TextEditingController();
  final TextEditingController itemIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sgstController = TextEditingController();

  PurchaseModel _purchaseModel;
  bool _isInterState;

  PurchaseViewModel({
    @required HiveService hiveService,
  }) : this._hiveService = hiveService {
    init();
  }

  GlobalKey<FormState> get formKey => this._formState;
  FormState get formState => this._formState.currentState;

  bool get isInterState => this._isInterState;
  set isInterState(bool value) {
    this._isInterState = value;
    this.updatePrice();
    notifyListeners();
  }

  set cgst(num cgst) {
    _purchaseModel.cgst = cgst;
    notifyListeners();
  }

  set dateTime(var dateTime) {
    _purchaseModel.dateTime = dateTime;
    notifyListeners();
  }

  set igst(num igst) {
    _purchaseModel.igst = igst;
    notifyListeners();
  }

  set itemId(String itemId) {
    _purchaseModel.itemId = uuid;
    notifyListeners();
  }

  set name(String name) {
    _purchaseModel.name = name;
    notifyListeners();
  }

  set price(num price) {
    _purchaseModel.price = price;
    notifyListeners();
  }

  set sgst(num sgst) {
    _purchaseModel.sgst = sgst;
    notifyListeners();
  }

  void init() {
    log.i('init');
    uuid = Uuid.randomUuid().toString();
    _purchaseModel = PurchaseModel();
    _isInterState = false;
    itemIdController.text = uuid.substring(0, 6);
    notifyListeners();
  }

  bool validate() {
    log.i('validate');
    if (formState == null) {
      log.e('validate: form state is null');
      return false;
    }
    return formState.validate();
  }

  void save() async {
    log.i('save');
    if (!validate()) {
      log.i('save: validation failed');
      return;
    }

    formState.save();
    _purchaseModel.toMap().forEach((k, v) {
      log.i('save: model: $k: ${v.toString()}');
    });

    await _hiveService.savePurchase(_purchaseModel);
    // clear();
    init();
  }

  void clear() {
    log.i('clear');
    cgstController.text = '';
    dateTimeController.text = '';
    igstController.text = '';
    itemIdController.text = '';
    nameController.text = '';
    priceController.text = '';
    sgstController.text = '';
    isInterState = false;
  }

  void updatePrice() {
    log.i('updatePrice');
    double price = double.tryParse(priceController.text);
    if (price == null) {
      log.i('updatePrice: invalid price');
      return;
    }
    if (isInterState) {
      igstController.text = '${price * 0.18}';
      sgstController.text = '0.0';
      cgstController.text = '0.0';
    } else {
      sgstController.text = '${price * 0.09}';
      cgstController.text = '${price * 0.09}';
      igstController.text = '0.0';
    }
  }
}
