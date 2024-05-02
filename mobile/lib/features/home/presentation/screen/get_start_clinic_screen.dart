import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/home/presentation/screen/doctors_screen.dart';

class GetStartClinicScreen extends StatelessWidget {
  const GetStartClinicScreen({Key? key, required this.patientUid})
      : super(key: key);
  final String patientUid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
              width: double.infinity,
              'https://firebasestorage.googleapis.com/v0/b/skinyapp.appspot.com/o/doctors_screen.png?alt=media&token=6f8d8daf-e047-4230-adb5-f5e642dfc912',
              fit: BoxFit.cover),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(AssetsManager.doctorpng)),
              ),
              const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(AssetsManager.doctorpng)),
              ),
              SizedBox(
                height: 20.h,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(AssetsManager.doctorpng)),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(AssetsManager.doctorpng)),
              ),
              SizedBox(
                height: 100.h,
              ),
              Center(
                  child: Text(
                "Find a Doctor !",
                style: TextStyle(
                    color: AppColor.doctorTextColor,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                color: Color(0xff4F8CE2),
                endIndent: 100,
                indent: 100,
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                  child: Text(
                "We Can Help You To find\n"
                "Your Doctor Easily. !",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                  buttoncolor: const Color(0xff588CD5),
                  width: 250.w,
                  height: 51.h,
                  buttonName: "Get Started",
                  onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  DoctorsScreen(patientUid:patientUid,)));
                    //  Navigator.pushNamed(context, Routes.getStartClinicScreenRoutes);
                    Navigator.pushNamed(context,Routes.doctorsScreenRoutes,arguments: patientUid );
                  },
                  textColor: Colors.white,
                  white: false)
            ],
          ),
        ],
      ),
    );
  }
}
