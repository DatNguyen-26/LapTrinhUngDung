import 'dart:io';
import 'dart:math';

bool laSoNguyenTo(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) 
      {
        return false;
      }
  }
  return true;
}

void main() {
  stdout.write('Nhap danh sach cac so nguyen: ');
  String input = stdin.readLineSync()!;
  
  List<int> ds = input
      .split(' ')
      .where((e) => e.isNotEmpty)
      .map(int.parse)
      .toList();

  // CAU A:
  print('\na. Danh sach vua nhap: $ds');

  // CAU B:
  int tong = 0;
  for (int x in ds) {
    tong += x;
  }
  print('b. Tong cac phan tu trong danh sach: $tong');

  // CAU C:
  List<int> dsSoNguyenTo = [];
  for (int x in ds) {
    if (laSoNguyenTo(x)) {
      dsSoNguyenTo.add(x);
    }
  }
  print('c. Cac phan tu la so nguyên tố: $dsSoNguyenTo');

  // CAU D
  stdout.write('\nd. Nhập vào một giá trị bất kỳ cần tìm: ');
  int val = int.parse(stdin.readLineSync()!);

  if (ds.contains(val)) {
    List<int> viTri = [];
    for (int i = 0; i < ds.length; i++) {
      if (ds[i] == val) {
        viTri.add(i);
      }
    }
    print('   Gia tri $val co trong danh sach tai vi tri (index): $viTri');
  } else {
    ds.insert(0, val);
    print('   Da them $val vao dau danh sach. Danh sach moi: $ds');
  }
}