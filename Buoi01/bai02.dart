import 'dart:io';

void main()
{
  stdout.write("Nhap so nguyen: ");
  int n = int.parse(stdin.readLineSync()!);

  if (n <= 10) {
    print('Vui long nhap so nguyen duong lon hon 10!');
    return;
  }

  //Cau a
  String chuoiN = n.toString();
  int dodai = chuoiN.length;
  print("So chu so trong $n la $dodai");

  //Cau b
  int tong = 0;
  for(int i = 0; i < chuoiN.length; i++)
  {
    int chuso = int.parse(chuoiN[i]);
    tong += chuso;
  }
  print("Tong cac chu so co trong $n la $tong");

  //Cau c
  bool coSoLe = false;
  for(int i = 0; i < chuoiN.length; i++)
  {
    int chuso = int.parse(chuoiN[i]);
    if (chuso % 2 != 0)
    {
      coSoLe = true;
      break;
    }
  }
  if(coSoLe == true)
  {
    print("Trong $n co so le");
  }
  else
  {
    print("Trong $n khong co so le");
  }
}