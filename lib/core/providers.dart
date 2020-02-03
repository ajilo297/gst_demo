import 'package:gst_demo/core/services/hive_service.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';
import 'package:provider/provider.dart';

class ProviderInjector {
  static List<SingleChildCloneableWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];

  static List<SingleChildCloneableWidget> _independentServices = [
    Provider.value(value: locator<NavigatorService>()),
    Provider.value(value: HiveService()),
  ];

  static List<SingleChildCloneableWidget> _dependentServices = [];

  static List<SingleChildCloneableWidget> _consumableServices = [];
}
