import 'package:flutter/material.dart';
import 'addexpenses.dart';
import 'addincome.dart';

class FinancialTrackerScreen extends StatefulWidget {
  const FinancialTrackerScreen({super.key});

  @override
  _FinancialTrackerScreenState createState() => _FinancialTrackerScreenState();
}

class _FinancialTrackerScreenState extends State<FinancialTrackerScreen> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  String? selectedStartMonth;
  String? selectedStartDay;
  String? selectedStartYear;
  String? selectedEndMonth;
  String? selectedEndDay;
  String? selectedEndYear;

  List<Map<String, dynamic>> expenses = [];
  double totalExpense = 0.0;

  @override
  void dispose() {
    _incomeController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  void _addExpense(String date, String detail, double amount) {
    setState(() {
      expenses.add({
        'date': date,
        'detail': detail,
        'amount': amount,
      });

      // Update total expenses and balance
      totalExpense = expenses.fold(0.0, (sum, expense) => sum + expense['amount']);
      double income = double.tryParse(_incomeController.text) ?? 0.0;
      _balanceController.text = (income - totalExpense).toStringAsFixed(2);
    });
  }

  void _addIncome(double income) {
    setState(() {
      double currentIncome = double.tryParse(_incomeController.text) ?? 0.0;
      _incomeController.text = (currentIncome + income).toStringAsFixed(2);

      // Update balance after adding income
      _balanceController.text = (currentIncome + income - totalExpense).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: _buildDatePickerSection(
                    title: 'Start Date',
                    selectedMonth: selectedStartMonth,
                    selectedDay: selectedStartDay,
                    selectedYear: selectedStartYear,
                    onMonthChanged: (value) => setState(() => selectedStartMonth = value),
                    onDayChanged: (value) => setState(() => selectedStartDay = value),
                    onYearChanged: (value) => setState(() => selectedStartYear = value),
                  ),
                ),
                const SizedBox(width: 16.0), // Spacer between the two sections
                Expanded(
                  child: _buildDatePickerSection(
                    title: 'End Date',
                    selectedMonth: selectedEndMonth,
                    selectedDay: selectedEndDay,
                    selectedYear: selectedEndYear,
                    onMonthChanged: (value) => setState(() => selectedEndMonth = value),
                    onDayChanged: (value) => setState(() => selectedEndDay = value),
                    onYearChanged: (value) => setState(() => selectedEndYear = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Income and Balance
            Row(
              children: [
                const Text('Income:'),
                const SizedBox(width: 8.0),
                _buildTextField(_incomeController, hint: 'Income'),
                const SizedBox(width: 16.0),
                const Text('Balance:'),
                const SizedBox(width: 8.0),
                _buildTextField(_balanceController, hint: 'Balance', readOnly: true),
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
                        onAddExpense: _addExpense,
                      ),
                    ),
                  );
                }),
                _buildRoundedButton('Add Income', Colors.green, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddIncomeScreen(
                        onAddIncome: _addIncome,
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
  Widget _buildDatePickerSection({
    required String title,
    required String? selectedMonth,
    required String? selectedDay,
    required String? selectedYear,
    required ValueChanged<String?> onMonthChanged,
    required ValueChanged<String?> onDayChanged,
    required ValueChanged<String?> onYearChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            _buildDropdown(
              hint: 'Month',
              value: selectedMonth,
              items: List.generate(12, (i) => '${i + 1}'),
              onChanged: onMonthChanged,
            ),
            const SizedBox(width: 8.0),
            _buildDropdown(
              hint: 'Day',
              value: selectedDay,
              items: List.generate(31, (i) => '${i + 1}'),
              onChanged: onDayChanged,
            ),
            const SizedBox(width: 8.0),
            _buildDropdown(
              hint: 'Year',
              value: selectedYear,
              items: List.generate(10, (i) => '${DateTime.now().year - i}'),
              onChanged: onYearChanged,
            ),
          ],
        ),
      ],
    );
  }

  // Helper: Dropdown Builder
  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      hint: Text(hint),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // Helper: TextField Builder
  Widget _buildTextField(TextEditingController controller,
      {required String hint, bool readOnly = false}) {
    return SizedBox(
      width: 120,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
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
