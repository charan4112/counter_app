import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Function to determine message and background color based on age value
  Map<String, dynamic> getMilestone(int age) {
    if (age <= 12) {
      return {"message": "You're a child!", "color": Colors.lightBlueAccent};
    } else if (age <= 19) {
      return {"message": "Teenager time!", "color": Colors.lightGreen};
    } else if (age <= 30) {
      return {"message": "You're a young adult!", "color": Colors.yellow};
    } else if (age <= 50) {
      return {"message": "You're an adult now!", "color": Colors.orange};
    } else {
      return {"message": "Golden years!", "color": Colors.grey};
    }
  }

  // Function to determine progress bar color
  Color getProgressBarColor(int age) {
    if (age <= 33) {
      return Colors.green;
    } else if (age <= 67) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    final milestone = getMilestone(counterProvider.counter);

    return Scaffold(
      backgroundColor: milestone["color"],
      appBar: AppBar(
        title: const Text("Age Counter with Slider"),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              milestone["message"],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '${counterProvider.counter} years old',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 20),
            
            // Age Progress Bar
            LinearProgressIndicator(
              value: counterProvider.counter / 99, // Normalized between 0 and 1
              backgroundColor: Colors.grey[300],
              color: getProgressBarColor(counterProvider.counter),
              minHeight: 10,
            ),
            const SizedBox(height: 20),

            // Age Slider
            Slider(
              value: counterProvider.counter.toDouble(),
              min: 0,
              max: 99,
              divisions: 99,
              label: "${counterProvider.counter}",
              activeColor: getProgressBarColor(counterProvider.counter),
              onChanged: (double newValue) {
                counterProvider.setCounter(newValue.toInt());
              },
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: counterProvider.decrement,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text("Decrease Age", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: counterProvider.increment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent[700],
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text("Increase Age", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
