import 'package:flutter/material.dart';

import '/utils/colors.dart';
import 'package_status_card.dart';


class DeliveriesScreenHeader extends StatelessWidget {
	const DeliveriesScreenHeader(this.addDeliveryItemHandler, {Key? key}) : super(key: key);

	final Function addDeliveryItemHandler;

	final TextStyle textStyle = const TextStyle(
		color: const Color(0xff446491),
		fontSize: 24,
		fontWeight: FontWeight.w700,
	);

	// TODO: Consider just having the handler here instead of on the main screen
	void addDeliveryItem(context) {
		// TODO: Popup window for entering delivery item info
		addDeliveryItemHandler(context);
	}

	@override
	Widget build(BuildContext context) {
		return SizedBox(
			height: 28,
			width: double.infinity,
			child: Stack(
				children: [
					Positioned(
						top: 0,
						right: 0,
						child: GestureDetector(
							onTap: () {
								addDeliveryItem(context);
							},
							child: Icon(
								Icons.add_circle,
								color: Color(0xff446491),
								size: 23.25
							)
						),
					),
					Positioned(
						top: 0,
						left: 0,
						child: Text(
							'Deliveries',
							style: textStyle
						)
					)
				]
			)
		);
	}

}
