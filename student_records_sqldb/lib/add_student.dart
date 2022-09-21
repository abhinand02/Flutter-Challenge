import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'constants/styles.dart';
import 'db/db.dart';
import 'db/functions/db_functions.dart';



class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  Uint8List? image;
  Future<void> imagePcik() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery,);
    if(image == null){
      return;
    }
    final temp = await image.readAsBytes();


    print('printing file format image  $temp');
    setState(() {
      this.image = temp;
    });
  }
  TextEditingController nameController = TextEditingController();

  TextEditingController phnNumberController = TextEditingController();

  TextEditingController classController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              profileImage(),
              inPutField(hintText: 'Student Name', controller: nameController),
              inPutField(hintText: 'Phone Number', controller: phnNumberController),
              inPutField(hintText: 'Class', controller: classController),
              inPutField(hintText: 'Age', controller: ageController),
              addDetailsButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding addDetailsButton(BuildContext context) {
    return Padding(
      padding: horizontalPadding20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:  Text('Cancel',style: whiteColor,),
          ),
          ElevatedButton(
              onPressed: () {
                onAddStudentButtonClicked();
              },
              child:  Text('Save',style: whiteColor),),
        ],
      ),
    );
  }

  GestureDetector profileImage() {
    return GestureDetector(
      onTap: imagePcik,
      child: CircleAvatar(
        backgroundImage: image != null ? Image.memory
        (image!).image : null,
        radius: 60,
      ),
    );
  }

  Padding inPutField(
      {required TextEditingController controller, required String hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: controller,
            cursorHeight: 22,
            style: formTextStyle,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final name = nameController.text;
    final sclass = classController.text;
    final phnNumber = phnNumberController.text;
    final age = ageController.text;
    // final id = count;
    // count++;
    if (name.isEmpty || age.isEmpty || phnNumber.isEmpty || sclass.isEmpty) {
      null;
    } else {
      final student = StudentModel(
          name: name, age: age, phnnumber: phnNumber, standard: sclass);
          print(name);
      addStudent(student);
      addStudentDetail(context);
      nameController.clear();
      ageController.clear();
      phnNumberController.clear();
      classController.clear();
    }
  }

  void addStudentDetail(BuildContext ctx) async {
    return showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            title: const Text('Student Details Added'),
            content: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add More Details'),),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/'),);
                    },
                    child: const Text('Done'),
                  )
                ],
              ),
            ),
          );
        },
        );
  }
}
