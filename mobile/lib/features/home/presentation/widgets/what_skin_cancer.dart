// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:skin_cancer_app/core/helper/exetention.dart';
// import 'package:skin_cancer_app/core/routing/app_routes.dart';
//
// import '../../../core/helper/spacing.dart';
// import '../../../core/utils/app_color.dart';
// import '../../../core/utils/text_styles.dart';
// import '../../../core/widgets/app_button.dart';
//
// class WhatSkinCancer extends StatefulWidget {
//   const WhatSkinCancer({super.key});
//
//   @override
//   State<WhatSkinCancer> createState() => _WhatSkinCancerState();
// }
//
// class _WhatSkinCancerState extends State<WhatSkinCancer> {
//   late bool _isLoading;
//
//   @override
//   void initState() {
//     super.initState();
//     _isLoading = true;
//
//     // Simulate a delay for demonstration purposes
//     Future.delayed(const Duration(seconds: 4), () {
//       setState(() {
//         _isLoading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 350.w,
//       height: 160.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.r),
//         color: AppColor.singInContainerColor,
//       ),
//       child: Row(
//         children: [
//           Container(
//             height: 160.h,
//             width: 160.w,
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//             ),
//             child: _isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : Image.network(
//                     "https://firebasestorage.googleapis.com/v0/b/skinyapp.appspot.com/o/ezgif-6-a16d81c0c0.gif?alt=media&token=970b3848-f0c1-4ba5-9f45-3e5ed33d4dac",
//                     fit: BoxFit.cover,
//                   ),
//           ),
//           horizontalSpacing(6),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 verticalSpacing(18),
//                 Text(
//                   "What is Skin Caner?",
//                   style: TextStyles.font16BlackW500,
//                 ),
//                 verticalSpacing(10),
//                 Text(
//                   "All you need to know about the basics of skin cancer",
//                   style: TextStyles.font14BlackW300.copyWith(fontSize: 12.sp),
//                   maxLines: 2,
//                 ),
//                 verticalSpacing(8),
//                 Padding(
//                   padding: EdgeInsets.only(left: 10.w),
//                   child: AppButton(
//                       borderRadius: 8,
//                       textOfButtonStyle: TextStyles.font14BlackW600,
//                       buttonColor: Colors.white,
//                       width: 120.w,
//                       height: 40.h,
//                       buttonName: "Learn More",
//                       onTap: () {
//                         context.pushNamed(Routes.cancerInfoScreen);
//                       },
//                       textColor: Colors.black,
//                       white: false),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
