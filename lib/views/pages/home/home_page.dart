import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconoir_flutter/regular/box.dart';
import 'components/money_history.dart';
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
            top: MediaQuery.of(context).size.height * 0.08,
            right: 30,
            child: IconButton(
              icon: const Icon(Icons.settings_outlined, size: 35, color: Colors.white70,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalculatorPage(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.11,
            left: 20,
            child:Column(
              children: [
                Text('￥6,055', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '先週比：',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '￥521(9.4%)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00FF1E), 
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ) 
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.73,
              padding: EdgeInsets.all(40),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('履歴',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ), 
                      Icon(Icons.insights, size: 30),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: MoneyHistoryList(
                      historyData: [
                        {
                          'categoryName': '食費',
                          'categoryIcon': 'food',
                          'price': 1000,
                        },
                        {
                          'categoryName': '飲み物',
                          'categoryIcon': 'drink',
                          'price': 500,
                        },
                        {
                          'categoryName': 'スイーツ',
                          'categoryIcon': 'sweet',
                          'price': 300,
                        },
                      ],
                    ),
                  ),
              ],
            ),
          ),
          )
        ],
      ),
    );
  }
}