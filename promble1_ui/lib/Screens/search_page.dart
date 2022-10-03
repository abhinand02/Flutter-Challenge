import 'package:flutter/material.dart';
import 'package:promble1_ui/constants/style.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 28, 44, 43),
      body: ListView(
        children: [
          Stack(
            children: [
              backGroundContainer(height),
              Container(
                padding: EdgeInsets.only(left: 20),
                margin: EdgeInsets.only(top: 40, left: 20),
                height: 80,
                width: width - 40,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 65, 155, 149),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 40,
                      color: whiteColor,
                    ),
                    Text(
                      'Search Flights',
                      style: TextStyle(fontSize: 18, color: whiteColor),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(height: 100,width: width,decoration: BoxDecoration(color: whiteColor,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),)
        ],
      ),
    );
  }
}

Container backGroundContainer(double height) {
  return Container(
    width: double.infinity,
    height: height * .3,
    color: const Color.fromARGB(255, 28, 44, 43),
  );
}
