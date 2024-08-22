import 'package:flutter/material.dart';

class ItemsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black, Colors.white],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_drink,
            size: 200,
            color: Colors.blue[400],
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(
                    child: Text(
                      '飲み物',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(padding: EdgeInsets.only(right: 40),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.local_drink,
                    size: 20,
                    color: Colors.blue[400],
                  ),
                  SizedBox(width: 10),
                  Text(
                    '¥100',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
