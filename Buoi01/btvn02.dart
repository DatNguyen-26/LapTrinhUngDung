import 'dart:io';

void main() {
  // CAU A:
  stdout.write('a. Nhap vao mot chuoi: ');
  String input = stdin.readLineSync()!;
  print('   Chuoi vua nhap la: "$input"');

  if (input.trim().isEmpty) {
    print('Chuoi rong, vui long chay lai va nhap noi dung!');
    return;
  }

  // CAU B
  RegExp nguyenAmRegex = RegExp(
    r'[aeiouyAEIOUYàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹ]',
  );
  
  int soNguyenAm = nguyenAmRegex.allMatches(input).length;
  print('b. So ki tu nguyen am trong chuoi: $soNguyenAm');

  // CAU C:
  List<String> dsTu = input
      .trim()
      .split(RegExp(r'\s+'))
      .where((tu) => tu.isNotEmpty)
      .toList();

  print('c. So tu co trong chuoi: ${dsTu.length}');

  // CAU D
  String cleanStr = input.replaceAll(' ', '').toLowerCase();
  String reversedStr = cleanStr.split('').reversed.join('');

  if (cleanStr == reversedStr) {
    print('d. Chuoi LA chuoi doi xung.');
  } else {
    print('d. Chuoi KHONG LA chuoi doi xung.');
  }

  // CAU E:
  String chuoiDaoTu = dsTu.reversed.join(' ');
  print('e. Chuoi sau khi dao nguoc tu: "$chuoiDaoTu"');
}