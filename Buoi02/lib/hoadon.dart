import 'dart:io';

// Class cơ sở HoaDon
abstract class HoaDon {
  String _maKH = '';
  String _tenKH = '';
  int _soLuong = 0;
  double _giaBan = 0;

  HoaDon();

  HoaDon.fullPara(String maKH, String tenKH, int soLuong, double giaBan) {
    this.maKH = maKH;
    this.tenKH = tenKH;
    this.soLuong = soLuong;
    this.giaBan = giaBan;
  }

  // Getter & Setter kèm kiểm tra ràng buộc dữ liệu (Validation)
  String get maKH => _maKH;
  set maKH(String value) {
    RegExp regex = RegExp(r'^KH\d{4}$');
    if (regex.hasMatch(value)) {
      _maKH = value;
    } else {
      throw FormatException("Lỗi: Mã KH phải đúng định dạng KHxxxx (VD: KH0002)!");
    }
  }

  String get tenKH => _tenKH;
  set tenKH(String value) {
    if (value.trim().isNotEmpty) {
      _tenKH = value.trim();
    } else {
      throw ArgumentError("Lỗi: Tên khách hàng không được để trống!");
    }
  }

  int get soLuong => _soLuong;
  set soLuong(int value) {
    if (value > 0) {
      _soLuong = value;
    } else {
      throw ArgumentError("Lỗi: Số lượng phải lớn hơn 0!");
    }
  }

  double get giaBan => _giaBan;
  set giaBan(double value) {
    if (value > 0) {
      _giaBan = value;
    } else {
      throw ArgumentError("Lỗi: Giá bán phải lớn hơn 0!");
    }
  }

  // Các phương thức tính toán kinh doanh
  double tinhThueVAT() => _soLuong * _giaBan * 0.10;

  double tinhChietKhau();

  double tinhTroGia() => 0.0;

  double tinhThanhTien() {
    return (_soLuong * _giaBan) - tinhChietKhau() + tinhThueVAT();
  }

  // Phương thức Nhập thông tin thủ công
  void nhapThongTin() {
    while (true) {
      try {
        stdout.write("Nhập Mã KH (định dạng KHxxxx): ");
        maKH = stdin.readLineSync()!;
        break;
      } catch (e) {
        print(e);
      }
    }

    while (true) {
      try {
        stdout.write("Nhập Tên KH: ");
        tenKH = stdin.readLineSync()!;
        break;
      } catch (e) {
        print(e);
      }
    }

    while (true) {
      try {
        stdout.write("Nhập Số lượng mua (> 0): ");
        soLuong = int.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print("Lỗi: Số lượng không hợp lệ!");
      }
    }

    while (true) {
      try {
        stdout.write("Nhập Giá bán (> 0): ");
        giaBan = double.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print("Lỗi: Giá bán không hợp lệ!");
      }
    }
  }

  @override
  String toString() {
    return "$_maKH\t$_tenKH\tSL: $_soLuong\tGiá: ${_giaBan.toInt()}\tCK: ${tinhChietKhau().toInt()}\tTrợ giá: ${tinhTroGia().toInt()}\tThành tiền: ${tinhThanhTien().toInt()} VNĐ";
  }
}

// 1. Khách Hàng Cá Nhân
class HoaDonCaNhan extends HoaDon {
  double _khoangCach = 0;

  HoaDonCaNhan() : super();

  HoaDonCaNhan.fullPara(
    String maKH,
    String tenKH,
    int soLuong,
    double giaBan,
    this._khoangCach,
  ) : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double ck = 0;
    if (soLuong >= 3) {
      ck += soLuong * (giaBan * 0.05);
    }
    if (_khoangCach < 10) {
      ck += soLuong * 50000;
    }
    return ck;
  }

  @override
  double tinhTroGia() {
    double tg = soLuong * (giaBan * 0.02);
    if (soLuong > 2) {
      tg += 100000;
    }
    return tg;
  }

  @override
  void nhapThongTin() {
    super.nhapThongTin();
    stdout.write("Nhập khoảng cách giao hàng (km): ");
    _khoangCach = double.parse(stdin.readLineSync()!);
  }

  @override
  String toString() => "[Cá Nhân]\t${super.toString()}\tKhoảng cách: ${_khoangCach}km";
}

// 2. Đại Lý Cấp 1
class HoaDonDaiLyCap1 extends HoaDon {
  int _namHopTac = 0;

  HoaDonDaiLyCap1() : super();

  HoaDonDaiLyCap1.fullPara(
    String maKH,
    String tenKH,
    int soLuong,
    double giaBan,
    this._namHopTac,
  ) : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double phanTramCK = 0.30;
    if (_namHopTac > 5) {
      phanTramCK += (_namHopTac * 0.01);
      if (phanTramCK > 0.35) phanTramCK = 0.35;
    }
    return soLuong * giaBan * phanTramCK;
  }

  @override
  void nhapThongTin() {
    super.nhapThongTin();
    stdout.write("Nhập số năm hợp tác: ");
    _namHopTac = int.parse(stdin.readLineSync()!);
  }

  @override
  String toString() => "[Đại Lý C1]\t${super.toString()}\tHợp tác: $_namHopTac năm";
}

// 3. Khách Hàng Công Ty
class HoaDonCongTy extends HoaDon {
  int _soNhanVien = 0;

  HoaDonCongTy() : super();

  HoaDonCongTy.fullPara(
    String maKH,
    String tenKH,
    int soLuong,
    double giaBan,
    this._soNhanVien,
  ) : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double phanTramCK = 0;
    if (_soNhanVien > 5000) {
      phanTramCK = 0.07;
    } else if (_soNhanVien > 1000) {
      phanTramCK = 0.05;
    }
    return soLuong * giaBan * phanTramCK;
  }

  @override
  double tinhTroGia() => soLuong * 120000;

  @override
  void nhapThongTin() {
    super.nhapThongTin();
    stdout.write("Nhập số lượng nhân viên: ");
    _soNhanVien = int.parse(stdin.readLineSync()!);
  }

  @override
  String toString() => "[Công Ty]\t${super.toString()}\tNhân viên: $_soNhanVien";
}