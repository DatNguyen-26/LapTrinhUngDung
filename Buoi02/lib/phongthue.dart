
class PhongThue {
  String _maPhong = '';
  int _soNguoi = 0;
  double _soDien = 0;
  double _soNuoc = 0;

  PhongThue();

  PhongThue.fullPara(
    String maPhong,
    int soNguoi,
    double soDien,
    double soNuoc,
  ) {
    _maPhong = maPhong;
    _soNguoi = soNguoi;
    _soDien = soDien;
    _soNuoc = soNuoc;
  }

  // Getter & Setter
  String get maPhong => _maPhong;
  int get soNguoi => _soNguoi;
  double get soDien => _soDien;
  double get soNuoc => _soNuoc;

  double tinhTienPhong() {
    return 0;
  }

  @override
  String toString() {
    return "$_maPhong\t$_soNguoi người\t$_soDien kWh\t$_soNuoc m³";
  }
}

class PhongLoaiA extends PhongThue {
  int _soNguoiThan = 0;

  PhongLoaiA();

  PhongLoaiA.fullPara(
    String maPhong,
    int soNguoi,
    double soDien,
    double soNuoc,
    this._soNguoiThan,
  ) : super.fullPara(maPhong, soNguoi, soDien, soNuoc);

  @override
  double tinhTienPhong() {
    return 1400 + 2 * soDien + 8 * soNuoc + 50 * _soNguoiThan;
  }

  @override
  String toString() {
    return "[Loại A] ${super.toString()}\tNgười thân: $_soNguoiThan\tTỔNG TIỀN: ${tinhTienPhong().toStringAsFixed(0)}k";
  }
}

class PhongLoaiB extends PhongThue {
  double _giatUi = 0;
  int _soMay = 0;

  PhongLoaiB();

  PhongLoaiB.fullPara(
    String maPhong,
    int soNguoi,
    double soDien,
    double soNuoc,
    this._giatUi,
    this._soMay,
  ) : super.fullPara(maPhong, soNguoi, soDien, soNuoc);

  @override
  double tinhTienPhong() {
    return 2000 + 2 * soDien + 8 * soNuoc + _giatUi * 5 + _soMay * 100;
  }

  @override
  String toString() {
    return "[Loại B] ${super.toString()}\tGiặt ủi: ${_giatUi}kg\tSố máy: $_soMay\tTỔNG TIỀN: ${tinhTienPhong().toStringAsFixed(0)}k";
  }
}