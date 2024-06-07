import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/string_manager.dart';

class MyApp extends StatelessWidget {
  final String startWidget;
  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return OfflineBuilder(
    //   connectivityBuilder: (
    //     BuildContext context,
    //     ConnectivityResult connectivity,
    //     Widget child,
    //   ) {
    //     final bool connected = connectivity != ConnectivityResult.none;
    //     if (connected) {
    //       return ScreenUtilInit(
    //         designSize:
    //             Size(StringManager.screenWidth, StringManager.screenHeight),
    //         minTextAdapt: true,
    //         splitScreenMode: true,
    //         builder: (_, child) {
    //           return MaterialApp(
    //             debugShowCheckedModeBanner: false,
    //             onGenerateRoute: AppRoutes.onGenerateRoute,
    //             initialRoute: startWidget,
    //           );
    //         },
    //       );
    //     }else{
    //     return ScreenUtilInit(
    //         designSize:
    //             Size(StringManager.screenWidth, StringManager.screenHeight),
    //         minTextAdapt: true,
    //         splitScreenMode: true,
    //         builder: (_, child) {
    //           return const  MaterialApp(
    //             debugShowCheckedModeBanner: false,
    //             home: Scaffold(
    //             body: Column(
    //               children: [
    //                 Text('No internet availabel pleas check your internet ')
    //               ],
    //             ),
    //             ),
    //           );
    //         },
    //       );
    //     }
    //   },
    // );
    return ScreenUtilInit(
      designSize: Size(StringManager.screenWidth, StringManager.screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: startWidget,
        );
      },
    );
  }
}
