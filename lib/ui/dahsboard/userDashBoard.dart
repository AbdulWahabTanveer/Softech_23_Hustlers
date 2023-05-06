import 'package:flutter/material.dart';
import 'package:softech_hustlers/ui/profile/handyman_profile.dart';
import 'package:softech_hustlers/ui/userhome/userhome.dart';

import '../my_post/my_post.dart';

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
          UserHomeScreen(),
          MyPost(),
          SizedBox(),
          HandyManProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        selectedItemColor: Theme.of(context).primaryColor,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
              icon: Icon(Icons.home_filled),
              label: ''),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
              icon: Icon(Icons.my_library_books_outlined),
              label: ''),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
              icon: Icon(Icons.chat_outlined),
              label: ''),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
              icon: Icon(
                Icons.person,
              ),
              label: ''),
        ],
      ),
    );
  }
}
