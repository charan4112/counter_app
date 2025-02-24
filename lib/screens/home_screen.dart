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
      appBar: AppBar(
        title: const Text("Age Counter with Reset"),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        color: milestone["color"],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Fade-in animation for the message
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 600),
                child: Text(
                  milestone["message"],
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              Text(
                '${counterProvider.counter} years old',
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Age Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: counterProvider.counter / 99,
                  backgroundColor: Colors.grey[300],
                  color: getProgressBarColor(counterProvider.counter),
                  minHeight: 12,
                ),
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

              // Buttons with animation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _customButton(
                    text: "Decrease Age",
                    color: Colors.redAccent,
                    onPressed: counterProvider.decrement,
                  ),
                  const SizedBox(width: 20),
                  _customButton(
                    text: "Increase Age",
                    color: Colors.greenAccent[700]!,
                    onPressed: counterProvider.increment,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterProvider.reset,
        backgroundColor: Colors.blueAccent,
        tooltip: "Reset Age",
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  // Custom Button Widget
  Widget _customButton({required String text, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
