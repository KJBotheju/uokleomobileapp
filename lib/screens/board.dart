import 'package:flutter/material.dart';
import 'package:uokleo/HomePage.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Board Members',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 247, 223, 2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ); // Navigate back to the previous screen
          },
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Executive Board',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildBoardMember(
                    'Leo Bawantha Wedagedara',
                    'President',
                    'assets/board/bhawantha.jpg',
                  ),
                  _buildBoardMember(
                    'Leo Sachith Lakshan',
                    'Immediate Past President',
                    'assets/board/sachith.png',
                  ),
                  _buildBoardMember(
                    'Leo Yasasvi De Silva',
                    '1st Vice President',
                    'assets/board/yasasvi.jpg',
                  ),
                  _buildBoardMember(
                    'Leo Abhishek Dickwella',
                    'Vice President for Membership',
                    'assets/board/Abhishek.jpg',
                  ),
                  _buildBoardMember(
                    'Leo Kisal Gimhan',
                    'Vice President for Projects',
                    'assets/board/kisal.jpg',
                  ),
                  _buildBoardMember(
                    'Leo Kevshan Vinishka',
                    'Vice President for Projects',
                    'assets/board/kevshan.jpg',
                  ),
                  _buildBoardMember(
                    'Leo Vishmi Rodrigo',
                    'Secretary',
                    'assets/board/vishmi.jpg',
                  ),
                  _buildBoardMember(
                    'Leo Beenu Geethma Mudaligama',
                    'Assistant Secretary',
                    'assets/board/beenu.jpg',
                  ),
                  _buildBoardMember(
                    'leo Himashi Nimthara Wimalarathna',
                    'Assistant Secretary',
                    'assets/board/himashi.jpg',
                  ),
                  _buildBoardMember(
                    'Leo Sanuri Wijesiriwardena',
                    'Treasurer',
                    'assets/board/sanuri.jpg',
                  ),
                  _buildBoardMember(
                    'Leo Akila Pramod Jayawardana',
                    'Assistant Treasurer',
                    'assets/board/akila.jpg',
                  ),
                  _buildBoardMember(
                    'Leo Nuzha Farook',
                    'Chief Editor',
                    'assets/board/nu.jpg',
                  ),
                  // Add more members as needed
                ],
              ),
            ),
            Text(
              'Unit Board',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildBoardMember(
                    'Leo Devini Liyana Gunawardhana',
                    'Betterment of Leoism',
                    'assets/images/download.jpeg',
                  ),
                  _buildBoardMember(
                    'Leo Pawani Methmini',
                    'Betterment of Leoism',
                    'assets/images/download.jpeg',
                  ),
                  _buildBoardMember(
                    'Leo Yasasvi De Silva',
                    '1st Vice President',
                    'assets/images/download.jpeg',
                  ),
                  _buildBoardMember(
                    'Leo Abhishek Dickwella',
                    'Vice President for Membership',
                    'assets/images/download.jpeg',
                  ),
                  // Add more members as needed
                ],
              ),
            ),
            Text(
              'Director Board',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildBoardMember(
                    'Leo Bawantha Wedagedara',
                    'President',
                    'assets/images/download.jpeg',
                  ),
                  _buildBoardMember(
                    'Leo Sachith Lakshan',
                    'Immediate Past President',
                    'assets/images/download.jpeg',
                  ),
                  _buildBoardMember(
                    'Leo Yasasvi De Silva',
                    '1st Vice President',
                    'assets/images/download.jpeg',
                  ),
                  _buildBoardMember(
                    'Leo Abhishek Dickwella',
                    'Vice President for Membership',
                    'assets/images/download.jpeg',
                  ),
                  // Add more members as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoardMember(String title, String subtitle, String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(subtitle),
        ],
      ),
    );
  }
}
