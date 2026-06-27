import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:food_for_health/core/constants/app_info.dart';
import 'package:food_for_health/core/general_functions/general_buttons_onpresseds.dart';
import 'package:food_for_health/features/barcode_scan/view/barcode_scan_view.dart';
import 'package:food_for_health/features/chat_with_ai/view/chat_with_ai_view.dart';
import 'package:food_for_health/features/profile/view/profile_view.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ChatWithAiView(),
    BarcodeScanView(),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppInfo.appNameUpperCase,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appsMainColor,
        actions: [
          _currentIndex == 2
              ? IconButton(
                  onPressed: () {
                    GeneralButtonOnpresseds().signOutButtonOnPressed(context);
                  },
                  icon: Icon(FontAwesomeIcons.rightFromBracket, color: Colors.white))
              : SizedBox.shrink()
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixed,
        backgroundColor: AppColors.appsMainColor,
        activeColor: Colors.white,
        color: Color(0xFFF5F5DC),
        items: [
          TabItem(icon: FontAwesomeIcons.robot, title: "YZ ile Sohbet"),
          TabItem(icon: FontAwesomeIcons.barcode, title: "Barkod Okut"),
          TabItem(icon: FontAwesomeIcons.solidUser, title: "Profil"),
        ],
        initialActiveIndex: 0,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;

            //barkod okuta basıldığında kamera açma burada gerçekleşebilir.
          });
        },
      ),
    );
  }
}
