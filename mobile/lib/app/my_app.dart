import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/config/routes/app_routes.dart';
import 'package:mobile/core/utils/string_manager.dart';
import 'package:mobile/features/Auth/presentation/auth_cubit.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/features/payments/cubit/cubit.dart';
import 'package:mobile/features/search/presentation/cubit/search_cubit.dart';
import 'package:mobile/injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>di.sl<AuthCubit>()),
      BlocProvider(create: (context)=>di.sl<HomeCubit>(),),
      BlocProvider(create: (context)=>PaymentCubit()),
      BlocProvider(create: (context)=>di.sl<SearchCubit>()..getSearchResult('Skin Cancer'))
    ], child: ScreenUtilInit(
      designSize: Size(StringManager.screenWidth, StringManager.screenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    ));
  }
}
