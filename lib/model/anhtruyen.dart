import 'package:equatable/equatable.dart';

class AnhTruyen extends Equatable {
  final String path;
  final String idTruyen;
  final String idChap;

  const AnhTruyen({required this.path, required this.idTruyen, required this.idChap});
  @override
  List<Object?> get props => throw UnimplementedError();
}
