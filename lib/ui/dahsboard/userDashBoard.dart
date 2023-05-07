import 'package:flutter/material.dart';
import 'package:softech_hustlers/ui/my_job/my_job.dart';
import 'package:softech_hustlers/ui/profile/handyman_profile.dart';
import 'package:softech_hustlers/ui/userhome/userhome.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import '../user_view_bid.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          const UserHomeScreen(),
          MyJob(),
          UserViewBidScreen(),
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
            filledIcon: Icons.account_balance_wallet,
            outlinedIcon: Icons.account_balance_wallet_outlined,
          ),
          BarItem(
              filledIcon: Icons.person,
              outlinedIcon: Icons.perm_identity_sharp),
        ],
      ),
    );
  }
}
