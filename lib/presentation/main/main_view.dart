import 'package:flutter/material.dart';
import 'package:food_user/presentation/main/pages/cart/cart_view.dart';
import 'package:food_user/presentation/main/pages/favourite_view.dart';
import 'package:food_user/presentation/main/pages/home/home_view.dart';
import 'package:food_user/presentation/main/pages/notification_view.dart';
import 'package:food_user/presentation/main/pages/profile_view.dart';
import 'package:food_user/presentation/resources/color_manager.dart';

import '../resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  List<Widget> pages = [
    const HomeView(),
    const FavouriteView(),
    const CartView(),
    const NotificationView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        decoration:  BoxDecoration(
          boxShadow: [
            BoxShadow(
                  color: AppColors.primary.withOpacity(AppDecimal.d_2),
                  spreadRadius: AppSize.s4,
                  blurRadius: AppSize.s8,
                  offset: const Offset(0, AppSize.s4), // changes position of shadow

            ),
          ]
        ),
          child: getBottomNavigationBar(currentIndex, onTapChangeIndex)),
    );
  }

  onTapChangeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

Widget getBottomNavigationBar(int currentIndex, Function onTapChangeIndex) {
  return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      onTap: (index) {
        onTapChangeIndex(index);
      },
      items: [
        navigationBarItem(const Icon(Icons.home_filled)),
        navigationBarItem(const Icon(Icons.favorite_border)),
        navigationBarItem(const Icon(Icons.shopping_bag_outlined)),
        navigationBarItem(const Icon(Icons.notifications_none)),
        navigationBarItem(const Icon(Icons.account_circle_outlined)),
      ]);
}

BottomNavigationBarItem navigationBarItem(Icon icon) {
  return BottomNavigationBarItem(
    icon: icon,
    label: '',
  );
}
