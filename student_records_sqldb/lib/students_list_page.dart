import "package:flutter/material.dart";
import 'add_student.dart';
import 'constants/styles.dart';
import 'db/db.dart';
import 'db/functions/db_functions.dart';
import 'student_details.dart';

class StudentsRecord extends StatefulWidget {
  const StudentsRecord({super.key});

  @override
  State<StudentsRecord> createState() => _StudentsRecordState();
}

class _StudentsRecordState extends State<StudentsRecord> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            studentsList(context),
          ],
        ),
      ),
      floatingActionButton: studentDataAddButton(context),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Students Record',
        style: whiteColor,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: MySearchDelegete(),);
          },
          icon: const Icon(Icons.search),
        )
      ],
    );
  }

  FloatingActionButton studentDataAddButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddStudentPage()));
      },
      child: const Icon(
        Icons.person_add_alt_rounded,
        color: Colors.white,
      ),
    );
  }

  Expanded studentsList(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext ctx, List<StudentModel> studentList,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = studentList[index];
                  return ListTile(
                    onTap: () {
                      if (data.image == null) {
                        return;
                      }
                      print(data.image);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentDetails(
                            id: data.id!,
                            name: data.name,
                            age: data.age,
                            phnNumber: data.phnnumber,
                            sclass: data.standard,
                            image: data.image!,
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          data.image != null ? MemoryImage(data.image!) : null,
                      radius: 30,
                    ),
                    title: Text(data.name),
                    subtitle: Text("class: ${data.standard}"),
                    trailing: IconButton(
                      onPressed: () {
                        if (data.id != null) {
                          deletestudent(context, data.id!);
                        } else {
                          print('unable to delete id is null');
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider();
                },
                itemCount: studentList.length);
          }),
    );
  }

  deletestudent(BuildContext ctx, int id) async {
    return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          content: Text(
            'Are you sure to delete?',
            style: popupHeading,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: buttonTextStyle,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    deleteStudent(id);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Yes',
                    style: buttonTextStyle,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MySearchDelegete extends SearchDelegate{
  @override
  Widget? buildLeading(BuildContext context)=> IconButton(icon: const  Icon(Icons.arrow_back), onPressed: ()=>close(context, null),);

  @override
  List<Widget>? buildActions(BuildContext context)=> [
    IconButton(onPressed: (){
      if(query.isEmpty){
        close(context, null);
      }else{
        query='';
      }
    }, icon: const Icon(Icons.clear),)
  ];

  @override
  Widget buildResults(BuildContext context)=> Container();

  @override
  Widget buildSuggestions(BuildContext context){
    return searchSuggetions(context);
  }

  Widget searchSuggetions(BuildContext context){
    // getAllStudents();
   return ValueListenableBuilder(valueListenable: studentListNotifier, builder: (BuildContext ctx, List<StudentModel> studentList, Widget? child){
      return ListView.builder(itemCount:studentList.length,itemBuilder: (context, index) {
      final data = studentList[index];
      return ListTile(
                  onTap: () {
                    if (data.image == null) {
                      return;
                    }
                    // print(data.image);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StudentDetails(
                          id: data.id!,
                          name: data.name,
                          age: data.age,
                          phnNumber: data.phnnumber,
                          sclass: data.standard,
                          image: data.image!,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage:
                        data.image != null ? MemoryImage(data.image!) : null,
                    radius: 30,
                  ),
                  title: Text(data.name),
                  subtitle: Text("class: ${data.standard}"),
                );
    });;
    });
    }
    
  }


//  ValueListenableBuilder(
//         valueListenable: studentListNotifier,
//         builder: (BuildContext ctx, List<StudentModel> studentList,
//             Widget? child) {
//           return ListView.separated(
//               itemBuilder: (ctx, index) {
//                 final data = studentList[index];
//                 return ListTile(
//                   onTap: () {
//                     if (data.image == null) {
//                       return;
//                     }
//                     // print(data.image);
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => StudentDetails(
//                           id: data.id!,
//                           name: data.name,
//                           age: data.age,
//                           phnNumber: data.phnnumber,
//                           sclass: data.standard,
//                           image: data.image!,
//                         ),
//                       ),
//                     );
//                   },
//                   leading: CircleAvatar(
//                     backgroundImage:
//                         data.image != null ? MemoryImage(data.image!) : null,
//                     radius: 30,
//                   ),
//                   title: Text(data.name),
//                   subtitle: Text("class: ${data.standard}"),
//                 );
//               },
//               separatorBuilder: (ctx, index) {
//                 return const Divider();
//               },
//               itemCount: studentList.length);
//         }),