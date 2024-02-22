import 'package:flutter/material.dart';
import 'package:uokleo/HomePage.dart';
import 'package:uokleo/adminScreen/addblog.dart';

class AdminContect extends StatefulWidget {
  const AdminContect({Key? key});

  @override
  State<AdminContect> createState() => _AdminContectState();
}

class _AdminContectState extends State<AdminContect> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Content'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _addBlogs,
              child: Text('Add Blogs'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addProjects,
              child: Text('Add Projects'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addProjectDate,
              child: Text('Add Project Date'),
            ),
          ],
        ),
      ),
    );
  }
}
