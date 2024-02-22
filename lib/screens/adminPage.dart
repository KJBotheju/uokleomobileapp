// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uokleo/HomePage.dart';
import 'package:uokleo/adminScreen/addblog.dart';

class AdminContect extends StatefulWidget {
  const AdminContect({Key? key});

  @override
  State<AdminContect> createState() => _AdminContectState();
}

class _AdminContectState extends State<AdminContect> {
  TextEditingController projectNameController = TextEditingController();

  void _goBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _addBlogs() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AddBlog()));
    print('Add Blogs clicked');
  }

  void _addProjects() {
    // Implement logic for adding projects
    print('Add Projects clicked');
  }

  void _addProjectDate() {
    // Implement logic for adding project dates
    print('Add Project Date clicked');
  }

  void _deleteBlogs() {
    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar(); // Hide any existing snackbar

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Blogs'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Set to min to wrap content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Enter the project title:'),
                TextField(
                  controller: projectNameController,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    String projectName = projectNameController.text.trim();

                    // Check if the project with the entered title exists
                    var projectQuery = await FirebaseFirestore.instance
                        .collection('Blogs')
                        .where('title', isEqualTo: projectName)
                        .limit(1)
                        .get();

                    if (projectQuery.docs.isEmpty) {
                      // Show an error message using a SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('No project found with the entered title.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      // Delete the project and related details
                      var projectDoc = projectQuery.docs.first;
                      await projectDoc.reference.delete();

                      // Show a success message using a SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Blog deleted successfully.'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.of(context).pop(); // Close the delete dialog
                    }
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _deleteProjects() {
    // Implement logic for deleting projects
    print('Delete Projects clicked');
  }

  void _deleteProjectDate() {
    // Implement logic for deleting project dates
    print('Delete Project Date clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 247, 223, 2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
      ),
      body: SingleChildScrollView(
        // Wrap your entire content with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50.0),
              // Add Blogs Block
              ElevatedButton(
                onPressed: _addBlogs,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 23, 187, 29),
                ),
                child: Text(
                  'Add Blogs',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),

              // Add Projects Block
              ElevatedButton(
                onPressed: _addProjects,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 23, 187, 29),
                ),
                child: Text(
                  'Add Projects',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),

              // Add Project Date Block
              ElevatedButton(
                onPressed: _addProjectDate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 23, 187, 29),
                ),
                child: Text(
                  'Add Project Date',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 50.0), // Adjust spacing between blocks

              // Delete Blogs Block
              ElevatedButton(
                onPressed: _deleteBlogs,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  'Delete Blogs',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),

              // Delete Projects Block
              ElevatedButton(
                onPressed: _deleteProjects,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  'Delete Projects',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16.0),

              // Delete Project Date Block
              ElevatedButton(
                onPressed: _deleteProjectDate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  'Delete Project Date',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
