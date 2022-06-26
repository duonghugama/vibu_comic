import 'package:equatable/equatable.dart';
import 'package:vibu_comic/model/chaptruyen.dart';

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
  final List theLoai;
  final List<ChapTruyen>? chaps;
  const Truyen(
      {required this.linkAnhTruyen,
      required this.daHoanThanh,
      required this.gia,
      required this.idTruyen,
      required this.tenTruyen,
      required this.tenKhac,
      required this.tacGia,
      required this.theLoai,
      this.chaps,
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
        theLoai: json['theLoai'],
        // chaps: json['chaps'],
        moTa: json['moTa'],
      );

  Map<String, dynamic> toJson() => {
        'id': idTruyen,
        'tenTruyen': tenTruyen,
        'tenKhac': tenKhac,
        'tacGia': tacGia,
        'moTa': moTa,
        'daHoanThanh': daHoanThanh,
        'giaChap': gia,
        'linkAnhTruyen': linkAnhTruyen,
        'theLoai': theLoai,
        'chaps': chaps,
      };
  @override
  List<Object?> get props => [idTruyen];
}
