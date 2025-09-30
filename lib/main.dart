import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: MyApp(),
    ),
  );
}

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  String _currentMood = 'assets/happy_bee.jpg';
  Color _backgroundColor = Colors.yellow;

  final Map<String, int> _moodCount = {
    'Happy': 0,
    'Sad': 0,
    'Excited': 0
  };

  String get currentMood => _currentMood;
  Color get backgroundColor => _backgroundColor;
  Map<String, int> get moodCount =>_moodCount;

  void setHappy() {
    _currentMood = 'assets/happy_bee.jpg';
    _backgroundColor = Colors.yellow;
    _moodCount['Happy'] = _moodCount['Happy']! + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'assets/sad_bee.jpg';
    _backgroundColor = Colors.blue;
    _moodCount['Sad'] = _moodCount['Sad']! + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'assets/excited.jpg';
    _backgroundColor = Colors.orange;
    _moodCount['Excited'] = _moodCount['Excited']! + 1;
    notifyListeners();
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          backgroundColor: moodModel.backgroundColor,
          appBar: AppBar(title: Text('Mood Toggle Challenge')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('How are you feeling?', style: TextStyle(fontSize: 24)),
                SizedBox(height: 30),
                MoodDisplay(),
                SizedBox(height: 50),
                MoodButtons(),
                SizedBox(height: 10),
                MoodCounter()
              ],
            ),
          )
        );
      }  
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Image.asset(
          moodModel.currentMood,
          height: 150,
          width: 150,
          fit: BoxFit.contain,
        );
      },
    );
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
          child: Text('Happy 😊'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
          child: Text('Sad 😢'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
          child: Text('Excited 🎉'),
        ),
      ],
    );
  }
}

class MoodCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        final count = moodModel.moodCount;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Text('${count['Happy']}'),

            Text('${count['Sad']}'),

            Text('${count['Excited']}'),
          ],
        );
      },
    );
  }
}
