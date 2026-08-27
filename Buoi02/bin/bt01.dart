import 'package:dart_application_1/SanPham.dart';
import 'package:dart_application_1/docfilesp.dart';

void main() async {
  SanPham sp = SanPham();
  sp.showInfo();
  SanPham sp1 = SanPham.fullPara('SP001', 'Bánh gạo Nhật', 25000, 0);
  sp1.showInfo();

  List<SanPham> lstSanPham = [];
  SanPham sp2 = SanPham.fullPara('SP002', 'Trà ô long', 75000, 0);

  SanPham sp3 = SanPham.fullPara('SP003', 'Mứt xoài sấy', 45000, 0);
  lstSanPham.add(sp1);
  lstSanPham.add(sp2);
  lstSanPham.add(sp3);
  print("Danh sách sản phẩm là: ");
  for (SanPham a in lstSanPham) {
    a.showInfo();
  }
  List<SanPham> ds = await readFile('lib/sanpham.txt');
  print("Đọc dữ liệu từ file: ");
  for (SanPham x in ds) {
    x.showInfo();
  }
}
