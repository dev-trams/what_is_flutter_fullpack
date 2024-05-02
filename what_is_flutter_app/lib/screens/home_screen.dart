import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whatisflutter/models/aduino_data_model.dart';
import 'package:whatisflutter/screens/detail_page.dart';
import 'package:whatisflutter/services/api_sevice.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController _idController = TextEditingController();
  final Future<List<AduinoDataModel>> _aduinodata = readAduinoData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Container(
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
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
                FutureBuilder(
                  future: _aduinodata,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: TextField(
                              controller: _idController,
                              decoration:
                                  const InputDecoration(labelText: 'Enter id'),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Center(
                            child: ElevatedButton(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 80),
                                child: Text('Login'),
                              ),
                              onPressed: () {
                                bool found = false;
                                var datas = snapshot.data;
                                print(datas);
                                print(_idController);
                                for (var item in datas!) {
                                  if (item.id == _idController.text) {
                                    found = true;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPage(id: _idController.text),
                                      ),
                                    );
                                    break;
                                  }
                                }
                                if (!found) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Invalid ID!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
