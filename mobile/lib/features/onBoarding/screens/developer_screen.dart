import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Team Members",
          style: TextStyle(color: AppColor.primaryColor),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:  Icon(Icons.arrow_back_ios,
                color:AppColor.primaryColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Padding(
                  padding: EdgeInsets.all(6.h),
                  child:  SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DeveloperContainer(
                                  image: "assets/image/AhmedKhaled1.jpg",
                                  name: "Ahmed Khaled",
                                  postion: "Flutter Developer"),
                              DeveloperContainer(
                                image: "assets/image/abdullah.jpg",
                                name: "Abdallah ",
                                postion: "Flutter Developer",
                              ),
                            ],
                          ),
                          verticalSpacing(10),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DeveloperContainer(
                                  image: "assets/image/mohamedadel.jpg",
                                  name: "Mohamed Adel",
                                  postion: "AI developer"),
                              DeveloperContainer(
                                image: "assets/image/abdelrhamn.jpg",
                                name: "Abdelrahman",
                                postion: "AI Developer",
                              ),
                            ],
                          ),
                          verticalSpacing(10),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DeveloperContainer(
                                  image: "assets/image/AmmarJamal.jpg",
                                  name: "Ammar Gamal",
                                  postion: "C#.Net Developer"),
                              DeveloperContainer(
                                image: "assets/image/george.jpg",
                                name: "George Awad",
                                postion: "C#.Net Developer",
                              ),
                            ],
                          ),
                          verticalSpacing(10),


                          const DeveloperContainer(
                            image: "assets/image/shrouk.png",
                            name: "shrouk ashraf",
                            postion: "UI&UX",
                          ),
                          // SliverDynamicHeightGridView()
                        ]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DeveloperContainer extends StatelessWidget {
  const DeveloperContainer(
      {super.key,
      required this.image,
      required this.name,
      required this.postion});

  final String image;
  final String name;
  final String postion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: AppColor.primaryColor,
          radius: 57,
          child: CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 55,

          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            name,
            style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600),
          ),
          Text(postion,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400))
        ]),
      ],
    );
  }
}
