import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import '/utils/colors.dart';
import '/widgets/deliveries_screen/add_package_form.dart';
import '/widgets/deliveries_screen/deliveries_screen_header.dart';
import '/widgets/deliveries_screen/package_status_card.dart';

class Package {
  final String itemName;
  final String merchant;
  final String status;
  final String trackingNum;

  Package({
    required this.itemName,
    required this.merchant,
    required this.status,
    required this.trackingNum,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
        itemName: json['itemName'],
        merchant: json['merchant'],
        status: json['status'],
        trackingNum: json['trackingNum']);
  }
}

class DeliveriesScreen extends StatefulWidget {
  const DeliveriesScreen({Key? key}) : super(key: key);

  @override
  _DeliveriesScreenState createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> {

  late Future<List<Package>> packages;

  @override
  void initState() {
    super.initState();
    packages = fetchPackages();
  }

  Future<List<Package>> fetchPackages() async {
    List<Package> fetchedPackages = [];

    String? userId = FirebaseAuth.instance.currentUser?.uid;
    final response = await http.get(Uri.parse(
        'http://localhost:3000/packages?userId=$userId'));

    if (response.statusCode == 200) {
      var responsePackages = jsonDecode(response.body);
      responsePackages.forEach((k, v) =>
          fetchedPackages.add(Package.fromJson({
            'itemName': k,
            'merchant': k,
            'status': v['status_description'],
            'trackingNum': k,
          })));

      return fetchedPackages;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load packages');
    }
  }

  void addDeliveryItemHandler(context) {
    // Add item to list
    print('addDeliveryItemHandler called');

    _showAddDeliveryItemDialog(context);
  }

  void _showAddDeliveryItemDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // TODO: Maybe return null to close dialog
        return Dialog(
          child: Container(
            height: 300,
            child: AddPackageForm()
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder(
      future: packages,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('loading...');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return createListView(context, snapshot);
            }
        }
      },
    );
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
          child: DeliveriesScreenHeader(addDeliveryItemHandler),
        ),
        Expanded(child: futureBuilder)
      ],
    );
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Package> values = snapshot.data;
  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: PackageStatusCard(values[index].itemName, values[index].merchant,
              values[index].status, values[index].trackingNum),
        );
      },
    )
  );
}
