import 'dart:io';
import 'package:dart_application_1/qlhoadon.dart'; // Đổi tên package phù hợp

void main() async {
  QuanLyHoaDon qlhd = QuanLyHoaDon();

  // Đọc dữ liệu ban đầu từ file hoadon.txt
  await qlhd.docFile('lib/hoadon.txt');

  // 1 & 2. Xuất danh sách hóa đơn
  qlhd.xuatDanhSach();

  // 3. Tổng thành tiền tất cả hóa đơn
  print("\n-> Tổng thành tiền tất cả hóa đơn: ${qlhd.tongThanhTien().toStringAsFixed(0)} VNĐ");

  // 4. Tổng tiền trợ giá công ty đã hỗ trợ
  print("-> Tổng tiền công ty đã trợ giá: ${qlhd.tongTiengTroGia().toStringAsFixed(0)} VNĐ");

  // 5. Thông tin khách hàng mua nhiều nhất
  qlhd.khachHangMuaNhieuNhat();

  // 6. Tổng số tiền chiết khấu cho khách hàng công ty
  print("\n-> Tổng chiết khấu cho KH Công Ty: ${qlhd.tongChietKhauKhachHangCongTy().toStringAsFixed(0)} VNĐ");

  // 7. Sắp xếp danh sách
  qlhd.sapXepDanhSach();
  print("\n=== DANH SÁCH SAU KHI SẮP XẾP (SL TĂNG DẦN / THÀNH TIỀN GIẢM DẦN) ===");
  qlhd.xuatDanhSach();

  // 8. Tìm kiếm theo mã khách hàng
  stdout.write("\nNhập mã khách hàng cần tìm (VD: KH0002): ");
  String maTim = stdin.readLineSync()!;
  qlhd.timHoaDonTheoMa(maTim);
}