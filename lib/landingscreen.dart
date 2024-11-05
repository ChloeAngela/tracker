import 'package:flutter/material.dart';
import 'addexpenses.dart';
import 'addincome.dart'; 

class FinancialTrackerScreen extends StatefulWidget {
  const FinancialTrackerScreen({super.key});

  @override
  _FinancialTrackerScreenState createState() => _FinancialTrackerScreenState();
}

class _FinancialTrackerScreenState extends State<FinancialTrackerScreen> {
  String? startDate;
  String? endDate;
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _totalExpenseController = TextEditingController();

  @override
  void dispose() {
    _incomeController.dispose();
    _balanceController.dispose();
    _totalExpenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5E4), // Light beige background
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
            // Date Range Selection
            Row(
              children: [
                const Text('Date:'),
                const SizedBox(width: 8.0),
                _buildDropdown(
                  hint: 'Start',
                  value: startDate,
                  onChanged: (value) {
                    setState(() => startDate = value);
                  },
                ),
                const Text(' - '),
                _buildDropdown(
                  hint: 'End',
                  value: endDate,
                  onChanged: (value) {
                    setState(() => endDate = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Income and Balance Input
            Row(
              children: [
                const Text('Income:'),
                const SizedBox(width: 8.0),
                _buildTextField(_incomeController, hint: 'Income'),
                const SizedBox(width: 16.0),
                const Text('Balance:'),
                const SizedBox(width: 8.0),
                _buildTextField(_balanceController, hint: 'Enter Balance'),
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
                  rows: List<DataRow>.generate(
                    5,
                    (index) => const DataRow(
                      cells: [
                        DataCell(TextField()),
                        DataCell(TextField()),
                        DataCell(TextField()),
                      ],
                    ),
                  ),
                  border: TableBorder.all(
                    color: Colors.green,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Total Expense Input
            const Text('Total Expense:'),
            _buildTextField(_totalExpenseController,
                hint: 'Enter Total Expense'),
            const SizedBox(height: 16.0),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoundedButton('Add Expenses', Colors.green, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddIncomeScreen()),
                  );
                }),
                _buildRoundedButton('Add Income', Colors.green, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddExpensesScreen()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper: Dropdown Builder
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      hint: Text(hint),
      items: List.generate(
        31,
        (index) => DropdownMenuItem(
          value: '${index + 1}',
          child: Text('${index + 1}'),
        ),
      ),
      onChanged: onChanged,
    );
  }

  // Helper: TextField Builder
  Widget _buildTextField(TextEditingController controller,
      {required String hint}) {
    return SizedBox(
      width: 120,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
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
