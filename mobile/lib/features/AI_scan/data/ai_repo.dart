import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mobile/features/AI_scan/data/perediction_mode.dart';

abstract class AIRepo {
  Future<Either<String, PeredictionModel>> peredectionSkinorNot(File image);
  Future<Either<String, PeredictionModel>> peredectionTypeofCancer(File image);
}
