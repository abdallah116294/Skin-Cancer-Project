// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:skin_cancer_app/core/helper/spacing.dart';
// import 'package:skin_cancer_app/core/utils/app_color.dart';
//
// import '../../../core/utils/text_styles.dart';
// import '../../../core/widgets/app_button.dart';
//
// class TestWithAi extends StatelessWidget {
//   const TestWithAi({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 350.w,
//       height: 170.h,
//       padding: EdgeInsets.only(left: 10.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.r),
//         color: AppColor.singInContainerColor,
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 verticalSpacing(6),
//                 Text(
//                   "Test Your skin lesion with AI",
//                   style: TextStyles.font16BlackW500,
//                 ),
//                 Text("Get a first look with our machine Learning model",
//                     style: TextStyles.font14BlackW300),
//                 verticalSpacing(4),
//                 Padding(
//                   padding: EdgeInsets.only(left: 10.w),
//                   child: AppButton(
//                       borderRadius: 8,
//                       textOfButtonStyle: TextStyles.font14BlackW600,
//                       buttonColor: Colors.white,
//                       width: 120.w,
//                       height: 40.h,
//                       buttonName: "Start Now",
//                       onTap: () {},
//                       textColor: Colors.black,
//                       white: false),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Column(
//               children: [
//                 Image.asset("assets/image/clinic.png"),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
