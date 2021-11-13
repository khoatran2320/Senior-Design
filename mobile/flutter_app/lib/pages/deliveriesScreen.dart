import 'package:flutter/material.dart';

import '/utils/colors.dart';
import '../widgets/deliveriesScreen/deliveriesScreenHeader.dart';
import '../widgets/deliveriesScreen/packageStatusCard.dart';


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

	List<Map> packages = [];

	void initState() {
		super.initState();
		getListOfPackages();	// Need to implement
	}

	// TODO: Implement getListOfPackages
	void getListOfPackages() {
		print("Getting list of packages");
		packages = dummyData;
	}

	void addDeliveryItemHandler() {
		// Add item to list
		print('addDeliveryItemHandler called');
	}

	@override
	Widget build(BuildContext context) {
		return ListView(
			padding: const EdgeInsets.all(25),
			children: [
				DeliveriesScreenHeader(addDeliveryItemHandler),
				...packages.map((package) => PackageStatusCard(
					package['itemName'],
					package['merchant'],
					package['status'],
					package['trackingNumber']
				)).toList()
			]
		);
	}
}
