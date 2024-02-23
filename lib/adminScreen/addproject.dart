import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uokleo/screens/adminPage.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  File? _image;
  TextEditingController _captionController = TextEditingController();

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<void> _uploadProject() async {
    String caption = _captionController.text.trim();

    if (_image != null && caption.isNotEmpty) {
      try {
        // Check if a project with the same caption already exists
        final existingProjects = await FirebaseFirestore.instance
            .collection('Projects')
            .where('caption', isEqualTo: caption)
            .get();

        if (existingProjects.docs.isEmpty) {
          // Upload image to Firestore storage
          String imageUrl = await _uploadImageToStorage();

          // Add project data to Firestore with a timestamp field
          await FirebaseFirestore.instance.collection('Projects').add({
            'image_url': imageUrl,
            'caption': caption,
            'timestamp': FieldValue.serverTimestamp(), // Add timestamp field
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Project uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          // Redirect to AdminContent page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminContect()),
          );
        } else {
          // Show error message if a project with the same caption already exists
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('A project with the same caption already exists.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print('Error uploading project: $e');
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading project. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Show error message for incomplete data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image and enter a caption.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String> _uploadImageToStorage() async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebaseStorageRef =
          FirebaseStorage.instance.ref().child('project_images/$fileName');
      await firebaseStorageRef.putFile(_image!);
      String imageUrl = await firebaseStorageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return ''; // Return an empty string in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Project',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.file(
                          _image!,
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: ElevatedButton.icon(
                          onPressed: _getImage,
                          icon: Icon(Icons.add_a_photo),
                          label: Text('Add flyer'),
                        ),
                      ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _captionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Project Caption',
                  hintText: 'Enter project caption',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadProject,
                child: Text(
                  'Upload Project',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 247, 223, 2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
