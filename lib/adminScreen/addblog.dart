import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uokleo/screens/adminPage.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _longCaptionController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<void> _submitBlog() async {
    // Validate the form fields
    if (_titleController.text.isEmpty ||
        _longCaptionController.text.isEmpty ||
        _image == null) {
      // Show an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields and select an image.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Upload the image to Firestore Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('blog_images/${DateTime.now().toString()}');
    await storageRef.putFile(_image!);

    // Get the download URL of the uploaded image
    final imageUrl = await storageRef.getDownloadURL();

    // Check if both title and long caption are not empty before adding to Firestore
    if (_titleController.text.isNotEmpty &&
        _longCaptionController.text.isNotEmpty) {
      // Store the blog data in Firestore
      await FirebaseFirestore.instance.collection('Blogs').add({
        'title': _titleController.text,
        'long_caption': _longCaptionController.text,
        'image_url': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
        // Add more fields as needed
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Blog submitted successfully.'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the form fields after submission
      _titleController.clear();
      _longCaptionController.clear();
      setState(() {
        _image = null;
      });
    } else {
      // Show an error message if either title or long caption is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in both title and description.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Blog',
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
                          label: Text('Add Image'),
                        ),
                      ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _longCaptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitBlog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 247, 223, 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Upload Blog',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
