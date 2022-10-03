import 'package:flutter/material.dart';
import 'package:promble1_ui/constants/style.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;                //get the mobile screen width and height using mediaquery
    double width = MediaQuery.of(context).size.width;

    double containerWidth = width - 40;                                // variable container width is the stacked card width 
    double mainCardPositionTop = (height * .35) / 2 + 20;              // Positions are calculated using the width and height of the screen 
    double mainCardPositionleft = (width - (width - 40)) / 2;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(children: [
        backGroundContainer(height),           //backGroundContainer is the green colored container 
        mainText(),                            //mainText is a method wich containing the main Heading of the screen
        stackItems(                            // this method is the root of the screen 
            mainCardPositionTop, mainCardPositionleft, containerWidth, width),
        Container()
      ]),
    );
  }

  Positioned stackItems(double mainCardPositionTop, double mainCardPositionleft,
      double containerWidth, double width) {
    return Positioned(
      top: mainCardPositionTop,
      left: mainCardPositionleft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: containerWidth,
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: containerWidth - 20,
                  height: containerWidth / 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cardBtn1(containerWidth, width),
                      cardBtns(containerWidth, width, text: 'Rounded Trip'),
                      cardBtns(containerWidth, width, text: 'Multi-City'),
                    ],
                  ),
                ),
                fromAndToContainer(containerWidth, width,
                    subtitle: 'London, NCD',
                    title: 'From',
                    icon: Icons.flight_takeoff_rounded),
                fromAndToContainer(containerWidth, width,
                    subtitle: 'Brastow, BSW',
                    title: 'To',
                    icon: Icons.flight_land_rounded),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          dropDown(),
          secondCard(containerWidth)
        ],
      ),
    );
  }

  Container secondCard(double containerWidth) {
    return Container(
          margin:const EdgeInsets.only(top: 30),
          width: containerWidth,
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(50)),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color:const Color.fromARGB(
                      255,
                      50,
                      217,
                      202,
                    ),
                    borderRadius: BorderRadius.circular(30)),
                margin:const  EdgeInsets.only(top: 20),
                width: containerWidth - 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top:15,left: 15,),
                      padding: const EdgeInsets.only(left:8,right: 8,top: 10,bottom: 8),
                      decoration: BoxDecoration(color: blackColor,borderRadius: BorderRadius.circular(10)),
                      child: Text('\$150',style: TextStyle(fontSize: 20,color: whiteColor),),
                    ),
                    Transform.rotate(
                        angle: 3.14 / 20.0,
                        child: Image.asset(
                          'assets/images/aeroplane.png',
                          width: containerWidth - 40,
                          height: 200,
                        ),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                           const Text('Flight Yogyakarta',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            Text('HJB- JKM',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: greyColor),)
                          ],
                          ),
              ),
             const SizedBox(height: 5,),
            ],
          ),
        );
  }

  Container dropDown() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Text(
            'Sort By',
            style: smalltext,
          ),
          Container(
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(30)),
            margin: const EdgeInsets.only(left: 10),
            padding:const EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
            child: DropdownButton(
              iconDisabledColor: Colors.orange,
              isDense: true,
              underline: const SizedBox(),
              hint: const Text('Highest Price'),
              items: const [],
              onChanged: ((value) {}),
            ),
          ),
        ],
      ),
    );
  }

  Container fromAndToContainer(double containerWidth, double width,
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: containerWidth - 20,
      height: containerWidth / 5,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(
          icon,
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: width * .06, color: blackColor),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: width * .037, color: greyColor),
        ),
      ),
    );
  }

  Padding mainText() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Let\'s Book Your \nFlight ',
            style: headingStyle,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/image1.png'),
          ),
        ],
      ),
    );
  }

  Container backGroundContainer(double height) {
    return Container(
      width: double.infinity,
      height: height * .4,
      color: const Color.fromARGB(255, 28, 44, 43),
    );
  }

  Container cardBtns(double containerWidth, double width,
      {required String text}) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: (containerWidth / 5),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: width * .04),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Container cardBtn1(double containerWidth, double width) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.greenAccent, borderRadius: BorderRadius.circular(20)),
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 10),
        height: (containerWidth / 5),
        child: Center(
          child: Text(
            'One Way',
            style: TextStyle(color: Colors.white, fontSize: width * .05),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
