library purchase_view;

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'purchase_view_model.dart';

part 'purchase_mobile.dart';
part 'purchase_tablet.dart';
part 'purchase_desktop.dart';

class PurchaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PurchaseViewModel viewModel = PurchaseViewModel(
      hiveService: Provider.of(context),
    );
    return ViewModelProvider<PurchaseViewModel>.withConsumer(
        viewModel: viewModel,
        onModelReady: (viewModel) {
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return ScreenTypeLayout(
            mobile: _PurchaseMobile(viewModel),
            // desktop: _PurchaseDesktop(viewModel),
            // tablet: _PurchaseTablet(viewModel),
          );
        });
  }
}
