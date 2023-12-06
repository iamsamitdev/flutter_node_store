import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {

  // กำหนดค่าเริ่มต้นให้กับตัวแปร count
  int _counter = 0; // private

  // สร้างฟังก์ชัน getter ในการดึงค่า count ออกมาใช้งาน
  int get count => _counter;

  // สร้างฟังก์ชัน countUp เพื่อเพิ่มค่า count ขึ้นไป 1
  counterUp() {
    _counter++;
    notifyListeners();
  }

  // สร้างฟังก์ชัน countDown เพื่อลดค่า count ลงไป 1
  counterDown() {
    _counter--;
    notifyListeners();
  }

}