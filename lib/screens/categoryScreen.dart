import 'dart:math';

import 'package:flutter/material.dart';
import 'package:budgety/models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _buildList() {
    List<Widget> listOfExpenses = [];
    widget.category.expenses.forEach((element) {
      listOfExpenses.add(
        Container(
          height: 100,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 6, color: Colors.black12, offset: Offset(0, 3))
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                element.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text("${element.cost.toStringAsFixed(2)}\$",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      );
    });
    return Column(children: listOfExpenses);
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountRemain = widget.category.maxAmount;
    for (var exp in widget.category.expenses) {
      totalAmountRemain -= exp.cost;
    }
    double percentUsed = totalAmountRemain / widget.category.maxAmount;
    Color colorOfArc = Colors.green;
    if (percentUsed * 100 > 75) {
      colorOfArc = Colors.red;
    }
    if (percentUsed * 100 < 75 && percentUsed * 100 > 50) {
      colorOfArc = Colors.orange;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category.name}'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 6,
                      color: Colors.black12,
                      offset: Offset(0, 2))
                ]),
            child: CustomPaint(
              child: Center(
                  child: Text(
                "${totalAmountRemain.toStringAsFixed(2)}\$/${widget.category.maxAmount}\$",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              painter: MyPainter(
                percentUsed: percentUsed,
                colorOfArc: colorOfArc,
              ),
            ),
          ),
          _buildList(),
        ]),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double percentUsed;
  final Color colorOfArc;
  MyPainter({this.percentUsed, this.colorOfArc});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.grey[200];
    paint.strokeWidth = 20;
    paint.strokeCap = StrokeCap.round;
    paint.style = PaintingStyle.stroke;

    Paint paint2 = Paint();
    paint2.color = colorOfArc;
    paint2.strokeWidth = 20;
    paint2.strokeCap = StrokeCap.round;
    paint2.style = PaintingStyle.stroke;

    Offset centerOfCircle = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(centerOfCircle, 100, paint);
    canvas.drawArc(Rect.fromCircle(center: centerOfCircle, radius: 100),
        -pi / 2, percentUsed * 2 * pi, false, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
