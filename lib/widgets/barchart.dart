import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> weeklySpending;
  BarChart(this.weeklySpending);
  double mostExpensive = 0;

  @override
  Widget build(BuildContext context) {
    // find the most expensive item to proportionate the height of the bars
    for (double exp in weeklySpending) {
      if (exp > mostExpensive) {
        mostExpensive = exp;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "Weekly Spending",
            style: TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              Text(
                'Jan 2021-Feb 2021',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {},
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                label: "Mo",
                expense: weeklySpending[0].toStringAsFixed(2),
                height: weeklySpending[0],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: "Tu",
                expense: weeklySpending[1].toStringAsFixed(2),
                height: weeklySpending[1],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: "Wed",
                expense: weeklySpending[2].toStringAsFixed(2),
                height: weeklySpending[2],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: "Th",
                expense: weeklySpending[3].toStringAsFixed(2),
                height: weeklySpending[3],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: "Fr",
                expense: weeklySpending[4].toStringAsFixed(2),
                height: weeklySpending[4],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: "Sa",
                expense: weeklySpending[5].toStringAsFixed(2),
                height: weeklySpending[5],
                mostExpensive: mostExpensive,
              ),
              Bar(
                label: "Su",
                expense: weeklySpending[6].toStringAsFixed(2),
                height: weeklySpending[6],
                mostExpensive: mostExpensive,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final String expense;
  final double height;
  final double mostExpensive;
  Bar({this.label, this.expense, this.height, this.mostExpensive});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "\$$expense",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 18,
          // proportionate height
          height: height / mostExpensive * 100,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '$label',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
