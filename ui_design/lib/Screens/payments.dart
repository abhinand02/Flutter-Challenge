import 'package:flutter/material.dart';

import '../constants/styles.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainCard(),
            listItems('Default Method', 'Online Payments',
                Icons.arrow_forward_ios_rounded),
            listItems('Payment Profile', 'Bank Account',
                Icons.arrow_forward_ios_rounded),
            divider,
            listItems('Payments Overview', 'Life Time ',
                Icons.keyboard_arrow_down_rounded),
            Row(
              children: [
                secondCard(const Color.fromARGB(255, 204, 142, 48),
                    'AMOUNT ON HOLD', '₹0'),
                secondCard(Colors.green, 'AMOUNT RECEVIED', '₹13,332'),
              ],
            ),
            height10,
            transactionHeading(),
            height10,
            threeButton(),
            orderdeItems(text1: 'Order #1688068',date: 'Jul 12, 02:06 PM',price: '₹799',text2: 'Successful',text3: '₹799 deposited to 58860200000138',image: 'assets/images/tshirt.jpg'),
            orderdeItems(text1: 'Order #1457741',date: 'Apr 26, 07:47 AM',price: '₹397.4',text2: 'Successful',text3: '₹397.4 deposited to 58860200000138',image: 'assets/images/mug.jpg'),
            orderdeItems(text1: 'Order #1408896',date: 'Apr 11, 10:54 AM',price: '₹686.42',text2: 'Successful',text3: '₹686.42 deposited to 58860200000138',image: 'assets/images/case.jpg'),
          ],
        ),
      ),
    );
  }

  Column orderdeItems({required String text1, required String date, required String price, required String text2, required String text3, required String image}){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                height: 50,width: 50,
                decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Image(image: AssetImage(image),fit: BoxFit.contain,)),
              title: Text(text1),
              subtitle: Text(date),
              trailing: Column(mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Text(price),
                height5,
                Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(radius: 5,backgroundColor: Colors.green,),
                    SizedBox(width: 5,),
                    Text(text2),
                  ],
                )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(text3,style: TextStyle(fontStyle: FontStyle.italic),),
            ),
            height10,
            divider,
          ],
        );
  }
}

AppBar appBar() {
  return AppBar(
    title: const Text('Payments'),
    leading: const Icon(Icons.arrow_back),
    centerTitle: true,
    actions: const [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.info_outline,
          size: 28,
        ),
      )
    ],
  );
}

Card mainCard() {
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: Colors.black12)),
    margin: const EdgeInsets.all(15),
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Limit',
            style: CardHeading,
          ),
          height10,
          Text(
            'A free limit up to  which you will receive the online payments directly in your bank',
            style: textStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey,
                value: .3,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '36,668 left out of  ₹50,000',
            style: fadeText,
          ),
          height20,
          ElevatedButton(
              onPressed: () {},
              child: Text(
                'Increase limit',
                style: buttonText,
              ))
        ],
      ),
    ),
  );
}

ListTile listItems(String text1, String text2, IconData icon) {
  return ListTile(
      dense: true,
      leading: Text(
        text1,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text2,
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
          Icon(
            icon,
            size: 20,
          )
        ],
      ));
}

  Padding transactionHeading() {
    return const Padding(
      padding:  EdgeInsets.only(left: 10),
      child: Text(
        'Transactions',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
Row threeButton() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.grey[300]),
                child: Text(
                  'On hold',
                  style: greyButtonText,
                )),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: Text('Payouts(15)', style: secondcardtext),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape:const StadiumBorder(), backgroundColor: Colors.grey[300]),
              child: Text(
                'Refunds',
                style: greyButtonText,
              ),
            ),
          ],
        );
  }

  Card secondCard(Color color, String text1, String text2) {
    return Card(
      margin: const EdgeInsets.only(left: 10),
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        margin: const EdgeInsets.all(13),
        width: 150,
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: secondcardtext,
            ),
           const SizedBox(
              height: 5,
            ),
            Text(
              text2,
              style: secondcardrupees,
            )
          ],
        ),
      ),
    );
  }