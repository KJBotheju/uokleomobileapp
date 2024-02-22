import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uokleo/screens/adminPage.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _longCaptionController = TextEditingController();

  Future<void> _submitBlog() async {
    // Validate the form fields
    if (_titleController.text.isEmpty || _longCaptionController.text.isEmpty) {
      // Show an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }

    // Store the blog data in Firestore
    await FirebaseFirestore.instance.collection('Blogs').add({
      'title': _titleController.text,
      'long_caption': _longCaptionController.text,
      'timestamp': FieldValue.serverTimestamp(),
      // Add more fields as needed
    });

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Blog submitted successfully.'),
      ),
    );

    // Clear the form fields after submission
    _titleController.clear();
    _longCaptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Blog'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _longCaptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Long Caption',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitBlog,
                child: Text('Submit Blog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
