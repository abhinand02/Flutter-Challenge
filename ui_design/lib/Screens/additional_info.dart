import 'package:flutter/material.dart';
import 'package:ui_design/Screens/manage_store.dart';
import 'package:ui_design/constants/styles.dart';

class AdditinalInfoPage extends StatelessWidget {
  const AdditinalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: Column(
          children: [
            listItems(
                text: 'Share Dukaap App',
                prefixIcon: Icons.share_outlined,
                sufixIcon: const Icon(Icons.arrow_forward_ios)),
            listItems(
                text: 'Change Language',
                prefixIcon: Icons.chat_bubble_outline_rounded,
                sufixIcon: const Icon(Icons.arrow_forward_ios)),
            listItems(
                text: 'WhatsApp Chat Support',
                prefixIcon: Icons.whatsapp,
                sufixIcon: Switch(value:  true, onChanged: (value){
                })),
            listItems(
                text: 'Privacy Policy',
                prefixIcon: Icons.lock,
                ),
            listItems(
                text: 'Rate Us',
                prefixIcon: Icons.star_border_rounded,
               ),
            listItems(
                text: 'Sign Out',
                prefixIcon: Icons.logout,
                ),
                Expanded(
                  child: Column(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Version ',style: textStyle,),
                    const  Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Text('2.4.2'),
                      )
                    ],
                  ),
                ) 
          ],
        ));
  }
}

AppBar appBar() {
  return AppBar(
    title: const Text('Additional Information',),
    centerTitle: true,
    leading: const Icon(Icons.arrow_back),
  );
}

ListTile listItems(
    {required String text, required IconData prefixIcon, Widget? sufixIcon}) {
  // IconData icon;
  // String text;
  return ListTile(
    leading: Icon(prefixIcon),
    title: Text(text,style:  textStyle,),
    trailing: sufixIcon,
  );
}

