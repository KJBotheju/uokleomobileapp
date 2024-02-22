import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => ProjectPageState();
}

class ProjectPageState extends State<ProjectPage> {
  Future<QuerySnapshot> _getProjects() async {
    return await FirebaseFirestore.instance
        .collection('Projects')
        .orderBy('timestamp',
            descending: true) // Order by timestamp in descending order
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 180.0,
            decoration: BoxDecoration(
              color: Colors.yellow,
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
                      color: const Color.fromARGB(255, 244, 219, 3),
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
                      'projects',
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
            child: FutureBuilder(
              future: _getProjects(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<DocumentSnapshot> projects = snapshot.data!.docs;
                  return YourBlogContentWidget(projects: projects);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class YourBlogContentWidget extends StatelessWidget {
  final List<DocumentSnapshot> projects;

  YourBlogContentWidget({required this.projects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        var project = projects[index].data() as Map<String, dynamic>;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Full-width image
              Image.network(
                project['image_url'] ?? '',
                height: 200, // Adjust the height as needed
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              // Caption
              Text(
                project['caption'] ?? '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(), // Optional: Add a divider between entries
            ],
          ),
        );
      },
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
