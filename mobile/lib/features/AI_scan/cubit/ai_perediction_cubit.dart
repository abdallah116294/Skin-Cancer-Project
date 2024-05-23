import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/AI_scan/data/ai_repo.dart';
import 'package:mobile/features/AI_scan/data/perediction_mode.dart';

part 'ai_perediction_state.dart';

class AiPeredictionCubit extends Cubit<AiPeredictionState> {
  AiPeredictionCubit({required this.aiRepo}) : super(AiPeredictionInitial());
  AIRepo aiRepo;
  Future<void> peredictonSkinorNot(File image) async {
    emit(PeredictonSkinOrNotIsloading());
    try {
      Either<String, PeredictionModel> response =
          await aiRepo.peredectionSkinorNot(image);
      emit(response.fold((l) => PeredictonSkinOrNotIsError(error: l),
          (r) => PeredictonSkinOrNotIsSuccess(peredictionModel: r)));
    } catch (error) {
      emit(PeredictonSkinOrNotIsError(error: error.toString()));
    }
  }
    Future<void> peredictonCancerType(File image) async {
    emit(PeredictonSkinOrNotIsloading());
    try {
      Either<String, PeredictionModel> response =
          await aiRepo.peredectionTypeofCancer(image);
      emit(response.fold((l) => PeredictonSkinOrNotIsError(error: l),
          (r) => PeredictionCancerTypeIsSuccess(peredictionModel: r)));
    } catch (error) {
      emit(PeredictonSkinOrNotIsError(error: error.toString()));
    }
  }
}
