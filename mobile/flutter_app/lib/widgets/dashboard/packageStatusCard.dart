import 'package:flutter/material.dart';

import '/utils/colors.dart';


class PackageStatusCard extends StatefulWidget {
	const PackageStatusCard({Key? key}): super(key: key);

	@override
	_PackageStatusCardState createState() => _PackageStatusCardState();
}

class _PackageStatusCardState extends State<PackageStatusCard> {

	final deliveryIcon = {
		"delivered": Icons.check_circle,
		"shipped": Icons.local_shipping,
		"pending": Icons.pending
	};

	final TextStyle itemNameStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 16,
		fontWeight: FontWeight.w700,
	);

	final TextStyle textStyle = TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 14
	);

	// TODO: Write dummy function for retrieving package details from dummy api
	// Temporary dummy code
	String itemName = 'Item Name';
	String merchant = 'Merchant';
	String status = 'delivered';
	String trackingNumber = '123456789876543';

	@override
	Widget build(BuildContext context) {
		double screenWidth = MediaQuery.of(context).size.width;

		return Container(
			decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
				color: Color(0xff4B89AC),
      ),
			height: 120,
			width: screenWidth - 50,
			margin: EdgeInsets.only(top: 15, bottom: 0),
			padding: EdgeInsets.only(top: 10, left: 15, bottom: 13),
			child: Stack(
				children: [
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(
								"Item: $itemName",
								style: itemNameStyle
							),
							Spacer(),
							Text(
								"Merchant: $merchant",
								style: textStyle
							),
							Spacer(),
							Text(
								"Status: ${status[0].toUpperCase()}${status.substring(1)}",
								style: textStyle
							),
							Spacer(),
							Text(
								"Tracking: $trackingNumber",
								style: textStyle
							)
						]
					),
					Positioned(
						top: 0,
						bottom: 0,
						right: 15,
						child: Icon(
							deliveryIcon[status],
							color: Color(0xffE4FCF9),
							size: 40
						)
					)
				]
			)
		);
	}
}
