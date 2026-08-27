// Lớp cơ sở MonHoc
abstract class MonHoc {
  String _maMH = '';
  String _tenMH = '';
  int _soTC = 0;

  MonHoc();

  MonHoc.fullPara(String maMH, String tenMH, int soTC) {
    _maMH = maMH;
    _tenMH = tenMH;
    _soTC = soTC;
  }

  String get maMH => _maMH;
  String get tenMH => _tenMH;
  int get soTC => _soTC;

  // Tính Điểm Trung Bình
  double tinhDTB();

  // Quy đổi điểm sang Hệ 4 & Điểm Chữ
  String quyDoiDiem() {
    double dtb = tinhDTB();
    if (dtb >= 8.5) return "4.0 (A)";
    if (dtb >= 7.0) return "3.0 (B)";
    if (dtb >= 5.5) return "2.0 (C)";
    if (dtb >= 4.0) return "1.0 (D)";
    return "0.0 (F)";
  }

  @override
  String toString() {
    return "$_maMH\t$_tenMH\t$_soTC SJC\tĐTB: ${tinhDTB().toStringAsFixed(1)}\tHệ 4: ${quyDoiDiem()}";
  }
}

// 1. Môn Lý Thuyết
class MonLyThuyet extends MonHoc {
  double _diemTieuLuan = 0;
  double _diemCuoiKy = 0;

  MonLyThuyet();

  MonLyThuyet.fullPara(
    String maMH,
    String tenMH,
    int soTC,
    this._diemTieuLuan,
    this._diemCuoiKy,
  ) : super.fullPara(maMH, tenMH, soTC);

  @override
  double tinhDTB() => _diemTieuLuan * 0.3 + _diemCuoiKy * 0.7;

  @override
  String toString() => "[Lý Thuyết]\t${super.toString()}";
}

// 2. Môn Thực Hành
class MonThucHanh extends MonHoc {
  double _kt1 = 0, _kt2 = 0, _kt3 = 0;

  MonThucHanh();

  MonThucHanh.fullPara(
    String maMH,
    String tenMH,
    int soTC,
    this._kt1,
    this._kt2,
    this._kt3,
  ) : super.fullPara(maMH, tenMH, soTC);

  @override
  double tinhDTB() => (_kt1 + _kt2 + _kt3) / 3;

  @override
  String toString() => "[Thực Hành]\t${super.toString()}";
}

// 3. Môn Đồ Án
class MonDoAn extends MonHoc {
  double _diemGVHD = 0;
  double _diemGVPB = 0;

  MonDoAn();

  MonDoAn.fullPara(
    String maMH,
    String tenMH,
    int soTC,
    this._diemGVHD,
    this._diemGVPB,
  ) : super.fullPara(maMH, tenMH, soTC);

  @override
  double tinhDTB() => (_diemGVHD + _diemGVPB) / 2;

  @override
  String toString() => "[Đồ Án]\t${super.toString()}";
}