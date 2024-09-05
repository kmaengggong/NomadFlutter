import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final blackColor = const Color(0xFF181818);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: blackColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage("https://picsum.photos/300/300"),
                      radius: 30,
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 60,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text("MONDAY 16",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 18,
                    height: 0.8,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("TODAY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 52,
                      ),   
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("·",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 72,
                        fontWeight: FontWeight.w900,
                      ),   
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    MyText("17", 1),
                    MyText("18", 2),
                    MyText("19", 3),
                    MyText("20", 4),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                MyCard(
                  backgroundColor: const Color(0xFFFEF754),
                  startMonth: "11",
                  startDay: "30",
                  endMonth:  "12",
                  endDay: "20",
                  todo: "DESIGN MEETING",
                  people: ["ALEX", "HELENA", "NANA"],
                ),
                SizedBox(
                  height: 10,
                ),
                MyCard(
                  backgroundColor: const Color(0xFF9C6BCE),
                  startMonth: "12",
                  startDay: "35",
                  endMonth:  "14",
                  endDay: "10",
                  todo: "DAILY PROJECT",
                  people: ["ME", "RICHARD", "CIRY", "+4"],
                ),
                SizedBox(
                  height: 10,
                ),
                MyCard(
                  backgroundColor: const Color(0xFFBCEE4B),
                  startMonth: "15",
                  startDay: "00",
                  endMonth:  "16",
                  endDay: "30",
                  todo: "WEEKLY PLANNING",
                  people: ["DEN", "NANA", "MARK"],
                ),
              ],
            ),
          ),
        ),
      ),
    ); 
  }
}

class MyText extends StatelessWidget {
  final String text;
  final int order;
  
  final double _weight = 30;
  
  MyText(this.text, this.order);
  
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(((order-1) * _weight), 0),
      child: Text(text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontSize: 52,
        ),    
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final Color backgroundColor;
  final String startMonth, startDay, endMonth, endDay, todo;
  final List<String> people;
  
  MyCard({
    required this.backgroundColor,
    required this.startMonth,
    required this.startDay,
    required this.endMonth,
    required this.endDay,
    required this.todo,
    required this.people,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(startMonth,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                Text(startDay,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  width: 1.4,
                  height: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(endMonth,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                Text(endDay,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.split(" ")[0],
                  style: TextStyle(
                    fontSize: 75,
                    fontWeight: FontWeight.w500,
                    height: 0.8,
                  ),
                ),
                Text(todo.split(" ")[1],
                  style: TextStyle(
                    fontSize: 75,
                    fontWeight: FontWeight.w500,
                    height: 0.8,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Transform.translate(
                  offset: Offset(0, 20),
                  child: Row(
                    children: people
                      .map((person) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(person,
                          style: TextStyle(
                            color: person == "ME"
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                            fontSize: 18,
                          ),
                        ),
                      ),)
                      .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}