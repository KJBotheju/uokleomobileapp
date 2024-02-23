import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uokleo/screens/adminPage.dart';

class AddProjectDate extends StatefulWidget {
  const AddProjectDate({super.key});

  @override
  State<AddProjectDate> createState() => _AddProjectDateState();
}

class _AddProjectDateState extends State<AddProjectDate> {
  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();

  void _uploadProjectDate() async {
    if (yearController.text.isEmpty ||
        monthController.text.isEmpty ||
        dateController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        projectNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All fields must be filled.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // If all fields are filled, store the data in Firestore
    try {
      await FirebaseFirestore.instance.collection('Dates').add({
        'year': yearController.text,
        'month': monthController.text,
        'date': dateController.text,
        'startTime': startTimeController.text,
        'projectName': projectNameController.text,
        // Add additional fields as needed
      });

      // Display a success snackbar message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Project date uploaded successfully.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      // Optionally, you can clear the form fields after successful upload
      yearController.clear();
      monthController.clear();
      dateController.clear();
      startTimeController.clear();
      projectNameController.clear();

      // Redirect to AdminContect page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminContect()),
      );
    } catch (error) {
      // Handle errors if any
      print('Error uploading project date: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Project Date',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 247, 223, 2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminContect()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: yearController,
              decoration: InputDecoration(labelText: 'Year'),
            ),
            TextField(
              controller: monthController,
              decoration: InputDecoration(labelText: 'Month'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: startTimeController,
              decoration: InputDecoration(labelText: 'Start Time'),
            ),
            TextField(
              controller: projectNameController,
              decoration: InputDecoration(labelText: 'Project Name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadProjectDate,
              child: Text(
                'Upload Project Date',
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 247, 223, 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
