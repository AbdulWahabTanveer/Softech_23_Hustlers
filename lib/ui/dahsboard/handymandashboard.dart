import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../home/home_view.dart';
import '../my_bids/my_post.dart';
import '../profile/handyman_profile.dart';

class HandyManDashBoard extends StatefulWidget {
  const HandyManDashBoard({Key? key}) : super(key: key);

  @override
  State<HandyManDashBoard> createState() => _HandyManDashBoardState();
}

class _HandyManDashBoardState extends State<HandyManDashBoard> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeScreen(),
          MyPost(),
          HandyManProfile(),
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        waterDropColor: Theme.of(context).primaryColor,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        bottomPadding: 10,
        iconSize: 30,
        barItems: [
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
              filledIcon: Icons.my_library_books,
              outlinedIcon: Icons.my_library_books_outlined),
          BarItem(
              filledIcon: Icons.person,
              outlinedIcon: Icons.perm_identity_sharp),
        ],
      ),
    );
  }
}
