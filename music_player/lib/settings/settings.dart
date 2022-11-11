import 'package:flutter/material.dart';
import 'package:music_player/constants/style.dart';
import 'package:music_player/main.dart';
import 'package:music_player/settings/about.dart';
import 'package:music_player/settings/privacy_policy.dart';
import 'package:music_player/settings/terms_conditions.dart';
import 'package:music_player/widgets/method.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool notificationSwitch = true;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Settings'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const ShareApp(),
              const NotifictionSwitch(),
              const SwitchTheme(),
              SettingTileItems(
                icon: Icons.privacy_tip_outlined,
                text: 'Privacy Policy',
                classname: const PrivacyPolicy(),
              ),
              SettingTileItems(
                icon: Icons.description_outlined,
                text: 'Terms & Conditions',
                classname: const TermsAndCondition(),
              ),
              SettingTileItems(
                icon: Icons.info_outline,
                text: 'About',
                classname: const About(),
              ),
            ],
          ),
         const Text(
            'Version \n 1.0 ',
            textAlign: TextAlign.center,
            // style: TextStyle(fontSize: 14,),
          ),
        ],
      ),
    );
  }
}

class ShareApp extends StatelessWidget {
  const ShareApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const  EdgeInsets.only(left: 8,),
      child:   ListTile(
          leading: const Icon(Icons.share_outlined,size: 20,),
          title:  Text('Share this App',style: textWhite18,),
          onTap: share,
        ),
    );
  }
}

class NotifictionSwitch extends StatefulWidget {
  const NotifictionSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<NotifictionSwitch> createState() => _NotifictionSwitchState();
}

class _NotifictionSwitchState extends State<NotifictionSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        leading:const Icon(
          Icons.notifications_active_outlined,
          size: 25,
        ),
        title: Text(
          'Notifications',
          style: textWhite18,
        ),
        trailing: Switch(
          value: notificationSwitch,
          onChanged: (value) {
            setState(() {
              notificationSwitch = value;
            });
          },
          activeColor: selectedItemColor,
        ),
      ),
    );
  }
}
class SwitchTheme extends StatefulWidget {
  const SwitchTheme({super.key});

  @override
  State<SwitchTheme> createState() => _SwitchThemeState();
}

class _SwitchThemeState extends State<SwitchTheme> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        leading:const Icon(
          Icons.dark_mode_rounded,
          size: 25,
        ),
        title: Text(
          'Dark Mode',
          style: textWhite18,
        ),
        trailing: Switch(
          value: isDarkMode,
          onChanged: (value) {
            final themeProvider= Provider.of<ThemeProvider>(context,listen: false);
            if(isDarkMode == true){
              clearData();
            }else{
              saveData();
            }
            setState(() {
              isDarkMode = value;
            });
            isDarkMode ? themeProvider.setDarkMode(context)
            : themeProvider.setLightMode(context);
          },
          activeColor: selectedItemColor,
        ),
      ),
    );
  }
}

class SettingTileItems extends StatelessWidget {
  String text;
  IconData icon;
  Widget classname;
  SettingTileItems(
      {Key? key,
      required this.icon,
      required this.text,
      required this.classname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => classname));
      },
      leading: IconButton(
        onPressed: () {},
        icon: Icon(icon),
        iconSize: 25,
      ),
      title: Text(
        text,
        style: textWhite18,
      ),
    );
  }
}
share(){
  Share.share('www.google.com');
}

Future<void> saveData() async{
 final sharedpref = await SharedPreferences.getInstance();
 await sharedpref.setBool('isDarkMode', true);
  }
  Future<void> clearData() async{
 final sharedpref = await SharedPreferences.getInstance();
 await sharedpref.setBool('isDarkMode', false);
  }