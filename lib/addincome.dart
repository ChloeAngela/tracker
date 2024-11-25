import 'package:flutter/material.dart';

class AddIncomeScreen extends StatelessWidget {
  final Function(double) onAddIncome;

  const AddIncomeScreen({super.key, required this.onAddIncome});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _incomeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Income'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Income Amount:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Income Amount',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                double income = double.tryParse(_incomeController.text) ?? 0.0;
                onAddIncome(income);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Add Income'),
            ),
          ],
        ),
      ),
    );
  }
}
