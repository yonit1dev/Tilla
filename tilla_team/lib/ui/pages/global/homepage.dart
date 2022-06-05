// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tilla_team/ui/pages/budget/budget_all.dart';
import 'package:tilla_team/ui/pages/transaction/add_transaction.dart';

import '../../nav/nav.dart';
import 'settings.dart';
import 'stat.dart';
import 'transaction_listView.dart';
import 'welcome_model.dart';
import '../transaction/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int activeIndex = 0;
  int index = 0;
  final greetings = [
    Welcome("Root User", "assets/images/tillaLogo.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            // first column
            child: Column(
              children: [
                Hello(),
                //   CarouselSlider  Widget
                CarouselSlider(
                  items: [
                    carouselItem1(),
                    carouselItem2(),
                    CarouselItem3(),
                  ],
                  // setting Carousel options
                  options: CarouselOptions(
                    height: 180,
                    initialPage: 0,
                    autoPlay: false,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // calls the buildCircles so that the dot sliders appear
                Align(
                  alignment: Alignment.center,
                  child: Container(child: buildCircles),
                ),
                SizedBox(
                  height: 20,
                ),
                StatisticsContainer(),
                SizedBox(
                  height: 20,
                ),
                TransactionContainer(),
                SizedBox(
                  height: 25,
                ),
                BudgetContainer(),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

// builds the dots of the CarsouleSlider
  Widget get buildCircles => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 3,
        effect: ScaleEffect(
          activeDotColor: Colors.redAccent,
          dotColor: Colors.grey,
          dotHeight: 5,
          dotWidth: 5,
        ),
      );

  Widget carouselItem1() => (Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Color.fromARGB(255, 243, 180, 84),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: 400,
            child: Column(
              children: [
                Row(children: [
                  Icon(Icons.account_balance_wallet_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Bank of Abyssinia")
                ]),
                Row(
                  children: [
                    Icon(Icons.password),
                    Icon(Icons.password),
                    SizedBox(
                      width: 5,
                    ),
                    Text("9876"),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ETB"),
                        // SizedBox(
                        //   height: 6,
                        // ),
                        Text("1,000.00"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Debit"),
                        // SizedBox(
                        //   height: 6,
                        // ),
                        Text("05/25")
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      )); //end of CarouselSlideritem1

  Widget carouselItem2() => (Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Color.fromARGB(255, 243, 180, 84),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Center(
                child: Text(
              "Data 2 ",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      )); //end of CarouselSilderie=tem2

  Widget CarouselItem3() => (Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Color.fromARGB(255, 243, 180, 84),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Center(
                child: Text(
              "Data 3",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      )); //end of CarouselSlider3

  Widget Hello() => (Row(
        //  row inside the first column
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //first column inside the first column row
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greetings[index].name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Welcome back",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ), //end of first column inside the first column row
          // second column inside the first column row
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(greetings[index].imageUrl),
                radius: 25,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          ), // end of second column inside the first column row
        ],
      )); //end of column inside the first column row);

  Widget StatisticsContainer() => (ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Color(0XFFEEEEEE),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.show_chart_outlined),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Statistics",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Avg month spend",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "ETB 456.80",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(Icons.trending_down_outlined),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "5%",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "This month spending",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "ETB 234.01",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(Icons.trending_up_outlined),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "13%",
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Center(
                  child: InkWell(
                child: Container(
                    child: Text(
                  "More Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
                onTap: () {},
              ))
            ],
          ),
        ),
      ));

  Widget TransactionContainer() => (ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Color(0XFFEEEEEE),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Transactions",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Text("See all"),
                    onTap: () {
                      GoRouter.of(context).push(Routes.allTransaction);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 150,
                child: TransactionsListView(),
              )
            ],
          ),
        ),
      ));

  Widget BudgetContainer() => (ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: Color(0XFFEEEEEE),
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Budget",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Text(
                      "More",
                      style: TextStyle(color: Color(0xFF1F2630)),
                    ),
                    onTap: () {
                      GoRouter.of(context).push(Routes.allBudget);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Monthly",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Utilization",
                    style: TextStyle(
                        color: Color(0xFF1F2630), fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "ETB 234.01",
                    style: TextStyle(
                        color: Color(0xFF1F2630), fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "50%",
                    style: TextStyle(
                        color: Color(0xFF1F2630), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
                child: LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Color(0xFFEEEEEE),
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ));
}
