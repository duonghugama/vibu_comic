import 'package:equatable/equatable.dart';

class Truyen extends Equatable {
  final String idTruyen;
  final String tenTruyen;
  final String tenKhac;
  final String tacGia;
  final List<String> idTheLoai;
  final String moTa;
  final bool daHoanThanh;
  final int gia;
  const Truyen(
      {required this.daHoanThanh,
      required this.gia,
      required this.idTruyen,
      required this.tenTruyen,
      required this.tenKhac,
      required this.tacGia,
      required this.idTheLoai,
      required this.moTa});

  @override
  List<Object?> get props => [idTruyen];
}
