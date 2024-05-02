import 'package:flutter/material.dart';
import 'package:whatisflutter/models/aduino_data_model.dart';
import 'package:whatisflutter/screens/home_screen.dart';
import 'package:whatisflutter/services/api_sevice.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({required this.id, super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _sensorOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Hero(
                tag: 1,
                child: Text(
                  'What is\nFlutter?',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Column(
              children: [
                Icon(
                  _sensorOn ? Icons.lightbulb : Icons.lightbulb_outline,
                  color: Colors.amber,
                  size: 80,
                ),
                IconButton(
                  onPressed: () {
                    const Duration(seconds: 2);
                    setState(() {
                      _sensorOn = !_sensorOn;
                      updateSensorStatus(); // 버튼을 누를 때마다 센서 상태 업데이트
                    });
                  },
                  icon: Icon(
                    _sensorOn ? Icons.toggle_on : Icons.toggle_off,
                    size: 60,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                  child: Text('LogOut'),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateSensorStatus() async {
    int newStatus = _sensorOn ? 1 : 0;
    try {
      await updateAduinoData(value_id: widget.id, value_status: newStatus);
      print('업데이트 완료!');
    } catch (e) {
      print('업데이트 실패..: $e');
    }
  }
}
