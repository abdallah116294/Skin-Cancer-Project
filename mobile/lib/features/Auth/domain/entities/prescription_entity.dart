import 'package:equatable/equatable.dart';

class PrescriptionEntity extends Equatable {
  final String? imageUrl;
  final String? output;
  final String? aiUid;
  final String? prescription;
  final String? uid;
  const PrescriptionEntity(
      {this.imageUrl, this.output, this.aiUid, this.prescription,this.uid});
  @override
  // TODO: implement props
  List<Object?> get props => [imageUrl, output, aiUid, prescription,uid];
}
