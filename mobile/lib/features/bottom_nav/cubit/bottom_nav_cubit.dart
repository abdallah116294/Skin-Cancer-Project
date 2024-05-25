import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meta/meta.dart';
import 'package:mobile/core/cach_helper/cach_helper.dart';

import '../../clinic/cubit/clinic_cubit.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {




  BottomNavCubit() : super(BottomNavInitial());

  int currentIndex=0;
  void changeCurrentIndex(int index,context) {
    var token = CacheHelper.getData(key: 'token');
    Map<String, dynamic> data = Jwt.parseJwt(token);
    String docId = data[
    "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid"];

    if(index ==0){
      BlocProvider.of<ClinicCubit>(context).getDocHasClinic(docId: docId);
    }
    currentIndex=index;
  }
}
