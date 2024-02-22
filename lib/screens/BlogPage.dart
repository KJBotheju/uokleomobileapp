import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 180.0,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 247, 223, 2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Stack(
              children: [
                ClipPath(
                  clipper: ArcClipper(),
                  child: Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                    ),
                  ),
                ),
                Positioned(
                  left: 22.0,
                  top: 50.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/download.jpeg'),
                    radius: 38.0,
                  ),
                ),
                Positioned(
                  right: 20.0,
                  top: 55.0,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 250.0),
                    child: Text(
                      'LEO CLUB OF UNIVERSITY OF KALANIYA',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: YourBlogContentWidget(),
          ),
        ],
      ),
    );
  }
}

class YourBlogContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Blogs').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<DocumentSnapshot> blogs = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            // Extracting data from Firestore
            var blogData = blogs[index].data() as Map<String, dynamic>;
            String blogTitle = blogData['title'] ?? '';
            String blogText = blogData['long_caption'] ?? '';
            String imagePath = blogData['image_url'] ?? '';

            return BlogItemWidget(blogText, imagePath, blogTitle);
          },
        );
      },
    );
  }
}

class BlogItemWidget extends StatelessWidget {
  final String blogText;
  final String imagePath;
  final String blogTitle;

  BlogItemWidget(this.blogText, this.imagePath, this.blogTitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imagePath,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            Padding(
                padding: const EdgeInsets.all(16.0), child: Text(blogTitle)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(blogText),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height + 20, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
