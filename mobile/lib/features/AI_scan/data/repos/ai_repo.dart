import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mobile/features/AI_scan/data/models/ai_history_model.dart';
import 'package:mobile/features/AI_scan/data/models/perediction_mode.dart';

import '../models/upload_success_model.dart';

abstract class AIRepo {
  Future<Either<String, PeredictionModel>> peredectionSkinorNot(File image);
  Future<Either<String, PeredictionModel>> peredectionTypeofCancer(File image);
  Future<Either<String, UploadSuccessModel>> uploadAiDetection(String userId,String result,File image);
  Future<Either<String, List<AiHistoryModel>>> getAiDetection(String userId);
}
