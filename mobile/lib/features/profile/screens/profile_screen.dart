import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';
import 'package:mobile/features/Auth/cubit/auth_cubit.dart';
import 'package:mobile/features/profile/widgets/hall_screen_widget.dart';
import 'package:mobile/injection_container.dart' as di;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getData(key: 'token');

    var dotoctorRole = CacheHelper.getData(key: 'doctor_role');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String username = data['sub'];
    String docId = data[
        "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];
    if (dotoctorRole != null) {
      return BlocProvider(
          create: (context) => di.sl<AuthCubit>()..getDoctorDetials(docId),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is GetDoctorDetialsSuccess) {
                return Scaffold(
                    body: HallProfileScreenWidget(
                  name:
                      "${state.doctorModel.firstName} ${state.doctorModel.lastName}",
                ));
              } else {
                return Scaffold(
                    body: HallProfileScreenWidget(
                  name: username,
                ));
              }
            },
          ));
    } else {
      return BlocProvider(
          create: (context) => di.sl<AuthCubit>()..getPatientDetails(docId),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is GetPatientDetialsSuccess) {
                return Scaffold(
                    body: HallProfileScreenWidget(
                  name:
                      "${state.doctorModel.firstName} ${state.doctorModel.lastName}",
                ));
              } else {
                return Scaffold(
                    body: HallProfileScreenWidget(
                  name: username,
                ));
              }
            },
          ));
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
