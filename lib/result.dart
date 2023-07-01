import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes/boxes.dart';
import 'models/notes_model.dart';

class result extends StatefulWidget {
  const result({Key? key}) : super(key: key);

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  List<Color> colors = [
    Colors.purple,
    Colors.black38,
    Colors.green,
    Colors.blue,
    Colors.red
  ];

  Random random = Random(3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
                itemCount: box.length,
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: colors[random.nextInt(4)],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data[index].title.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Spacer(),
                                InkWell(
                                    onTap: () {
                                      delete(data[index]);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                //child: Icon(Icons.edit, color: Colors.white,)) ,
                              ],
                            ),
                            Text(
                              data[index].description.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }
}
