import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title:Text('HomePage')
      ),
      body: Center(
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
        )
      )
    );
  }
}