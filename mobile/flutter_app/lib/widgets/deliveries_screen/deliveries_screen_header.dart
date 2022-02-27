import 'package:flutter/material.dart';

import '/utils/colors.dart';
import 'package_status_card.dart';


class DeliveriesScreenHeader extends StatelessWidget {
	final Function addDeliveryItemHandler;
	final Function refreshPackageList;

	const DeliveriesScreenHeader(
		this.addDeliveryItemHandler, this.refreshPackageList, {Key? key}
	) : super(key: key);

	final TextStyle textStyle = const TextStyle(
		color: const Color(0xff446491),
		fontSize: 24,
		fontWeight: FontWeight.w700,
	);

	void addDeliveryItem(context) {
		addDeliveryItemHandler(context);
	}

	@override
	Widget build(BuildContext context) {

		Text deliveriesScreenTitle = Text(
			'Deliveries',
			style: textStyle
		);

		GestureDetector addPackageButton = GestureDetector(
			onTap: () {
				addDeliveryItem(context);
			},
			child: Icon(
				Icons.add_circle,
				color: Color(0xff446491),
				size: 23.25
			)
		);

		GestureDetector refreshButton = GestureDetector(
			onTap: () {
				refreshPackageList();
			},
			child: Icon(
				Icons.refresh,
				color: Color(0xff446491),
				size: 23.25
			),
		);


		SizedBox header = SizedBox(
			height: 28,
			width: double.infinity,
			child: Stack(
				children: [
					Positioned(
						top: 0,
						left: 0,
						child: refreshButton
					),
					Positioned(
						top: 0,
						left: 40,
						child: deliveriesScreenTitle
					),
					Positioned(
						top: 0,
						right: 0,
						child: addPackageButton,
					)
				]
			)
		);

		return header;
	}

}
