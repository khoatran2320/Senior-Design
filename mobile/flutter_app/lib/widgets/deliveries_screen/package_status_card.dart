import 'package:flutter/material.dart';

import '/models/package.dart';
import '/utils/colors.dart';
import '/widgets/deliveries_screen/delete_package_form.dart';


class PackageStatusCard extends StatefulWidget {
	final Package package;

	const PackageStatusCard(this.package, {Key? key}) : super(key: key);

	@override
	_PackageStatusCardState createState() => _PackageStatusCardState();
}

class _PackageStatusCardState extends State<PackageStatusCard> {

	bool showDeleteButton = false;

	final TextStyle itemNameStyle = const TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 16,
		fontWeight: FontWeight.w700,
	);

	final TextStyle textStyle = const TextStyle(
		color: Color(0xffF9FDFE),
		fontSize: 14
	);

	// TODO: Call API to get package details
	void getPackageDetails() {
		print('Getting package details for tapped card');
		// TODO: Call API to get package details
	}

	// Pass true to show
	// Pass false to hide
	void showDeleteButtonHandler(isShow) {
		setState(() {
			showDeleteButton = isShow;
		});
	}

	void _showDeletePackageDialog(context, trackingNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 100,
            child: DeletePackageForm(trackingNumber)
          )
        );
      }
    );
  }

	@override
	Widget build(BuildContext context) {
		double screenWidth = MediaQuery.of(context).size.width;

		String itemName = widget.package.itemName;
		String merchant = widget.package.merchant;
		String status = widget.package.status;
		String trackingNum = widget.package.trackingNum;

		status = status[0].toUpperCase() + status.substring(1);

		Padding cardContent = Padding(
			padding: EdgeInsets.only(top: 10, left: 15, bottom: 13),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(
						"Item: ${itemName}",
						style: itemNameStyle
					),
					Spacer(),
					Text(
						"Merchant: ${merchant}",
						style: textStyle
					),
					Spacer(),
					Text(
						"Status: ${status}",
						style: textStyle
					),
					Spacer(),
					Text(
						"Tracking #: ${trackingNum}",
						style: textStyle
					)
				]
			),
		);

		// Default look, when delete button is hidden
		GestureDetector deleteButton = GestureDetector(
			child: Container(
				decoration: BoxDecoration(
					borderRadius: BorderRadius.only(
						topRight: Radius.circular(10),
						bottomRight: Radius.circular(10)
					),
					color: Color(0xff4B89AC),
				)
			)
		);

		if (showDeleteButton) {
			deleteButton = GestureDetector(
				onTap: () {
					showDeleteButtonHandler(false);
					_showDeletePackageDialog(context, trackingNum);
				},
				child: Container(
					decoration: BoxDecoration(
						borderRadius: BorderRadius.only(
							topRight: Radius.circular(10),
							bottomRight: Radius.circular(10)
						),
						color: Color(0xffE4FCF9),
					),
					height: 120,
					width: 60,
					child: Icon(
						Icons.delete,
						color: Color(0xff4B89AC),
						size: 50
					)
				)
			);
		}

		return GestureDetector(
	    onHorizontalDragUpdate: (details) {
        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
        int sensitivity = 8;
				// Left Swipe
        if(details.delta.dx < -sensitivity){
					showDeleteButtonHandler(true);
        }
	    },
			child: Container(
				decoration: BoxDecoration(
	        borderRadius: BorderRadius.circular(10),
					color: Color(0xff4B89AC),
	      ),
				height: 120,
				width: screenWidth - 50,
				margin: EdgeInsets.only(top: 15, bottom: 0),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						cardContent,
						deleteButton
					]
				)
			)
		);
	}
}
