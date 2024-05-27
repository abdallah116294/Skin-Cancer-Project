import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/features/appointment/screen/appointment_screen.dart';
import 'package:mobile/features/explore/explore_screen.dart';
import 'package:mobile/features/home/home_screen.dart';

import '../../core/utils/app_color.dart';
import '../clinic/cubit/clinic_cubit.dart';
import '../profile/screens/profile_screen.dart';
import 'package:mobile/injection_container.dart' as di;

class BottomGNav extends StatefulWidget {
  const BottomGNav({super.key});

  @override
  _BottomGNavState createState() => _BottomGNavState();
}

class _BottomGNavState extends State<BottomGNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String docId = data[
    "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];

    var doctor_role = CacheHelper.getData(key: 'doctor_role');
    List<Widget> _widgetOptions = <Widget>[
      const HomeScreen(),
      doctor_role != null ? const AppointmentScreen() : const ExploreScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
       children : _widgetOptions,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: GNav(
                gap: 10,
                haptic: true,
                activeColor: AppColor.primaryColor,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: const Color(0xFFF5F2F2),
                color: const Color(0xFF9C9DAA),
                tabBorderRadius: 20,
                tabs: [
                  const GButton(
                    icon: Icons.home_work_outlined,
                    text: 'Home',
                  ),
                  doctor_role != null
                      ? const GButton(
                          icon: Icons.calendar_month_outlined,
                          text: 'Appointments',
                        )
                      : const GButton(
                          icon: Icons.explore_outlined,
                          text: 'Explore',
                        ),
                  const GButton(
                    icon: Icons.person_outlined,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
    
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
