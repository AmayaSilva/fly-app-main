import 'package:flutter/material.dart';
import 'quiz.dart';
import 'result.dart';

//void main() => runApp(const MyAppQue());

class MyAppQue extends StatefulWidget {
  const MyAppQue({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppQueState();
  }
}

class _MyAppQueState extends State<MyAppQue> {
  final _questions = const [
    {
      'questionText': 'Do you snore?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 0},
        {'text': 'Don not know', 'score': 0},
      ],
    },
    {
      'questionText': 'Your snoring is...',
      'answers': [
        {'text': 'Slightly louder than breathing ', 'score': 0},
        {'text': 'As loud as talking ', 'score': 0},
        {'text': 'Louder than talking', 'score': 1},
        {'text': 'Very loud, can be heard in adjacent rooms', 'score': 1},
        {'text': 'I do not snore', 'score': 0},
      ],
    },
    {
      'questionText': ' How often do you snore?',
      'answers': [
        {'text': 'Nearly every day', 'score': 1},
        {'text': '3-4 times a week', 'score': 1},
        {'text': '1-2 times a week', 'score': 0},
        {'text': '1-2 times a month', 'score': 0},
        {'text': 'Never or nearly never', 'score': 0},
        {'text': 'I do not snore', 'score': 0},
      ],
    },
    {
      'questionText': 'Has your snoring ever bothered other people?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 0},
        {'text': 'I do not snore', 'score': 0},
      ],
    },
    {
      'questionText':
          'Has anyone noticed that you quit breathing during your sleep?',
      'answers': [
        {'text': 'Nearly every day', 'score': 2},
        {'text': '3-4 times a week', 'score': 2},
        {'text': '1-2 times a week', 'score': 0},
        {'text': '1-2 times a month', 'score': 0},
        {'text': 'Never or nearly never', 'score': 0},
      ],
    },
    {
      'questionText':
          'How often do you feel tired or fatigued after your sleep?',
      'answers': [
        {'text': 'Nearly every day', 'score': 1},
        {'text': '3-4 times a week', 'score': 1},
        {'text': '1-2 times a week', 'score': 0},
        {'text': '1-2 times a month', 'score': 0},
        {'text': 'Never or nearly never', 'score': 0},
      ],
    },
    {
      'questionText':
          'During your wake time, do you feel tired, fatigued, or not up to par?',
      'answers': [
        {'text': 'Nearly every day', 'score': 1},
        {'text': '3-4 times a week', 'score': 1},
        {'text': '1-2 times a week', 'score': 0},
        {'text': '1-2 times a month', 'score': 0},
        {'text': 'Never or nearly never', 'score': 0},
      ],
    },
    {
      'questionText':
          'Have you ever nodded off or fallen asleep while driving a vehicle?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'questionText':
          'How often have you nodded off or fallen asleep while driving a vehicle?',
      'answers': [
        {'text': 'Nearly every day', 'score': 0},
        {'text': '3-4 times a week', 'score': 0},
        {'text': '1-2 times a week', 'score': 0},
        {'text': '1-2 times a month', 'score': 0},
        {'text': 'Never or nearly never', 'score': 0},
      ],
    },
    {
      'questionText': 'Do you have high blood pressure?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 0},
        {'text': 'Don not know', 'score': 0},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    // ignore: avoid_print
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      // ignore: avoid_print
      print('We have more questions!');
    } else {
      // ignore: avoid_print
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text('Geeks for Geeks'),
            backgroundColor: const Color.fromARGB(237, 37, 5, 78)),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                ) //Quiz
              : Result(_totalScore, _resetQuiz),
        ), //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}
