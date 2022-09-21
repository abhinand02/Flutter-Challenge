import 'package:flutter/material.dart';
import 'package:ui_design/constants/styles.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ListView(children: [
          height5,
          status(),
          height10,
          dividernormal,
          receiptheading(),
          itemDetails(),
          grandTotaltile(),
          dividernormal,
          shareTag(),
          nameTag(),
          addressTag(),
          height20,
          Row(children: [
            SizedBox(
              width: 150,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City',style: boldText,),
                height5,
                Text('Banglore',style: textStyle,)
              ],
            ),),
            SizedBox(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pincode',style: boldText,),
                height5,
                Text('560061',style: textStyle,)
              ],
            ),)
          ],)
        ]),
      ),
    );
  }

  ListTile addressTag() {
    return ListTile(contentPadding: EdgeInsets.symmetric(horizontal: 0),
          title: Text('Address',style: boldText,),subtitle: Text('D 11 Chartered Beverly \nHils,Subramanyapura P.O',style: textStyle,),);
  }
}

AppBar appBar() {
  return AppBar(
    title: const Text(
      'Order #16880868',
    ),
    centerTitle: true,
    leading: const Icon(Icons.arrow_back),
  );
}

Row status() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'May 31, 05:42 PM',
        style: textStyle,
      ),
      Row(
        children: [
          const CircleAvatar(
            radius: 6,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Delivered',
            style: textStyle,
          ),
        ],
      ),
    ],
  );
}

Row receiptheading() {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(
      '1 ITEM',
      style: textStyle,
    ),
    TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.receipt),
        label: const Text(
          'RECEIPT',
          style: TextStyle(
            fontSize: 18,
          ),
        ))
  ]);
}

Column itemDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        contentPadding: EdgeInsets.only(left: 0, right: 0),
        leading: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black26),borderRadius: BorderRadius.circular(2)),
          child: const Image(fit: BoxFit.contain,
            image: AssetImage('assets/images/tshirt.jpg'),
          ),
        ),
        title: Text(
          'Explore | Men | Navy Blue',
          style: textStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height5,
            Text(
              '1 piece',
              style: fadeText,
            ),
            Text(
              'Size: XL',
              style: fadeText,
            ),
            height5,
          ],
        ),
      ),
      Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.blue),
            ),
            width: 20,
            height: 20,
            child: Center(
              child: Text(
                '1',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Text(
            ' x  ₹799',
            style: textStyle,
          ),
          Container(
            margin: EdgeInsets.only(left: 177),
            child: Text(
            '₹799',
            style: textStyle,
        ),
          ),
        ],
      ),
      height10,
      dividernormal,
    ],
  );
}

Column grandTotaltile() {
  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
        dense: true,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item Total',
              style: textStyle,
            ),
            height10,
            Text(
              'Delivery',
              style: textStyle,
            )
          ],
        ),
        trailing: Column(
          children: [
            Text(
              '₹799',
              style: textStyle,
            ),
            height10,
            Text(
              'FREE',
              style: TextStyle(color: Colors.green, fontSize: 17),
            ),
          ],
        ),
      ),
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 0, right: 0),
        leading: Text(
          'Grand Total',
          style: boldText,
        ),
        trailing: Text(
          '₹799',
          style: boldText,
        ),
      )
    ],
  );
}
  ListTile shareTag() {
    return ListTile(dense: true,
          contentPadding:const EdgeInsets.only(left: 0, right: 0,bottom: 0),
          leading: Text('CUSTOMER DETAILS',style: fadeTextMedium,),
          trailing: Row(mainAxisSize: MainAxisSize.min, children:const [
            Icon(Icons.share_outlined,color: Colors.blue,),
            SizedBox(
              width: 10,
            ),
            Text(
              'SHARE',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            )
          ]),
        );
  }
    ListTile nameTag() {
    return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          title: Text('Deepa',style: textStyle,),subtitle: Text('+91-7829000484',style: fadeText,),
          trailing: Row(mainAxisSize: MainAxisSize.min,
            children: [
            CircleAvatar(radius: 22,child: CircleAvatar(radius: 20,backgroundColor: WhiteColor,child: Icon(Icons.call)),),
            SizedBox(width: 10,),
            Icon(Icons.whatsapp,size: 45,color: Colors.green,),
          ]),
          );
  }