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
  PeredictionCancerTypeIsSuccess({required this.peredictionModel});
}

class PeredictonSkinOrNotIsError extends AiPeredictionState {
  final String error;
  PeredictonSkinOrNotIsError({required this.error});
}
