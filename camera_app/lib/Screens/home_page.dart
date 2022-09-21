
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? image;
Future<void> takeImage()async{

var image = await ImagePicker().pickImage(source: ImageSource.camera);

if(image== null){
  return;
}
GallerySaver.saveImage(image.path);
}

Future<void> pickImage()async{
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image==null){
    return;
  }
  final temp = await image.readAsBytes();
  setState(() {
    this.image=temp;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera App'),),                                                                                                                                                                                                                                                                                                
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
            Container(
              width: 200,
              height: 200,
              child: image != null ?Image(image: MemoryImage(image!),fit: BoxFit.contain,) : Center(child: Text('image will display here',textAlign: TextAlign.center,)),
            ),
           Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               ElevatedButton.icon(onPressed: (){
                takeImage();
               }, icon:  Icon(Icons.camera_sharp), label: Text('Open Camera')),
               ElevatedButton.icon(onPressed: (){
                pickImage();
               }, icon: Icon(Icons.photo), label: Text('Open Gallery'))
             ],
           )
            ],
          ),
        ),
      ),
    );
  }
}