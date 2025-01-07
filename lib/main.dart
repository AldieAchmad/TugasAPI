import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk mengkonversi data JSON

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Joke App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JokePage(),
    );
  }
}

class JokePage extends StatefulWidget {
  @override
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  String joke = 'Loading...';

  // Fungsi untuk mengambil joke dari JokeAPI
  Future<void> fetchJoke() async {
    final response = await http.get(
      Uri.parse('https://jokeapi-v2.p.rapidapi.com/joke/Any'),
      headers: {
        'X-RapidAPI-Host': 'jokeapi-v2.p.rapidapi.com',
        'X-RapidAPI-Key':
            '76e0f5d15emshbd806fda54da134p165853jsnba436aea8bce', // Ganti dengan API Key Anda
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        if (data['type'] == 'single') {
          joke = data['joke'];
        } else {
          joke = '${data['setup']} - ${data['delivery']}';
        }
      });
    } else {
      setState(() {
        joke = 'Failed to load joke';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PMO Joke App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                joke,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchJoke,
                child: Text('Get New Joke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
