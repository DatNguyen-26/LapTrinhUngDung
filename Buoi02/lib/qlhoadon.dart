import 'dart:io';
import 'hoadon.dart';

class QuanLyHoaDon {
  List<HoaDon> dsHoaDon = [];

  // Đọc danh sách từ file txt
  Future<void> docFile(String filePath) async {
    try {
      List<String> lines = await File(filePath).readAsLines();
      for (String line in lines) {
        if (line.trim().isEmpty) continue;
        List<String> p = line.split('#');
        String loai = p[0].trim();
        String ma = p[1].trim();
        String ten = p[2].trim();
        int sl = int.parse(p[3].trim());
        double gia = double.parse(p[4].trim());

        if (loai == 'CN') {
          dsHoaDon.add(HoaDonCaNhan.fullPara(ma, ten, sl, gia, double.parse(p[5])));
        } else if (loai == 'DL') {
          dsHoaDon.add(HoaDonDaiLyCap1.fullPara(ma, ten, sl, gia, int.parse(p[5])));
        } else if (loai == 'CT') {
          dsHoaDon.add(HoaDonCongTy.fullPara(ma, ten, sl, gia, int.parse(p[5])));
        }
      }
    } catch (e) {
      print("Lỗi đọc file: $e");
    }
  }

  // Nhập từ bàn phím
  void nhapDanhSach() {
    stdout.write("Nhập số lượng hóa đơn cần thêm: ");
    int n = int.parse(stdin.readLineSync()!);
    for (int i = 0; i < n; i++) {
      print("\n--- Nhập hóa đơn thứ ${i + 1} ---");
      print("1: Cá nhân | 2: Đại lý Cấp 1 | 3: Công ty");
      stdout.write("Chọn loại khách hàng: ");
      int chon = int.parse(stdin.readLineSync()!);

      HoaDon hd;
      if (chon == 1) {
        hd = HoaDonCaNhan();
      } else if (chon == 2) {
        hd = HoaDonDaiLyCap1();
      } else {
        hd = HoaDonCongTy();
      }
      hd.nhapThongTin();
      dsHoaDon.add(hd);
    }
  }

  // Xuất danh sách
  void xuatDanhSach() {
    print("\n=== DANH SÁCH TẤT CẢ HÓA ĐƠN ===");
    for (var hd in dsHoaDon) {
      print(hd);
    }
  }

  // Tổng thành tiền
  double tongThanhTien() {
    return dsHoaDon.fold(0, (sum, hd) => sum + hd.tinhThanhTien());
  }

  // Tổng tiền trợ giá
  double tongTiengTroGia() {
    return dsHoaDon.fold(0, (sum, hd) => sum + hd.tinhTroGia());
  }

  // Khách hàng mua nhiều nhất
  void khachHangMuaNhieuNhat() {
    if (dsHoaDon.isEmpty) return;
    int maxSL = dsHoaDon.map((hd) => hd.soLuong).reduce((a, b) => a > b ? a : b);
    print("\n=== KHÁCH HÀNG MUA SỐ LƯỢNG NHIỀU NHẤT ($maxSL máy) ===");
    dsHoaDon.where((hd) => hd.soLuong == maxSL).forEach(print);
  }

  // Tổng tiền chiết khấu cho khách hàng công ty
  double tongChietKhauKhachHangCongTy() {
    return dsHoaDon
        .whereType<HoaDonCongTy>()
        .fold(0.0, (sum, hd) => sum + hd.tinhChietKhau());
  }

  // Sắp xếp: Tăng dần số lượng -> Bằng nhau thì Giảm dần thành tiền
  void sapXepDanhSach() {
    dsHoaDon.sort((a, b) {
      int soSanhSL = a.soLuong.compareTo(b.soLuong);
      if (soSanhSL != 0) return soSanhSL;
      return b.tinhThanhTien().compareTo(a.tinhThanhTien());
    });
  }

  // Tìm hóa đơn theo Mã KH x
  void timHoaDonTheoMa(String maX) {
    var timKiem = dsHoaDon.where((hd) => hd.maKH.toUpperCase() == maX.toUpperCase());
    if (timKiem.isNotEmpty) {
      print("\n=== THÔNG TIN HÓA ĐƠN CỦA MÃ KH $maX ===");
      timKiem.forEach(print);
    } else {
      print("\nKhách hàng lạ");
    }
  }
}