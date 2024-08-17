import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconoir_flutter/regular/box.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

//pages
import '../calculator/calculator_page.dart';

//riverpods
// import '../calculator/providers/add_price.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State <HomePage> createState() => HomePageState();
}

class HomePageState extends State <HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0085FF), Color(0xFF0A2B4A)],
                begin: Alignment.topLeft,
                end: Alignment(0.9, -0.6),
                stops: [0.3, 1.0]
              )
            ),
            constraints: const BoxConstraints.expand(),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.73,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: const Offset(0, -5)
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('6055'),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalculatorPage(),
                        ),
                      ); 
                    },
                    child: Text('Charge')
                  ),
                  SizedBox(height: 30),
              ],
            ),
          ),
          )
        ],
      ),
    );
  }
}