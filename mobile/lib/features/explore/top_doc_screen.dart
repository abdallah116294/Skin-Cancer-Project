import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helper/exetentions.dart';
import 'package:mobile/core/helper/spacing.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/text_styles.dart';

import '../../config/routes/app_routes.dart';

class TopDocScreen extends StatelessWidget {
  const TopDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.primaryColor,
          ),
        ),
        centerTitle: true,
        title: Container(
            width: 195.w,
            height: 46.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(17),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.search),
                Text(
                  "Search Speciality",
                  style: TextStyles.font15BlackW400,
                ),
              ],
            )),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  "Popular Doctor",
                  style: TextStyles.font24PrimaryW700,
                ),
              ),
            ),
          ];
        },
        body: ListView.separated(
          separatorBuilder: (context, index) => verticalSpacing(10),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.pushNamed(Routes.docDetailsScreen);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Container(
                  width: 343.w,
                  height: 76.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0,
                          blurRadius: 10,
                        ),
                      ]),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        child: Image.asset("assets/image/doc1.png"),
                      ),
                      horizontalSpacing(20),
                      Column(
                        children: [
                          Text(
                            "Dr. John Smith",
                            style: TextStyles.font24PrimaryW700
                                .copyWith(fontSize: 15),
                          ),
                          Text(
                            "Sr.Dermatologist",
                            style: TextStyles.font14BlackW300
                                .copyWith(color: Color(0xFF828BE7)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
