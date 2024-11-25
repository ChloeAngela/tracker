import 'package:flutter/material.dart';

class AddExpensesScreen extends StatefulWidget {
  final Function(String date, String detail, double amount) onAddExpense;

  const AddExpensesScreen({super.key, required this.onAddExpense});

  @override
  _AddExpensesScreenState createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expenses'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date:'),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(hintText: 'Enter Date (MM/DD/YYYY)'),
            ),
            const SizedBox(height: 10),
            const Text('Amount:'),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Enter Amount'),
            ),
            const SizedBox(height: 10),
            const Text('Details:'),
            TextField(
              controller: _detailController,
              decoration: const InputDecoration(hintText: 'Enter Details'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close without saving
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate inputs
                    if (_dateController.text.isEmpty ||
                        _amountController.text.isEmpty ||
                        _detailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All fields are required'),
                        ),
                      );
                      return;
                    }

                    final String date = _dateController.text;
                    final String detail = _detailController.text;
                    final double amount = double.tryParse(_amountController.text) ?? 0.0;

                    // Pass the data back using the onAddExpense callback
                    widget.onAddExpense(date, detail, amount);

                    // Navigate back to the previous screen
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
