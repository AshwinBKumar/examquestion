import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class StudentReg extends StatefulWidget {
  const StudentReg({super.key});

  @override
  State<StudentReg> createState() => _StudentRegState();
}

class _StudentRegState extends State<StudentReg> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _rollnumberController = TextEditingController();

  Future<void> _saveToHive() async {
    if (_formKey.currentState!.validate()) {
      final box = Hive.box('studentsBox');

      await box.add({
        'name': _nameController.text.trim(),
        'age': _ageController.text.trim(),
        'roll number': _rollnumberController.text.trim(),
      });

      _nameController.clear();
      _ageController.clear();
      _rollnumberController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Student details registered"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Student Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                label: "Name",
                keyboardType: TextInputType.name,
                controller: _nameController,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                label: "Age",
                keyboardType: TextInputType.number,
                controller: _ageController,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                label: "Roll Number",
                keyboardType: TextInputType.phone,
                controller: _rollnumberController,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: size.width * 0.6,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _saveToHive,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextInputType keyboardType,
    required TextEditingController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 229, 225, 225),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? 'Enter $label' : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
