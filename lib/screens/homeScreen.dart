import 'package:flutter/material.dart';
import 'package:budgety/data/data.dart';
import 'package:budgety/screens/categoryScreen.dart';
import 'package:budgety/widgets/barchart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // func to calculate the bar witdh
    double barWidth(maxWidth, amountRemain, maxAmount) {
      if (amountRemain < 0) {
        return maxWidth;
      }
      if (amountRemain > 0) {
        return amountRemain / maxAmount * maxWidth;
      } else
        return 0;
    }

// function to find bar color
    Color barColor(amountRemain, maxAmount) {
      double percent;
      percent = amountRemain / maxAmount * 100;
      if (percent > 75) {
        return Colors.red;
      }
      if (percent > 50 && percent < 75) {
        return Colors.orange;
      }
      return Colors.green;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            elevation: 10,
            forceElevated: true,
            title: Text("Budgety"),
            leading: Icon(
              Icons.settings,
              size: 30,
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  onPressed: () {})
            ],
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index < 1) {
                // this will return weekly spending
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: BarChart(weeklySpending),
                );
              } else {
                double totalAmountSpend = 0;
                // find the max spent in category
                categories[index - 1].expenses.forEach((element) {
                  totalAmountSpend += element.cost;
                });
                double amountRemain =
                    categories[index - 1].maxAmount - totalAmountSpend;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                                  category: categories[index - 1],
                                )));
                  },
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6.0,
                            color: Colors.black12,
                            offset: Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categories[index - 1].name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            (amountRemain > 0)
                                // if negative amount change the color to red
                                ? Text(
                                    "${amountRemain.toStringAsFixed(2)}\$ /${categories[index - 1].maxAmount}\$",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "${amountRemain.toStringAsFixed(2)}\$ /${categories[index - 1].maxAmount}\$",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Container(
                                  width: barWidth(
                                      constraints.maxWidth,
                                      amountRemain,
                                      categories[index - 1].maxAmount),
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: barColor(amountRemain,
                                        categories[index - 1].maxAmount),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )
                              ],
                            );
                          },
                        )
                      ]),
                    ),
                  ),
                );
              }
            }, childCount: categories.length + 1),
          ),
        ],
      ),
    );
  }
}
