import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/package.dart';
import '/models/package_list_model.dart';
import '/utils/colors.dart';
import '/widgets/deliveries_screen/add_package_form.dart';
import '/widgets/deliveries_screen/deliveries_screen_header.dart';
import '/widgets/deliveries_screen/package_status_card.dart';


// TODO: consumer for package list model
class DeliveriesScreen extends StatefulWidget {
  const DeliveriesScreen({Key? key}) : super(key: key);

  @override
  _DeliveriesScreenState createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> {

  void addDeliveryItemHandler(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 330,
            child: AddPackageForm()
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
          child: DeliveriesScreenHeader(addDeliveryItemHandler),
        ),
        Expanded(
          child: Consumer<PackageListModel>(
            builder: (context, packageListModel, child) {
              return packageListView(context, packageListModel.packageList);
            }
          )
        )
      ],
    );
  }
}

Widget packageListView(BuildContext context, List<Package> packageList) {
  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: ListView.builder(
      itemCount: packageList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: PackageStatusCard(
            Package(
              packageList[index].itemName,
              packageList[index].merchant,
              packageList[index].status,
              packageList[index].trackingNum
            )
          ),
        );
      },
    )
  );
}
