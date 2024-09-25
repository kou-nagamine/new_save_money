import 'package:flutter/material.dart';
import 'memo_field.dart';
import 'package:intl/intl.dart';


class PaymentContet extends StatelessWidget {
  final DateTime date;
  final int price;
  final String compensatingRatio;
  final String memo;

  const PaymentContet({
    super.key,
    required this.date,
    required this.price,
    required this.compensatingRatio,
    required this.memo,
  });
  
  @override
  Widget build(BuildContext context) { 
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.year}年${date.month}月${date.day}日',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            Text(
              '¥${NumberFormat("#,###").format(price)}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xffE82929)
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xffF5F5F5),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: IntrinsicWidth( 
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'この支払いは',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff5B5B5B),
                          ),
                          children: [
                            TextSpan(
                              text: '$compensatingRatio%',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffE82929),
                              ),
                            ),
                            TextSpan(
                              text: 'お得になりました!',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5B5B5B),
                              ),
                            ),
                          ]
                        )
                      ),
                    ],
                  ),
                )
              )
            ),
            SizedBox(height: 15),
            MemoField(initialMemo: memo),
            SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft, 
              child: Text(
                '記録されたついで収入',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5B5B5B),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
