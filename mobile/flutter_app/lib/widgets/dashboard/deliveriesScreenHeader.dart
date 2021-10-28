import 'package:flutter/material.dart';

import '/utils/colors.dart';
import 'packageStatusCard.dart';


class DeliveriesScreenHeader extends StatefulWidget {
	const DeliveriesScreenHeader({Key? key}) : super(key: key);

	@override
	_DeliveriesScreenHeaderState createState() => _DeliveriesScreenHeaderState();
}

class _DeliveriesScreenHeaderState extends State<DeliveriesScreenHeader> {

	final TextStyle textStyle = const TextStyle(
		color: const Color(0xff446491),
		fontSize: 24,
		fontWeight: FontWeight.w700,
	);

	@override
	Widget build(BuildContext context) {
		return SizedBox(
			height: 28,
			width: double.infinity,
			child: Stack(
				children: [
					// TODO: Make this icon clickable and link to dummy function
					Positioned(
						top: 0,
						right: 0,
						child: Icon(
							Icons.add_circle,
							color: Color(0xff446491),
							size: 23.25
						)
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
