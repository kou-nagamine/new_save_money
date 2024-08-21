import 'package:flutter/material.dart';

//commons
import '/views/pages/commons/navigation_bar/navigation_bar.dart';

class CustomHeader extends StatelessWidget {
  final String title;

  CustomHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 0, 40),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 32 ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommonNavigationBar(),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}