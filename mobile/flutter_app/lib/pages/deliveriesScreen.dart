import 'package:flutter/material.dart';

import '/utils/colors.dart';
import '../widgets/dashboard/deliveriesScreenHeader.dart';
import '../widgets/dashboard/packageStatusCard.dart';


class DeliveriesScreen extends StatefulWidget {
	const DeliveriesScreen({Key? key}) : super(key: key);

	@override
	_DeliveriesScreenState createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> {

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
			child: Column(
				children: [
					DeliveriesScreenHeader(),
					PackageStatusCard()
				]
			)
		);
	}
}
