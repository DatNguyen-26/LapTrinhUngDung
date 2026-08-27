import 'dart:io';
import 'dart:math';

void main() {
  stdout.write('Nhap so luong phan tu muon tao cho danh sach: ');
  int n = int.parse(stdin.readLineSync()!);

  if (n <= 0) {
    print('So luong phan tu phai lon hon 0!');
    return;
  }

  Random rng = Random();
  List<int> ds = List.generate(n, (_) => rng.nextInt(96) + 5);

  // CAU A
  print('\na. Danh sach cac so nguyen ngau nhien (5 -> 100):');
  print('   $ds');

  // CAU B:
  int tongLe = 0;
  int demLe = 0;

  for (int x in ds) {
    if (x % 2 != 0) {
      tongLe += x;
      demLe++;
    }
  }

  if (demLe == 0) {
    print('b. Danh sach khong co so le.');
  } else {
    double tbcLe = tongLe / demLe;
    print('b. Trung binh cong cac so le: $tbcLe');
  }

  // CAU C:
  bool doiXung = true;
  for (int i = 0; i < ds.length ~/ 2; i++) {
    if (ds[i] != ds[ds.length - 1 - i]) {
      doiXung = false;
      break;
    }
  }

  if (doiXung) {
    print('c. Danh sach LA danh sach doi xung.');
  } else {
    print('c. Danh sach KHONG LA danh sach doi xung.');
  }

  // CAU D
  bool tangDan = true;
  for (int i = 0; i < ds.length - 1; i++) {
    if (ds[i] > ds[i + 1]) {
      tangDan = false;
      break;
    }
  }

  if (tangDan) {
    print('d. Danh sach DUOC sap xep tang dan.');
  } else {
    print('d. Danh sach KHONG DUOC sap xep tang dan.');
  }

  // CAU E
  int maxVal = ds[0];
  for (int i = 1; i < ds.length; i++) {
    if (ds[i] > maxVal) {
      maxVal = ds[i];
    }
  }
  print('e. Phan tu lon nhat trong danh sach: $maxVal');

  // CAU F:
  int? maxChan;

  for (int x in ds) {
    if (x % 2 == 0) {
      if (maxChan == null || x > maxChan) {
        maxChan = x;
      }
    }
  }

  if (maxChan == null) {
    print('f. Danh sach khong co so chan.');
  } else {
    print('f. So chan lon nhat trong danh sach: $maxChan');
  }

  // CAU G:
  stdout.write('\ng. Nhap mot gia tri can tim/xoa: ');
  int val = int.parse(stdin.readLineSync()!);

  if (!ds.contains(val)) {
    print('   Khong tim thay.');
  } else {
    ds.removeWhere((x) => x == val);
    print('   Da xoa tat ca cac phan tu co gia tri $val.');
    print('   Danh sach sau khi xoa: $ds');
  }
}