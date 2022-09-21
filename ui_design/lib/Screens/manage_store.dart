import 'package:flutter/material.dart';
import 'package:ui_design/constants/styles.dart';

class ManageStore extends StatelessWidget {
  const ManageStore({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 222, 222),
      appBar: appBar(),
      body: Column(
        children: [
          Row(
            children: [
              card(width,
                  false,
                  text: 'Marketing \nDesigns',
                  icon: Icons.volume_mute,
                  color: Colors.orange),
              card(width,
                  false,
                  text: 'Online \nPayments',
                  icon: Icons.currency_rupee_sharp,
                  color: Colors.green)
            ],
          ),
          Row(
            children: [
              card(width,
                  false,
                  text: 'Discount \nCoupons',
                  icon: Icons.discount_outlined,
                  color: Color.fromARGB(255, 241, 205, 156)),
              card(width,
                   false,
                  text: 'My \nCustomers',
                  icon: Icons.supervisor_account_sharp,
                  color: Colors.blueAccent)
            ],
          ),
          Row(
            children: [
              card(width,
              false,
                  text: 'Store OR \nCode',
                  icon: Icons.qr_code_scanner_rounded,
                  color: Colors.grey),
              card(width,
              false,
                  text: 'Extra \nCharges',
                  icon: Icons.crop_square,
                  color: Colors.blue.shade900)
            ],
          ),
          Row(
            children: [
              card(width,
              true,
                  text: 'Order \nForm',
                  icon: Icons.description_outlined,
                  color: Colors.red.shade300),
            ],
          ),
        ],
      ),
    );
  }

  Padding card(double width,bool istrue,
      {required String text, required IconData icon, required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: width * .39,
          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
          height: width * .26,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      icon,
                      color: WhiteColor,
                    ),
                  ),
                  Visibility(
                    visible: istrue,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.green,),
                      width: 40,
                      height: 20,
                      child:const Center(
                          child: Text(
                        'New',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
              Text(
                text,
                style: cardTextstyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

AppBar appBar() {
  return AppBar(
    title: const Text(
      'Manage Store',
    ),
    centerTitle: true,
  );
}


