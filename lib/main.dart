import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MathQuizApp());
}

class MathQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Math Quiz',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MathQuizScreen(),
    );
  }
}

class MathQuizScreen extends StatefulWidget {
  @override
  _MathQuizScreenState createState() => _MathQuizScreenState();
}

class _MathQuizScreenState extends State<MathQuizScreen> {
  final Random _random = Random();
  int _num1 = 0;
  int _num2 = 0;
  String _operator = '+';
  int _answer = 0;
  int _score = 0;
  String _feedback = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    setState(() {
      _num1 = _random.nextInt(50) + 1; // Random number between 1 and 50
      _num2 = _random.nextInt(50) + 1;
      int operatorIndex = _random.nextInt(4); // 0: +, 1: -, 2: *, 3: /

      switch (operatorIndex) {
        case 0:
          _operator = '+';
          _answer = _num1 + _num2;
          break;
        case 1:
          _operator = '-';
          _answer = _num1 - _num2;
          break;
        case 2:
          _operator = '*';
          _answer = _num1 * _num2;
          break;
        case 3:
          _operator = '/';
          _answer = (_num1 / _num2).round();
          break;
      }

      _feedback = '';
      _controller.clear();
    });
  }

  void _checkAnswer() {
    if (_controller.text.isEmpty) return;

    setState(() {
      int userAnswer = int.tryParse(_controller.text) ?? 0;
      if (userAnswer == _answer) {
        _feedback = 'Correct!';
        _score++;
      } else {
        _feedback = 'Incorrect. The correct answer was $_answer';
      }
      _generateQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Score: $_score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '$_num1 $_operator $_num2 = ?',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Answer',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            Text(
              _feedback,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _feedback == 'Correct!' ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
