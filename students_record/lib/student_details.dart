import 'dart:io';

import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:students_record/constants/styles.dart';
import 'db/db.dart';
import 'db/functions/db_functions.dart';


class StudentDetails extends StatefulWidget {
  // String imagePath = 'images/default_person_img.png';
  final String name;
  final String sclass;
  final String phnNumber;
  final String age;
  int id;
  final Uint8List image;
  StudentDetails(
      {super.key,
      required this.image,
      required this.id,
      required this.name,
      required this.sclass,
      required this.phnNumber,
      required this.age});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
     Uint8List? _image;
  Future<void> imagePick() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null){
      return;
    }
    final temp = await image.readAsBytes();

    print('printing file format image  $temp');
    setState(() {
      this._image = temp;
    });
  }
  TextEditingController nameController = TextEditingController();

  TextEditingController phnNumberController = TextEditingController();

  TextEditingController classController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  bool textEdit = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            profileImage(),
            const SizedBox(
              height: 20,
            ),
            inPutField(
                formfieldheading: 'Student Name',
                controller: nameController,
                text: widget.name),
            inPutField(
                formfieldheading: 'Phone Number',
                controller: phnNumberController,
                text: widget.phnNumber),
            inPutField(
                formfieldheading: 'Class',
                controller: classController,
                text: widget.sclass),
            inPutField(
                formfieldheading: 'Age',
                controller: ageController,
                text: widget.age),
            editFormButtons(context)
          ],
        ),
      ),
    );
  }

  Padding editFormButtons(BuildContext context) {
    return Padding(
      padding: horizontalPadding20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:  Text('Cancel',style: whiteColor),
          ),
          ElevatedButton(
            onPressed: () {
              print(nameController.text);
              updateDetails(widget.id);
              Navigator.of(context).pop();
            },
            child:  Text('Save',style: whiteColor),
          ),
        ],
      ),
    );
  }

  GestureDetector profileImage() {
    return GestureDetector(
      onTap: imagePick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          CircleAvatar(
            backgroundImage:_image!= null? MemoryImage(_image!) :MemoryImage(widget.image),
            radius: 60,
          ),
        ],
      ),
    );
  }

  Padding inPutField(
      {required String formfieldheading,
      required TextEditingController controller,
      required String text}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formfieldheading,
            style: buttonTextStyle,
          ),
          TextField(
            controller: controller,
            readOnly: textEdit,
            decoration: InputDecoration(
                hintText: text,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      textEdit = false;
                    });
                  },
                  icon: const Icon(Icons.edit),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(2))),
          ),
        ],
      ),
    );
  }

  Future<void> updateDetails(int id) async {
    var name = nameController.text;
    var sclass = classController.text;
    var phnNumber = phnNumberController.text;
    var age = ageController.text;
     _image ??= widget.image;

    if (name.isEmpty || age.isEmpty || phnNumber.isEmpty || sclass.isEmpty) {
      if (name.isEmpty) {
        name = widget.name;
        print("name$name");
      }
      if (age.isEmpty) {
        age = widget.age;
      }
      if (phnNumber.isEmpty) {
        phnNumber = widget.phnNumber;
      }
      if (sclass.isEmpty) {
        sclass = widget.sclass;
      }
    }

    final student = StudentModel(
        name: name, age: age, phnnumber: phnNumber, standard: sclass, id: id,image: _image);
    updateStudentDetails(student, id);
  }
}
