import 'package:flutter/material.dart';
import 'package:languagelearningapp/screens/games.dart';
import 'package:languagelearningapp/screens/languageSelectionPage.dart';

class BeginnerLevelPage extends StatefulWidget {
  const BeginnerLevelPage({Key? key}) : super(key: key);

  @override
  State<BeginnerLevelPage> createState() => _BeginnerLevelPageState();
}

class _BeginnerLevelPageState extends State<BeginnerLevelPage> {
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Family',
      'icon': Icons.family_restroom,
      'color': Colors.red,
      'backgroundColor': Colors.red.withOpacity(0.5),
    },
    {
      'title': 'Fruits',
      'icon': Icons.food_bank,
      'color': Colors.blue,
      'backgroundColor': Colors.blue.withOpacity(0.5),
    },
    {
      'title': 'Sports',
      'icon': Icons.calendar_today,
      'color': Colors.green,
      'backgroundColor': Colors.green.withOpacity(0.5),
    },
    {
      'title': 'Animals',
      'icon': Icons.pets,
      'color': Colors.purple,
      'backgroundColor': Colors.purple.withOpacity(0.5),
    },
    {
      'title': 'Furniture',
      'icon': Icons.shopping_bag,
      'color': Colors.yellow,
      'backgroundColor': Colors.yellow.withOpacity(0.5),
    },
    {
      'title': 'Jobs',
      'icon': Icons.work,
      'color': Colors.orange,
      'backgroundColor': Colors.orange.withOpacity(0.5),
    },
  ];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo1.png',
              height: 40,
            ),
            SizedBox(width: 10),
            Text(
              'Ready to learn?',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black, // German flag color: black
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguageSelectionScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // German flag color: red
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset(
                      'assets/images/belgium.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Text(
                    'Language Selection',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _buildCategoryButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCategoryButtons() {
    List<Widget> buttons = [];

    for (var category in categories) {
      String title = category['title'];
      IconData icon = category['icon'];
      Color color = category['color'];
      Color backgroundColor = category['backgroundColor'];

      if (searchText.isEmpty || title.toLowerCase().contains(searchText)) {
        buttons.add(
          _buildCategoryButton(
            title,
            icon,
            color,
            backgroundColor,
          ),
        );
      }
    }

    return buttons;
  }

  Widget _buildCategoryButton(String title, IconData icon, Color color, Color backgroundColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamesPage(categoryName: title), // Passing category name to GamesPage
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
