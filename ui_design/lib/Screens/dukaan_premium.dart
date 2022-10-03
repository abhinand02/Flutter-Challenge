import 'package:flutter/material.dart';
import 'package:ui_design/constants/styles.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DukaanPremiumPage extends StatefulWidget {
  const DukaanPremiumPage({super.key});

  @override
  State<DukaanPremiumPage> createState() => _DukaanPremiumPageState();
}

class _DukaanPremiumPageState extends State<DukaanPremiumPage> {
   final  videoURL ='https://youtu.be/id1E0lqnUtY';

 late YoutubePlayerController _controller;

 @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(initialVideoId: videoID!,
    flags:const YoutubePlayerFlags(
      autoPlay: false,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [appBar(), stackCard()],
            ),
            height20,
            heading(),
            height10,
            featuresTile(
                title: 'Custom domain name',
                subtitle:
                    'Get your own custom domain and  build your brand on the  internet.',
                icon: Icons.sports_basketball_outlined),
            featuresTile(
                title: 'Verified seller badge',
                subtitle:
                    'Get green verified badge under your store name and  build trust.',
                icon: Icons.verified_outlined),
            featuresTile(
                title: 'Dukaan for PC',
                subtitle:
                    'Access all the  exclusive premium features on Dukaan for PC',
                icon: Icons.laptop_mac_sharp),
            featuresTile(
                title: 'Priority support',
                subtitle:
                    'Get your questions resolved with our priority customer support',
                icon: Icons.sports_basketball_outlined),
               const Divider(thickness: 4,),
                height20,
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('What is Dukaan  Premium?',style: boldText,),
                ),
                height10,
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const
                  EdgeInsets.only(left: 20,right: 20),
                  child: SizedBox(
                    // width: 400,
                    // height: 200,
                    child: YoutubePlayer(controller: _controller,showVideoProgressIndicator: true,),)
                ),
                height20
          ],
        ),
      ),
    );
  }
}

Column appBar() {
  return Column(
    children: [
      AppBar(
        elevation: 0,
        toolbarHeight: 170,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 130),
          child: Text('Dukaan Premium'),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(bottom: 130),
          child: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      const SizedBox(
        width: double.infinity,
        height: 100,
      )
    ],
  );
}

Positioned stackCard() {
  return Positioned(
    top: 100,
    left: 15,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 350,
        height: 190 ,
        child: Column(
          children: [
            height20,
            const Image(
              image: AssetImage(
                'assets/images/download.png',
              ),
              width: 150,
            ),
            height20,
            const Text(
              'Get Dukaan Premium for just \n₹4,999/year',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            height10,
            Text(
              'All the advanced features for scaling your \nbusiness',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: blackColor),
            )
          ],
        ),
      ),
    ),
  );
}

Padding heading() {
  return Padding(
    padding: const EdgeInsets.only(left: 15),
    child: Text(
      'Features',
      style: boldText,
    ),
  );
}

ListTile featuresTile(
    {required String title, required String subtitle, required IconData icon}) {
  return ListTile(
    contentPadding: EdgeInsets.all(10),
    leading: CircleAvatar(
      radius: 30,
      child: CircleAvatar(
        radius: 27,
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          size: 35,
        ),
      ),
    ),
    title: Text(
      title,
      style: boldText,
    ),
    subtitle: Text(
      subtitle,
      style: greyButtonText,
    ),
  );
}
