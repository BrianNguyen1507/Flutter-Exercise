import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListStudents extends StatefulWidget {
  const ListStudents({super.key});

  @override
  State<ListStudents> createState() => _ListStudentsState();
}

class SinhVien {
  String ten;
  String studentCode;
  SinhVien(this.ten, this.studentCode);
}

class _ListStudentsState extends State<ListStudents> {
  dynamic _groupValue = 0;
  List<SinhVien> listStudents = [
    SinhVien('Nguyễn Phi Hiếu', 'DH52005810'),
    SinhVien('Văn Bảo Tâm', 'DH529985'),
    SinhVien('Nguyễn Minh Tiến', 'DH592118'),
    SinhVien('Trần Đức Hải', 'DH82474'),
    SinhVien('Phan Đức Tiến', 'DH284782'),
    SinhVien('Nguyễn Phi Hiếu', 'DH52005810'),
    SinhVien('Văn Bảo Tâm', 'DH529985'),
    SinhVien('Nguyễn Minh Tiến', 'DH592118'),
    SinhVien('Trần Đức Hải', 'DH82474'),
    SinhVien('Phan Đức Tiến', 'DH284782'),
    SinhVien('Nguyễn Phi Hiếu', 'DH52005810'),
    SinhVien('Văn Bảo Tâm', 'DH529985'),
    SinhVien('Nguyễn Minh Tiến', 'DH592118'),
    SinhVien('Trần Đức Hải', 'DH82474'),
    SinhVien('Phan Đức Tiến', 'DH284782'),
    SinhVien('Nguyễn Phi Hiếu', 'DH52005810'),
    SinhVien('Văn Bảo Tâm', 'DH529985'),
    SinhVien('Nguyễn Minh Tiến', 'DH592118'),
    SinhVien('Trần Đức Hải', 'DH82474'),
    SinhVien('Phan Đức Tiến', 'DH284782'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'List Student',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
          itemCount: listStudents.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                Fluttertoast.showToast(
                  msg: "You have long pressed at ${listStudents[index].ten}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16,
                );
              },
              child: RadioListTile(
                title: Text(
                    "${listStudents[index].ten}\n${listStudents[index].studentCode}"),
                value: index,
                groupValue: _groupValue,
                onChanged: (value) {
                  setState(() {
                    _groupValue = value;
                  });
                  Fluttertoast.showToast(
                    msg: "You have selected ${listStudents[index].ten}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
