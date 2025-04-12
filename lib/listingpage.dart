import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Listingpage extends StatefulWidget {
  const Listingpage({super.key});

  @override
  State<Listingpage> createState() => _ListingpageState();
}

class _ListingpageState extends State<Listingpage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _rollController = TextEditingController();

  void _editStudent(int index, dynamic student) {
    _nameController.text = student['name'];
    _ageController.text = student['age'];
    _rollController.text = student['roll number'];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Student"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogField("Name", _nameController),
            _buildDialogField("Age", _ageController, type: TextInputType.number),
            _buildDialogField("Roll Number", _rollController),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final box = Hive.box('studentsBox');
              box.putAt(index, {
                'name': _nameController.text.trim(),
                'age': _ageController.text.trim(),
                'roll number': _rollController.text.trim(),
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Student updated"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(int index) {
    final box = Hive.box('studentsBox');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete this student?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              box.deleteAt(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Student deleted"),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogField(String label, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registered Students")),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box('studentsBox').listenable(),
          builder: (context, box, _) {
            var students = box.values.toList();
            if (students.isEmpty) {
              return const Center(child: Text("No students registered yet."));
            }
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                var student = students[index];
                return Card(
                  color: Colors.blueGrey[700],
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: Text(
                      student['name'] ?? 'No Name',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Age: ${student['age'] ?? ''}",
                            style: const TextStyle(color: Colors.white70)),
                        Text("Roll Number: ${student['roll number'] ?? ''}",
                            style: const TextStyle(color: Colors.white70)),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.yellow),
                          onPressed: () => _editStudent(index, student),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteStudent(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
