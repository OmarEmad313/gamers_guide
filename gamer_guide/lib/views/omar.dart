import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String message = '';
//10.0.2.2   127.0.0.1
  Future<void> testEndpoint(String endpoint, {String? userId}) async {
    var response;
    if (endpoint == '/recommend' || endpoint == '/recommendMobile') {
      response = await http.get(
        Uri.parse('http://10.0.2.2:5000$endpoint?user_id=$userId'),
      );
    } else {
      response = await http.post(
        Uri.parse('http://10.0.2.2:5000$endpoint'),
      );
    }

    if (response.statusCode == 200) {
      setState(() {
        message =
            jsonDecode(response.body)['message'] ?? jsonEncode(response.body);
      });
    } else {
      throw Exception('Failed to load data from the endpoint');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Test App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Response from the endpoint:',
            ),
            Text(
              '$message',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => testEndpoint('/retrain'),
              child: Text('Test /retrain'),
            ),
            ElevatedButton(
              onPressed: () => testEndpoint('/hi'),
              child: Text('Test /hi'),
            ),
            ElevatedButton(
              onPressed: () => testEndpoint('/recommend', userId: '5'),
              child: Text('Test /recommend'),
            ),
            ElevatedButton(
              onPressed: () => testEndpoint('/retrainMobile'),
              child: Text('Test /retrainMobile'),
            ),
            ElevatedButton(
              onPressed: () => testEndpoint('/recommendMobile',
                  userId: 'zXHem93J32u5q5Fgb2NV'),
              child: Text('Test /recommendMobile'),
            ),
          ],
        ),
      ),
    );
  }
}
