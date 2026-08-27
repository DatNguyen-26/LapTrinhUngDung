import 'dart:io';

void main()
{
  stdout.write("Nhap so luong kem: ");
  int soluong = int.parse(stdin.readLineSync()!);

  if (soluong <= 0) {
    print('Vui long nhap so luong lon hon 0!');
    return;
  }
  stdout.write("Nhap gia tien: ");
  double giatien = double.parse(stdin.readLineSync()!);

  double thanhtien = soluong * giatien;
  if (soluong > 10){
    thanhtien *= 0.9;
  }else if(soluong >= 5){
    thanhtien *= 0.95;
  }

  print("Tong tien phai tra: $thanhtien");


}
