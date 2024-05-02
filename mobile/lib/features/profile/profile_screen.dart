import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/utils/assets_path.dart';
import 'package:mobile/features/Auth/presentation/auth_cubit.dart';
import 'package:mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:mobile/features/profile/widget/hall_screen_widget.dart';
import 'package:mobile/injection_container.dart' as di;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.num,
    required this.uid,
  });
  final int num;
  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.num == 0) {
      log(widget.num.toString());
      log(widget.uid.toString());
      return BlocProvider(
        create: (context) => di.sl<HomeCubit>()..getSpecificPatient(widget.uid,widget.num),
        child: Scaffold(
          body: SingleChildScrollView(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is GetSpecificPatient) {
                  return HallProfileScreenWidget(
                    imagUrl: state.patientEntity.imageUrl.toString(),
                    name: state.patientEntity.name.toString(), uid: widget.uid, num: widget.num,
                  );
                }
                return  HallProfileScreenWidget(
                  imagUrl: AssetsManager.personempt,
                  name: '', uid: widget.uid, num: widget.num,
                );
              },
            ),
          ),
        ),
      );
    
    } else if (widget.num == 1) {
      log("doctor" + widget.num.toString());
      log("doctro" + widget.uid.toString());
      return BlocProvider(
        create: (context) => di.sl<HomeCubit>()..getSpecificPatient(widget.uid,widget.num),
        child: Scaffold(
          body: SingleChildScrollView(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is GetSpecificDoctor) {
                  return HallProfileScreenWidget(
                    uid: widget.uid,
                    imagUrl: state.doctorEntity.imageUrl.toString(),
                    name: state.doctorEntity.name.toString(), num: widget.num,
                  );
                }
                return  HallProfileScreenWidget(
                  imagUrl: AssetsManager.personempt,
                  name: '', uid: widget.uid, num: widget.num,
                );
              },
            ),
          ),
        ),
      );
    
    }
    return Scaffold(
      body: Column(
        children: [Center(child: Text('انت حمار '))],
      ),
    );
    // return const Scaffold(
    //     body: HallProfileScreenWidget(
    //   imagUrl: AssetsManager.personempt,
    //   name: '',
    // )
    // );
  }
}
