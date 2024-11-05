import 'package:flutter/material.dart';

class AddIncomeScreen extends StatelessWidget {
  const AddIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5E4), // Light beige background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Income',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Date:'),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    hint: const Text('Start'),
                    items: List.generate(
                      31,
                      (index) => DropdownMenuItem(
                        value: '${index + 1}',
                        child: Text('${index + 1}'),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                const Text(' - '),
                Expanded(
                  child: DropdownButton<String>(
                    hint: const Text('End'),
                    items: List.generate(
                      31,
                      (index) => DropdownMenuItem(
                        value: '${index + 1}',
                        child: Text('${index + 1}'),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text('Name of Expenses:'),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Select Expense'),
              items: const [
                DropdownMenuItem(value: 'Rent', child: Text('Rent')),
                DropdownMenuItem(value: 'Groceries', child: Text('Groceries')),
                DropdownMenuItem(value: 'Utilities', child: Text('Utilities')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16.0),
            const Text('Amount:'),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFEAFBF1), // Light green fill
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // Cancel and return to previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.green)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Logic to add income can go here
                    Navigator.pop(
                        context); // Go back to the previous screen after saving
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child:
                      const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
