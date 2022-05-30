import 'package:equatable/equatable.dart';

class ChapTruyen extends Equatable {
  final String idTruyen;
  final String idChap;
  final int gia;

  const ChapTruyen({required this.idTruyen, required this.idChap, required this.gia});

  @override
  List<Object?> get props => throw UnimplementedError();
}
