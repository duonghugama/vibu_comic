import 'package:equatable/equatable.dart';

class Truyen extends Equatable {
  final String idTruyen;
  final String tenTruyen;
  final String tenKhac;
  final String tacGia;
  // final List<String> idTheLoai;
  final String moTa;
  final bool daHoanThanh;
  final int gia;
  final String linkAnhTruyen;
  const Truyen(
      {required this.linkAnhTruyen,
      required this.daHoanThanh,
      required this.gia,
      required this.idTruyen,
      required this.tenTruyen,
      required this.tenKhac,
      required this.tacGia,
      // required this.idTheLoai,
      required this.moTa});

  factory Truyen.fromJson(Map<String, dynamic> json) => Truyen(
      linkAnhTruyen: json['linkAnhTruyen'],
      daHoanThanh: json['daHoanThanh'],
      gia: json['giaChap'],
      idTruyen: json['id'],
      tenTruyen: json['tenTruyen'],
      tenKhac: json['tenKhac'],
      tacGia: json['tacGia'],
      // idTheLoai: json['idTheLoai'],
      moTa: json['moTa']);
  @override
  List<Object?> get props => [idTruyen];
}
