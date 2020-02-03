library purchase_list_view;

import 'package:gst_demo/core/models/purchase_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'purchase_list_view_model.dart';

part 'purchase_list_mobile.dart';
part 'purchase_list_tablet.dart';
part 'purchase_list_desktop.dart';

class PurchaseListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PurchaseListViewModel viewModel = PurchaseListViewModel(
      hiveService: Provider.of(context),
      navigatorService: Provider.of(context),
    );
    return ViewModelProvider<PurchaseListViewModel>.withConsumer(
        viewModel: viewModel,
        onModelReady: (viewModel) {
          viewModel.loadPurchases();
        },
        builder: (context, viewModel, child) {
          return ScreenTypeLayout(
            mobile: _PurchaseListMobile(viewModel),
            // tablet: _PurchaseListTablet(viewModel),
            // desktop: _PurchaseListDesktop(viewModel),
          );
        });
  }
}
