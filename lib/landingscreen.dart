import 'package:flutter/material.dart';
import 'addexpenses.dart';
import 'addincome.dart';

class FinancialTrackerScreen extends StatefulWidget {
  const FinancialTrackerScreen({super.key});

  @override
  _FinancialTrackerScreenState createState() => _FinancialTrackerScreenState();
}

class _FinancialTrackerScreenState extends State<FinancialTrackerScreen> {
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  List<Map<String, dynamic>> expenses = [];

  @override
  Widget build(BuildContext context) {
    double balance = totalIncome - totalExpense;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5E4),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Financial Tracker',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Start Date and End Date Dropdowns (Side by Side)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildDatePickerSection(title: 'Start Date'),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: _buildDatePickerSection(title: 'End Date'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Income and Balance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Income:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '₱ ${totalIncome.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Balance:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '₱ ${balance.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Expense Table
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 20.0,
                  columns: const [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('List of Expenses')),
                    DataColumn(label: Text('Amount')),
                  ],
                  rows: expenses.map((expense) {
                    return DataRow(
                      cells: [
                        DataCell(Text(expense['date'])),
                        DataCell(Text(expense['detail'])),
                        DataCell(Text(expense['amount'].toStringAsFixed(2))),
                      ],
                    );
                  }).toList(),
                  border: TableBorder.all(
                    color: Colors.green,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Total Expense Display
            Row(
              children: [
                const Text(
                  'Total Expense:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '₱ ${totalExpense.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoundedButton('Add Expenses', Colors.green, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExpensesScreen(
                        onAddExpense: (date, detail, amount) {
                          setState(() {
                            expenses.add({'date': date, 'detail': detail, 'amount': amount});
                            totalExpense += amount;
                          });
                        },
                      ),
                    ),
                  );
                }),
                _buildRoundedButton('Add Income', Colors.green, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddIncomeScreen(
                        onAddIncome: (income) {
                          setState(() {
                            totalIncome += income;
                          });
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper: Date Picker Section Builder
  Widget _buildDatePickerSection({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            _buildDropdown(hint: 'Month', items: List.generate(12, (i) => '${i + 1}')),
            const SizedBox(width: 8.0),
            _buildDropdown(hint: 'Day', items: List.generate(31, (i) => '${i + 1}')),
            const SizedBox(width: 8.0),
            _buildDropdown(hint: 'Year', items: List.generate(10, (i) => '${DateTime.now().year - i}')),
          ],
        ),
      ],
    );
  }

  // Helper: Dropdown Builder
  Widget _buildDropdown({
    required String hint,
    required List<String> items,
  }) {
    return DropdownButton<String>(
      hint: Text(hint),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }

  // Helper: Rounded Button Builder
  Widget _buildRoundedButton(String text, Color color, {VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
