import 'dart:io';
import 'package:dart_application_1/phongthue.dart';

Future<List<PhongThue>> readFile(String filePath) async {
  List<PhongThue> danhSach = [];
  try {
    List<String> lines = await File(filePath).readAsLines();

    for (String line in lines) {
      if (line.trim().isEmpty) continue;
      List<String> parts = line.split('#');

      String maPhong = parts[0].trim();
      int soNguoi = int.parse(parts[1].trim());
      double soDien = double.parse(parts[2].trim());
      double soNuoc = double.parse(parts[3].trim());

      if (maPhong.startsWith('A') && parts.length == 5) {
        int soNguoiThan = int.parse(parts[4].trim());
        danhSach.add(PhongLoaiA.fullPara(maPhong, soNguoi, soDien, soNuoc, soNguoiThan));
      } else if (maPhong.startsWith('B') && parts.length == 6) {
        double giatUi = double.parse(parts[4].trim());
        int soMay = int.parse(parts[5].trim());
        danhSach.add(PhongLoaiB.fullPara(maPhong, soNguoi, soDien, soNuoc, giatUi, soMay));
      }
    }
  } catch (e) {
    print("Lỗi khi đọc file: $e");
  }
  return danhSach;
}

void main() async {
  List<PhongThue> dsPhong = await readFile('lib/phongthue.txt');

  print("=== DANH SÁCH TẤT CẢ CÁC PHÒNG THUÊ ===");
  for (var p in dsPhong) {
    print(p);
  }

  print("\n=== CÁC PHÒNG CÓ SỐ NGƯỜI THUÊ LỚN HƠN 2 ===");
  var dsNguoiLonHon2 = dsPhong.where((p) => p.soNguoi > 2);
  for (var p in dsNguoiLonHon2) {
    print(p);
  }

  double tongTien = dsPhong.fold(0, (sum, p) => sum + p.tinhTienPhong());
  print("\n=== TỔNG TIỀN PHÒNG THU ĐƯỢC ===");
  print("Tổng cộng: ${tongTien.toStringAsFixed(0)}k VNĐ");

  dsPhong.sort((a, b) => b.soDien.compareTo(a.soDien));
  print("\n=== DANH SÁCH GIẢM DẦN THEO SỐ ĐIỆN TIÊU THỤ ===");
  for (var p in dsPhong) {
    print("${p.maPhong} - Số điện: ${p.soDien} kWh");
  }

  print("\n=== DANH SÁCH CÁC PHÒNG LOẠI A ===");
  var dsLoaiA = dsPhong.whereType<PhongLoaiA>();
  for (var p in dsLoaiA) {
    print(p);
  }
}