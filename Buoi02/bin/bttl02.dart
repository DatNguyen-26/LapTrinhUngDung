import 'dart:io';
import 'package:dart_application_1/monhoc.dart';

// Đọc danh sách môn học từ File
Future<List<MonHoc>> readFile(String filePath) async {
  List<MonHoc> ds = [];
  try {
    List<String> lines = await File(filePath).readAsLines();
    for (String line in lines) {
      if (line.trim().isEmpty) continue;
      List<String> p = line.split('#');
      String loai = p[0].trim();
      String ma = p[1].trim();
      String ten = p[2].trim();
      int tc = int.parse(p[3].trim());

      if (loai == 'LT') {
        ds.add(MonLyThuyet.fullPara(ma, ten, tc, double.parse(p[4]), double.parse(p[5])));
      } else if (loai == 'TH') {
        ds.add(MonThucHanh.fullPara(ma, ten, tc, double.parse(p[4]), double.parse(p[5]), double.parse(p[6])));
      } else if (loai == 'DA') {
        ds.add(MonDoAn.fullPara(ma, ten, tc, double.parse(p[4]), double.parse(p[5])));
      }
    }
  } catch (e) {
    print("Lỗi đọc file: $e");
  }
  return ds;
}

// Nhập môn học thủ công từ bàn phím
MonHoc nhapMonHocTuBanPhim() {
  print("\n--- NHẬP MÔN HỌC MỚI ---");
  stdout.write("Chọn loại (1: Lý thuyết, 2: Thực hành, 3: Đồ án): ");
  int loai = int.parse(stdin.readLineSync()!);

  stdout.write("Mã môn: ");
  String ma = stdin.readLineSync()!;
  stdout.write("Tên môn: ");
  String ten = stdin.readLineSync()!;
  stdout.write("Số tín chỉ: ");
  int tc = int.parse(stdin.readLineSync()!);

  if (loai == 1) {
    stdout.write("Điểm tiểu luận: ");
    double tl = double.parse(stdin.readLineSync()!);
    stdout.write("Điểm cuối kỳ: ");
    double ck = double.parse(stdin.readLineSync()!);
    return MonLyThuyet.fullPara(ma, ten, tc, tl, ck);
  } else if (loai == 2) {
    stdout.write("Điểm KT1: ");
    double d1 = double.parse(stdin.readLineSync()!);
    stdout.write("Điểm KT2: ");
    double d2 = double.parse(stdin.readLineSync()!);
    stdout.write("Điểm KT3: ");
    double d3 = double.parse(stdin.readLineSync()!);
    return MonThucHanh.fullPara(ma, ten, tc, d1, d2, d3);
  } else {
    stdout.write("Điểm GVHD: ");
    double hd = double.parse(stdin.readLineSync()!);
    stdout.write("Điểm GVPB: ");
    double pb = double.parse(stdin.readLineSync()!);
    return MonDoAn.fullPara(ma, ten, tc, hd, pb);
  }
}

// Kiểm tra danh sách có sắp xếp tăng dần theo tên môn học
bool kiemTraTangDanTheoTen(List<MonHoc> ds) {
  for (int i = 0; i < ds.length - 1; i++) {
    if (ds[i].tenMH.compareTo(ds[i + 1].tenMH) > 0) {
      return false;
    }
  }
  return true;
}

void main() async {
  // 1. Đọc nội dung file monhoc.txt vào danh sách
  List<MonHoc> dsMonHoc = await readFile('lib/monhoc.txt');

  // 2. Xuất danh sách môn học
  print("=== DANH SÁCH MÔN HỌC (TỪ FILE) ===");
  dsMonHoc.forEach(print);

  // 3. Kiểm tra danh sách có sắp xếp tăng dần theo tên không
  bool isSorted = kiemTraTangDanTheoTen(dsMonHoc);
  print("\n-> Danh sách ${isSorted ? 'ĐÃ' : 'CHƯA'} được sắp xếp tăng dần theo tên môn.");

  // 4. Sắp xếp danh sách môn học tăng dần theo số tín chỉ
  dsMonHoc.sort((a, b) => a.soTC.compareTo(b.soTC));
  print("\n=== DANH SÁCH SẮP XẾP TĂNG DẦN THEO SỐ TÍN CHỈ ===");
  dsMonHoc.forEach(print);

  // 5. Môn học có số tín chỉ cao nhất
  int maxTC = dsMonHoc.map((m) => m.soTC).reduce((a, b) => a > b ? a : b);
  print("\n=== CÁC MÔN HỌC CÓ SỐ TÍN CHỈ CAO NHẤT ($maxTC TC) ===");
  dsMonHoc.where((m) => m.soTC == maxTC).forEach(print);

  // 6. Tìm kiếm tên môn học bất kỳ / Thêm vào cuối nếu không có
  stdout.write("\nNhập tên môn học cần tìm: ");
  String timTen = stdin.readLineSync()!;
  
  var timKiem = dsMonHoc.where(
    (m) => m.tenMH.toLowerCase().trim() == timTen.toLowerCase().trim(),
  );

  if (timKiem.isNotEmpty) {
    print("-> TÌM THẤY TẤT CẢ THÔNG TIN MÔN HỌC:");
    timKiem.forEach(print);
  } else {
    print("-> Không tìm thấy môn '$timTen' trong danh sách! Tiến hành nhập để thêm vào cuối:");
    MonHoc monMoi = nhapMonHocTuBanPhim();
    dsMonHoc.add(monMoi);
    print("\n=== DANH SÁCH SAU KHI THÊM MỚI ===");
    dsMonHoc.forEach(print);
  }

  // 7. Tính số tín chỉ trung bình của các môn học
  double sumTC = dsMonHoc.fold(0, (sum, m) => sum + m.soTC);
  double avgTC = dsMonHoc.isNotEmpty ? sumTC / dsMonHoc.length : 0;
  print("\n=== SỐ TÍN CHỈ TRUNG BÌNH CỦA CÁC MÔN HỌC ===");
  print("Trung bình: ${avgTC.toStringAsFixed(2)} tín chỉ/môn");
}