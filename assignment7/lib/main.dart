import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const blackColor = Color(0xFF181818);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: blackColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Row(
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
                const SizedBox(
                  height: 40,
                ),
                Text("MONDAY 16",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 18,
                    height: 0.8,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("TODAY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        height: 0.8,
                      ),   
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("·",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        height: 0.8,
                      ),   
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    MyText("17", 1),
                    MyText("18", 2),
                    MyText("19", 3),
                    MyText("20", 4),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 16,
                ),
                MyCard(
                  backgroundColor: const Color(0xFFFEF754),
                  startMonth: "11",
                  startDay: "30",
                  endMonth:  "12",
                  endDay: "20",
                  todo: "DESIGN MEETING",
                  people: const ["ALEX", "HELENA", "NANA"],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyCard(
                  backgroundColor: const Color(0xFF9C6BCE),
                  startMonth: "12",
                  startDay: "35",
                  endMonth:  "14",
                  endDay: "10",
                  todo: "DAILY PROJECT",
                  people: const ["ME", "RICHARD", "CIRY", "+4"],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyCard(
                  backgroundColor: const Color(0xFFBCEE4B),
                  startMonth: "15",
                  startDay: "00",
                  endMonth:  "16",
                  endDay: "30",
                  todo: "WEEKLY PLANNING",
                  people: const ["DEN", "NANA", "MARK"],
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
  
  final double _weight = 16;
  
  MyText(this.text, this.order);
  
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(((order-1) * _weight), 0),
      child: Text(text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontSize: 48,
          height: 0.8,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 40,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(startMonth,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                Text(startDay,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  width: 1.4,
                  height: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(endMonth,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                Text(endDay,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.split(" ")[0],
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                    height: 0.8,
                  ),
                ),
                Text(todo.split(" ")[1],
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w500,
                    height: 0.8,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Transform.translate(
                  offset: const Offset(0, 20),
                  child: Row(
                    children: people
                      .map((person) => Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Text(person,
                          style: TextStyle(
                            color: person == "ME"
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                            fontSize: 16,
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