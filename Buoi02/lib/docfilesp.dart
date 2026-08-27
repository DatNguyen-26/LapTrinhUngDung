import 'dart:io';
import 'package:dart_application_1/SanPham.dart';

Future<List<SanPham>> readFile(String fileName) async {
  List<SanPham> arrs = [];
  try {
    List<String> lines = await File(fileName).readAsLines();

    for (String line in lines) {
      if (line.trim().isEmpty) continue;

      List<String> parts = line.split('#');

      if (parts.length == 4) {
        String masp = parts[0].trim();
        String tensp = parts[1].trim();
        double giaban = double.parse(parts[2].trim());
        double giamgia = double.parse(parts[3].trim());

        if (masp.isNotEmpty && tensp.isNotEmpty) {
          arrs.add(SanPham.fullPara(masp, tensp, giaban, giamgia));
        }
      }
    }
  } catch (e) {
    print('Lỗi khi đọc file: $e');
  }
  return arrs;
}
