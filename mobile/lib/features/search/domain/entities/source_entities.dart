import 'package:equatable/equatable.dart';


class Source extends Equatable {
  String? id;
  String? name;
  Source({required this.id, required this.name});
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
  ];
}
