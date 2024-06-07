import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/widgets/titles_text_widget.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Developers",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 730.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitlesTextWidget(label: "AI Developer"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DeveloperContainer(
                                  image: "assets/image/mohamedadel.jpg",
                                  name: "Mohamed Adel",
                                  postion: "AI developer"),
                              DeveloperContainer(
                                image: "assets/image/abdelrhamn.jpg",
                                name: "Abdelrhman ",
                                postion: "AI Developer",
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 6,
                            indent: 60,
                            endIndent: 60,
                          ),
                          TitlesTextWidget(label: "Backend Developer"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DeveloperContainer(
                                  image: "assets/image/AmmarJamal.jpg",
                                  name: "Ammar Gamal",
                                  postion: "C#.Net Developer"),
                              DeveloperContainer(
                                image: "'",
                                name: "George Awad",
                                postion: "C#.Net Developer",
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 6,
                            indent: 60,
                            endIndent: 60,
                          ),
                          TitlesTextWidget(label: "Mobile Developer"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DeveloperContainer(
                                  image: "assets/image/AhmedKhaled.jpg",
                                  name: "Ahmed Khaled",
                                  postion: "Flutter Developer"),
                              DeveloperContainer(
                                image: "assets/image/abdallah.jpg",
                                name: "Abdallah ",
                                postion: "Flutter Developer",
                              ),
                            ],
                          ),
                           Divider(
                            thickness: 6,
                            indent: 60,
                            endIndent: 60,
                          ),
                           TitlesTextWidget(label: "UI&UX"),
                           DeveloperContainer(
                                image: "",
                                name: "Shrouk Asherf",
                                postion: "UI&UX",
                              ),
                          // SliverDynamicHeightGridView()
                        ]),
                  ),
                ),
              ),
            ),
          )
        ],
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
          backgroundColor: Color(0xffD6D9F4),
          radius: 70,
          child: CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 60,
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          Text('(${postion})',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold))
        ]),
      ],
    );
  }
}