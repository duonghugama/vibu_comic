class ChapTruyen {
  final String idChap;
  final String tenChap;
  final List idUserUnlock;
  ChapTruyen({required this.tenChap, required this.idChap, required this.idUserUnlock});
  factory ChapTruyen.fromJson(Map<String, dynamic> json) => ChapTruyen(
        tenChap: json['tenChap'],
        idChap: json['idChap'],
        idUserUnlock: json['idUserUnlock'],
      );
}
