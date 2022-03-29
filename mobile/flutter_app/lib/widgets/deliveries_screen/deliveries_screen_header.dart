import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package_status_card.dart';
import '/models/package_list_model.dart';
import '/utils/colors.dart';


class DeliveriesScreenHeader extends StatelessWidget {
	final Function addDeliveryItemHandler;

	const DeliveriesScreenHeader(
		this.addDeliveryItemHandler, {Key? key}
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
				addDeliveryItemHandler(context);
			},
			child: Icon(
				Icons.add_circle,
				color: Color(0xff446491),
				size: 23.25
			)
		);

		GestureDetector refreshButton = GestureDetector(
			onTap: () {
				Provider.of<PackageListModel>(context, listen: false).loadList();
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
