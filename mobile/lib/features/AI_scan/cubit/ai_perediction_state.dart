part of 'ai_perediction_cubit.dart';

sealed class AiPeredictionState extends Equatable {
  const AiPeredictionState();

  @override
  List<Object> get props => [];
}

final class AiPeredictionInitial extends AiPeredictionState {}

class PeredictonSkinOrNotIsloading extends AiPeredictionState {}

class PeredictonSkinOrNotIsSuccess extends AiPeredictionState {
  final PeredictionModel peredictionModel;

  PeredictonSkinOrNotIsSuccess({required this.peredictionModel});
}

class PeredictionCancerTypeIsSuccess extends AiPeredictionState {
  final PeredictionModel peredictionModel;

  PeredictionCancerTypeIsSuccess({
    required this.peredictionModel,
  });
}

class PeredictonSkinOrNotIsError extends AiPeredictionState {
  final String error;

  PeredictonSkinOrNotIsError({required this.error});
}

final class UploadAiResultInitial extends AiPeredictionState {}

class UploadAiResultLoading extends AiPeredictionState {}

class UploadAiResultSuccess extends AiPeredictionState {
  final UploadSuccessModel model;

  const UploadAiResultSuccess(this.model);
}

class UploadAiResultError extends AiPeredictionState {
  final String errorMessage;

  const UploadAiResultError(this.errorMessage);
}

class GetAiHistoryResultLoading extends AiPeredictionState {}

class GetAiHistoryResultSuccess extends AiPeredictionState {
  final List<AiHistoryModel> aiHistory;

  const GetAiHistoryResultSuccess(this.aiHistory);
}

class GetAiHistoryResultError extends AiPeredictionState {
  final String errorMessage;

  const GetAiHistoryResultError(this.errorMessage);
}

class GetDiseasInfoSucces extends AiPeredictionState {
  List<Disease> diseas;
  GetDiseasInfoSucces({required this.diseas});
}

class GetDiseasInfoError extends AiPeredictionState {
  String error;
  GetDiseasInfoError({required this.error});
}

class AddDiagonosisSucessState extends AiPeredictionState {
  final String result;
  AddDiagonosisSucessState({required this.result});
}

class AddDiagonosisErrorState extends AiPeredictionState {
  final String error;
  AddDiagonosisErrorState({required this.error});
}

