import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Counter App'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        width: double.infinity,
        color: _getBackgroundColor(counterProvider.counter),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your Age:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '${counterProvider.counter}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              _getMilestoneMessage(counterProvider.counter),
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 30),
            Slider(
              value: counterProvider.counter.toDouble(),
              min: 0,
              max: 99,
              divisions: 99,
              label: counterProvider.counter.toString(),
              onChanged: (value) {
                counterProvider.setCounter(value.toInt());
              },
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: counterProvider.counter / 99,
              backgroundColor: Colors.grey.shade300,
              color: _getProgressColor(counterProvider.counter),
              minHeight: 10,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: "decrement",
                  onPressed: () => counterProvider.decrement(),
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: "increment",
                  onPressed: () => counterProvider.increment(),
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to determine milestone message based on age
  String _getMilestoneMessage(int age) {
    if (age <= 12) return "You're a child!";
    if (age <= 19) return "Teenager time!";
    if (age <= 30) return "You're a young adult!";
    if (age <= 50) return "You're an adult now!";
    return "Golden years!";
  }

  // Function to change background color based on age
  Color _getBackgroundColor(int age) {
    if (age <= 12) return Colors.lightBlue;
    if (age <= 19) return Colors.lightGreen;
    if (age <= 30) return Colors.yellow.shade600;
    if (age <= 50) return Colors.orange;
    return Colors.grey.shade400;
  }

  // Function to change progress bar color
  Color _getProgressColor(int age) {
    if (age <= 33) return Colors.green;
    if (age <= 67) return Colors.yellow;
    return Colors.red;
  }
}
