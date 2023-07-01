import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'boxes/boxes.dart';
import 'models/notes_model.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  int _score = 0;
  List<String> myStrings = [];

  List<String> retrievedList = [];
  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'choices': ['Paris', 'London', 'Rome', 'Madrid'],
      'correctAnswer': 'Paris',
    },
    {
      'question': 'How many colors are there in a rainbow?',
      'choices': ['5', '7', '10', '12'],
      'correctAnswer': '7',
    },
    {
      'question': 'Which animal is known as "The King of the Jungle"?',
      'choices': ['Lion', 'Elephant', 'Tiger', 'Giraffe'],
      'correctAnswer': 'Lion',
    },
    {
      'question': 'how many days are there in a week?',
      'choices': ['2', '4', '9', '7'],
      'correctAnswer': '7',
    },
    {
      'question': 'how many hours are there in a day?',
      'choices': ['24', '40', '19', '27'],
      'correctAnswer': '24',
    },
  ];

  Future<void> saveList(List<String> myList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('myList', myList);
  }

  Future<List<String>> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? myList = prefs.getStringList('myList');
    return myList ?? []; // Return an empty list if the value is null
  }

  void _submitAnswer(String selectedAnswer) {
    if (selectedAnswer == _questions[_currentIndex]['correctAnswer']) {
      setState(() {
        _score++;
      });
    }
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      myStrings.add('$_score'.toString());
      saveList(myStrings);
      final data = NotesModel(
          title: "player",
          description: 'Your score: $_score/${_questions.length}');
      final box = Boxes.getData();
      box.add(data);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Completed'),
            content: Text('Your score: $_score/${_questions.length}'),
            actions: [
              TextButton(
                child: Text('Play Again'),
                onPressed: () async {
                  retrievedList = await getList();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(retrievedList.length.toString()),
                  ));
                  setState(() {
                    _currentIndex = 0;
                    _score = 0;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kids Quiz'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${_questions.length}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              _questions[_currentIndex]['question'],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ...(_questions[_currentIndex]['choices'] as List<String>).map(
              (choice) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _submitAnswer(choice);
                    },
                    child: Text(choice),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
