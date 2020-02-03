library sale_view;

import 'package:gst_demo/core/models/purchase_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'sale_view_model.dart';

part 'sale_mobile.dart';
part 'sale_tablet.dart';
part 'sale_desktop.dart';

class SaleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SaleViewModel viewModel = SaleViewModel(
      hiveService: Provider.of(context),
    );
    return ViewModelProvider<SaleViewModel>.withConsumer(
        viewModel: viewModel,
        onModelReady: (viewModel) {
          viewModel.init();
        },
        builder: (context, viewModel, child) {
          return ScreenTypeLayout(
            mobile: _SaleMobile(viewModel),
            // desktop: _SaleDesktop(viewModel),
            // tablet: _SaleTablet(viewModel),
          );
        });
  }
}
