import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/features/Auth/presentation/auth_cubit.dart';
import 'package:mobile/features/profile/profile_screen.dart';

import '../cubit/home_cubit.dart';
import 'appointment_screen.dart';
import 'get_start_clinic_screen.dart';
import 'home_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen(
      {Key? key, required this.uid, required this.name, required this.num})
      : super(key: key);
  final String uid;
  final String name;
  final int num;
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(
      uid: '',
      name: '',
      num: 0,
    ),
    const GetStartClinicScreen(
      patientUid: '',
    ),
    const ProfileScreen(num: 0, uid: ''),
  ];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _num=widget.num;
    _widgetOptions = [
      HomeScreen(
        uid: widget.uid,
        name: widget.name,
        num: widget.num,
      ),
      widget.num == 0
          ? GetStartClinicScreen(
              patientUid: widget.uid,
            )
          : AppointmentScreen(
              uid: widget.uid,
            ),
      ProfileScreen(num: widget.num, uid: widget.uid,),
    ];
   // BlocProvider.of<HomeCubit>(context).getSpecificPatient(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: AppColor.navBarItemColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                const GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                widget.num == 0
                    ? const GButton(
                        icon: AppColor.medical_services_outlined,
                        text: 'Clinic',
                      )
                    : const GButton(
                        icon: Icons.list,
                        text: 'Appoitments',
                      ),
                const GButton(
                  icon: Icons.person,
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
    );
  }
}
