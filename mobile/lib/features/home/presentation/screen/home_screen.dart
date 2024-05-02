import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/utils/app_color.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/core/widgets/custom_button.dart';
import 'package:mobile/features/Auth/presentation/auth_cubit.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/features/home/presentation/screen/ai_scan_screen.dart';
import 'package:mobile/features/home/presentation/widgets/cancer_types/risk_factors.dart';
import 'package:mobile/features/search/presentation/screens/search_screen.dart';

import '../../../../core/utils/assets_path.dart';
import '../widgets/cancer_types/cancer_facts_screen.dart';
import '../widgets/cancer_types/cancer_info_screen.dart';
import '../widgets/cancer_types/cancer_prevention.dart';
import '../widgets/cancer_types/early_detection.dart';
import '../widgets/custom_container_widget.dart';
import '../widgets/learnig_center.dart';
import '../widgets/row_of_icon_text_arrow.dart';
import 'doctors_screen.dart';
import 'package:mobile/injection_container.dart' as di;

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key,required this.num, required this.uid,required this.name, }) : super(key: key);
  final String uid;
  final String name;
   final int num;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 390.w,
              height: 190.h,
              decoration: BoxDecoration(
                color: AppColor.containerColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
         widget.num==0?          BlocProvider(create: (context)=>di.sl<AuthCubit>()..getSpecificPatient(widget.uid),child: BlocBuilder<AuthCubit,AuthState>(builder: (context,state){
                      if(state is AuthInSuccessState){
                        log(widget.num.toString());
                        return   Text('Hi ${state.patientEntity.name}',style: TextStyle(color:AppColor.nameColor,fontSize: 20.sp,fontWeight: FontWeight.bold ),);
                      }
                      return Text('Hi ',style: TextStyle(color:AppColor.nameColor,fontSize: 20.sp,fontWeight: FontWeight.bold ),);
                    },)):      BlocProvider(create: (context)=>di.sl<HomeCubit>()..getSpecificDoctor(widget.uid),child: BlocBuilder<HomeCubit,HomeState>(builder: (context,state){
           if(state is GetSpecificDoctor){
             log(widget.num.toString());
             return   Text('Hi ${state.doctorEntity.name}',style: TextStyle(color:AppColor.nameColor,fontSize: 20.sp,fontWeight: FontWeight.bold ),);
           }else if(state is DoctorDataError ){
             return Text('Hi ',style: TextStyle(color:AppColor.nameColor,fontSize: 20.sp,fontWeight: FontWeight.bold ),);
           }
           return Text('Hi ',style: TextStyle(color:AppColor.nameColor,fontSize: 20.sp,fontWeight: FontWeight.bold ),);
         },)),
                    Image.asset(AssetsManager.container1,width: 150.w,height: 121.h,),
                  ],
                ),
              ),
            ),
             SizedBox(height:22.h ,),
           // LearningCenter(),
            SizedBox(height:22.h ,),
            CustomContainerWidget(text1: StringManager.testAI, text2: StringManager.textAI2, imagePathe: AssetsManager.clinicImage, actionButtonName: 'Start Now', ontap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AIScanScreen(uid: widget.uid, num: widget.num,))) ;
            }, isnetwork: true,),
            SizedBox(height:22.h ,),
            CustomContainerWidget(text1: StringManager.whatskin, text2: StringManager.whatskin2, imagePathe: AssetsManager.gifCell, actionButtonName: 'Learn More', ontap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CancerInfoScreen()));
            }, isnetwork: false,),
            SizedBox(height:22.h ,),
           const  LearningCenter(),
            RowOfIconTextArrow(
              text: "Skin Cancer Facts and Statistics",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CancerFactsScreen()));
                //context.pushNamed(Routes.cancerFactsScreen);
              },
            ),
            RowOfIconTextArrow(
              text: "Risk Factors",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RiskFactorsScreen()));
                ///context.pushNamed(Routes.riskFactorsScreen);
              },
            ),
            RowOfIconTextArrow(text: "Prevention",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SkinCancerPreventionScreen()));
              },
            ),
            RowOfIconTextArrow(
                text: "Early Detection", iconPath: "assets/image/alarm.png",
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EarlyDetectionScreen()));
                  // context.pushNamed(Routes.earlyDetectionScreen);
                }
                ),

              RowOfIconTextArrow(
                text: "Aritcles", iconPath: "assets/image/alarm.png",
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchScreen()));
                  // context.pushNamed(Routes.earlyDetectionScreen);
                }
                ),    
          ],
        ),
      ),
    );
  }
}
