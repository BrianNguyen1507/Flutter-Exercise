import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class CongViec {
  String tenCv;
  DateTime date;
  String time;
  CongViec(this.tenCv, this.date, this.time);
  @override
  String toString() {
    return "$tenCv-${DateFormat('dd-MM-yyyy').format(date)} - $time";
  }
}

class _TodoListState extends State<TodoList> {
  List<CongViec> listTodo = <CongViec>[];

  final TextEditingController _controllerCv = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String selectedTime = DateFormat('kk:mm').format(DateTime.now());

  void resetDateTime() {
    _controllerCv.clear();
    selectedDate = DateTime.now();
    selectedTime = DateFormat('kk:mm').format(DateTime.now());
  }

  Future<void> _selectedDate(BuildContext context) async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024, 3),
      lastDate: DateTime(2202),
    );
    if (picker != null && picker != selectedDate) {
      setState(() {
        selectedDate = picker;
      });
    }
  }

  Future<void> _selectedTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Align(
              alignment: Alignment.center,
              child: Text(
                "TO DO LIST",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        body: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: Container(
                    child: listTodo.isNotEmpty
                        ? ListView.builder(
                            itemCount: listTodo.length,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                child: Card(
                                  borderOnForeground: true,
                                  color: const Color.fromRGBO(38, 38, 40, 200),
                                  elevation: 1,
                                  child: ListTile(
                                    title: Text(
                                      listTodo[index].tenCv,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Date: ${DateFormat('dd-MM-yyyy').format(listTodo[index].date)} | Time: ${listTodo[index].time}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _controllerCv.text =
                                            listTodo[index].tenCv;
                                        selectedDate = listTodo[index].date;
                                        selectedTime = listTodo[index].time;
                                      });
                                    },
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Do you want to remove?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Removed ${listTodo[index].tenCv}",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.blue,
                                                      textColor: Colors.white,
                                                      fontSize: 16,
                                                    );
                                                    listTodo.removeAt(index);
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Yes'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text("No item available"),
                          ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 50,
                          right: 50,
                        ),
                        child: Divider(
                          endIndent: BorderSide.strokeAlignCenter,
                          color: Colors.blue,
                          thickness: 2.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _controllerCv,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(width: 1.0)),
                            hintText: 'what do you want to do?',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18),
                            alignLabelWithHint: true,
                            hoverColor: Color.fromARGB(255, 55, 234, 43)),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Date:   ",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: DateFormat('dd-MM-yyyy')
                                          .format(selectedDate)
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: MaterialButton(
                                  child: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    _selectedDate(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Time:   ",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: selectedTime,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: MaterialButton(
                                  child: const Icon(
                                    Icons.av_timer_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    _selectedTime(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 10),
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue)),
                          onPressed: () {
                            setState(() {
                              if (_controllerCv.text.isNotEmpty) {
                                bool isAdded = false;
                                if (listTodo.isEmpty) {
                                  listTodo.add(
                                    CongViec(
                                      _controllerCv.text,
                                      selectedDate,
                                      selectedTime,
                                    ),
                                  );
                                  resetDateTime();
                                } else {
                                  for (int i = 0; i < listTodo.length; i++) {
                                    if (listTodo[i]
                                            .tenCv
                                            .compareTo(_controllerCv.text) ==
                                        0) {
                                      listTodo[i].date = selectedDate;
                                      listTodo[i].time = selectedTime;
                                      resetDateTime();
                                      isAdded = true;
                                      break;
                                    }
                                  }
                                  if (!isAdded) {
                                    listTodo.add(
                                      CongViec(
                                        _controllerCv.text,
                                        selectedDate,
                                        selectedTime,
                                      ),
                                    );
                                    resetDateTime();
                                  }
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Please fill your input todo name',
                                );
                              }
                            });
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
