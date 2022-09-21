import 'package:flutter/material.dart';
import 'package:ui_design/constants/styles.dart';

class CatalougePage extends StatelessWidget {
  const CatalougePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:const Text('Catalogue'),
          actions:const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.search,size: 30,),
            )
            ],
            bottom: const TabBar(
              tabs: [
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text('Products',style: TextStyle(fontSize: 20),),
              ),
              Text('Categories',style: TextStyle(fontSize: 20),)
            ],),
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Column(children: [
           catalogueCard(image: 'assets/images/case.jpg',name:'Couch Potato | Women',price: '₹799' ),
            catalogueCard(image: 'assets/images/mug.jpg',name:'Mug | Explore',price: '₹399' ),
            catalogueCard(image: 'assets/images/tshirt.jpg',name:'T-shirt | Men\'s Black Colour',price: '₹799' ),
             catalogueCard(image: 'assets/images/case.jpg',name:'Couch Potato | Women',price: '₹799' ),
            ],),
          ),
         
          Column()
                ]),
      ),
    );
  }
}

  Card catalogueCard({required String name, required  String price, required String image}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      margin: const EdgeInsets.only(top: 15,left: 20,right: 20),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 350,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                   decoration: BoxDecoration(border: Border.all(width: .5,color: Colors.black12)),
                  child: Image(image: AssetImage(image),fit: BoxFit.fill,),
                  ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  height: 109,
                  width: 232,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(name,style: textStyle,),
                          Text('⁞   ',style: boldText,)
                        ],
                      ),
                      const Text('1 Piece'),
                      height5,
                      Text(price,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      height5,
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        const  Text('In stock',style: TextStyle(fontSize: 15,color: Colors.green),),
                          Switch(
                            value: true, onChanged: (value){})
                        ],
                      )
                    ],
                  ),),
              ],
            ),height5,
            Divider(endIndent: 1,indent: 1,thickness: 2,),
            height10,
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children:const [
              Icon(Icons.share_outlined),
              SizedBox(width: 10,),
              Text('Share Product'),
            ],),
            height10,
          ],
        ),
      ),
      
    );
  }