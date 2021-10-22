
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:guess_age_teacher/api/api.dart';

class guessage extends StatefulWidget {
  const guessage({Key? key}) : super(key: key);

  @override
  _guessageState createState() => _guessageState();
}

class _guessageState extends State<guessage> {
  int y = 0;
  int m = 0;
  bool c =false;
  @override

  _guessage() async {
    var data = (await Api()
        .submit("guess_teacher_age", {'year': y, 'month': m}))
    as Map<String, dynamic>;
    if (data == null) {
      return;
    } else {
      String text = data['text'];
      bool value = data['value'];
      if (value) {
        setState(() {
          c = true;
        });
      } else {
        _showMaterial("ผลการทาย", text);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUESS TEACHERS AGE'),
      ),
      body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('อายุอาจารย์',style: TextStyle(fontSize: 40.0),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 8.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                child: SpinBox(
                                  min: 1,
                                  max: 150,
                                  value: 1,
                                  decoration: InputDecoration(labelText: 'ปี'),
                                  onChanged: (year){
                                 setState(() {
                                   print(year);
                                   y = year as int;
                                 }
                                 );
                                  },
                                ),
                                padding: const EdgeInsets.all(16),
                              ),
                              Padding(
                                child: SpinBox(
                                  min: 1,
                                  max: 12,
                                  value: 1,
                                  readOnly: true,
                                  decoration: InputDecoration(labelText: 'เดือน'),
                                    onChanged: (month){
                                      setState(() {
                                        print(month);
                                        m = month as int;
                                      }
                                      );
                                    }
                                ),
                                padding: const EdgeInsets.all(16),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _guessage();
                                  },
                                  child: const Text('ทาย'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
      ),

            ),

    );
  }
  void _showMaterial(String title, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
