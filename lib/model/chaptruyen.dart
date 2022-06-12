class ChapTruyen {
  final String idChap;
  final String tenChap;
  final List linkanh;
  final List idUserUnlock;
  ChapTruyen(
      {required this.tenChap, required this.idChap, required this.idUserUnlock, required this.linkanh});
  factory ChapTruyen.fromJson(Map<String, dynamic> json) => ChapTruyen(
        tenChap: json['tenChap'],
        idChap: json['idChap'],
        linkanh: json['links'],
        idUserUnlock: json['idUserUnlock'],
      );
}
