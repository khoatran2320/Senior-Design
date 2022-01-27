import 'package:flutter/material.dart';

import '/utils/colors.dart';
import '../widgets/dashboard/dashboard_top.dart';
import 'deliveries_screen.dart';
import 'status_screen.dart';


class Dashboard extends StatefulWidget {
	const Dashboard({Key? key}) : super(key: key);

	@override
	_DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {

	late TabController _tabController;

	@override
	void initState() {
		super.initState();
		_tabController = TabController(vsync: this, length: 2);
	}

	@override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Column(
				children: [
					DashboardTop(),
					TabBar(
						controller: _tabController,
						indicatorColor: Color(0xff4B89AC),
						labelColor: Color(0xff446491),
						unselectedLabelColor: Color(0xff446491),
						labelStyle: const TextStyle(
							fontFamily: 'Roboto',
							fontSize: 18,
						),
						tabs: [
							Tab(text: 'Status'),
							Tab(text: 'Deliveries'),
						],
					),
					Expanded(
						child: TabBarView(
							children: [
								StatusScreen(),
								DeliveriesScreen()
							],
							controller: _tabController,
						)
					)
				],
			)
		);
	}
}
