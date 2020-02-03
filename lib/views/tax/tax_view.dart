library tax_view;

import 'package:gst_demo/core/models/tax_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'tax_view_model.dart';

part 'tax_mobile.dart';
part 'tax_tablet.dart';
part 'tax_desktop.dart';

class TaxView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaxViewModel viewModel = TaxViewModel(hiveService: Provider.of(context));
    return ViewModelProvider<TaxViewModel>.withConsumer(
        viewModel: viewModel,
        onModelReady: (viewModel) {
          viewModel.getData();
        },
        builder: (context, viewModel, child) {
          return ScreenTypeLayout(
            mobile: _TaxMobile(viewModel),
            // desktop: _TaxDesktop(viewModel),
            // tablet: _TaxTablet(viewModel),
          );
        });
  }
}
