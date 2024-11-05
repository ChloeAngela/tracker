import 'package:flutter/material.dart';

class AddExpensesScreen extends StatelessWidget {
  const AddExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5E4), // Light beige background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add Expenses',
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
            // Remaining Balance Input
            const Text(
              'Remaining Balance:',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            _buildTextField(hintText: 'Enter remaining balance'),

            const SizedBox(height: 16.0),

            // Add Amount Input
            const Text(
              'Add Amount:',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            _buildTextField(hintText: 'Enter amount'),

            const SizedBox(height: 16.0),

            // Add Detail Input
            const Text(
              'Add Detail:',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            _buildTextField(hintText: 'Enter detail'),

            const SizedBox(height: 32.0),

            // Cancel and Save Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoundedButton(
                  text: 'Cancel',
                  color: Colors.greenAccent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                _buildRoundedButton(
                  text: 'Save',
                  color: Colors.green,
                  onPressed: () {
                    // Handle save action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper: TextField Builder
  Widget _buildTextField({required String hintText}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFEAF8E7), // Light green fill color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Helper: Rounded Button Builder
  Widget _buildRoundedButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
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
