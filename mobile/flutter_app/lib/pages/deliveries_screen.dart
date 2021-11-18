import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '/utils/colors.dart';
import '../widgets/deliveries_screen/deliveries_screen_header.dart';
import '../widgets/deliveries_screen/package_status_card.dart';

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
  List<Map> dummyData = [
    {
      'itemName': "Laptop",
      'merchant': "Amazon",
      'status': "delivered",
      'trackingNumber': "1234567894363"
    },
    {
      'itemName': "Mouse",
      'merchant': "eBay",
      'status': "pending",
      'trackingNumber': "1233467894987"
    },
    {
      'itemName': "Water 3",
      'merchant': "Amazon",
      'status': "delivered",
      'trackingNumber': "33333333333333"
    },
    {
      'itemName': "Water 4",
      'merchant': "eBay",
      'status': "pending",
      'trackingNumber': "444444444444444"
    },
    {
      'itemName': "Water 5",
      'merchant': "Amazon",
      'status': "delivered",
      'trackingNumber': "5555555555555555"
    },
    {
      'itemName': "Water 6",
      'merchant': "eBay",
      'status': "pending",
      'trackingNumber': "666666666666666"
    },
    {
      'itemName': "Water 7",
      'merchant': "Amazon",
      'status': "delivered",
      'trackingNumber': "7777777777777777"
    },
    {
      'itemName': "Water 8",
      'merchant': "eBay",
      'status': "pending",
      'trackingNumber': "888888888888888"
    }
  ];

  late Future<List<Package>> packages;

  @override
  void initState() {
    super.initState();
    packages = fetchPackages(); // Need to implement
  }

  // TODO: Implement getListOfPackages
  Future<List<Package>> fetchPackages() async {
    // packages = dummyData;
    List<Package> fetchedPackages = [];

    final response = await http.get(Uri.parse(
        'http://localhost:3000/packages?userId=GS63SvcscJTb81zaLFczJbul0hB3'));

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

  void addDeliveryItemHandler() {
    // Add item to list
    print('addDeliveryItemHandler called');
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
          padding: const EdgeInsets.all(25),
          child: DeliveriesScreenHeader(addDeliveryItemHandler),
        ),
        Expanded(child: futureBuilder)
      ],
    );
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Package> values = snapshot.data;
  return ListView.builder(
    itemCount: values.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: PackageStatusCard(values[index].itemName, values[index].merchant,
            values[index].status, values[index].trackingNum),
      );
    },
  );
}
