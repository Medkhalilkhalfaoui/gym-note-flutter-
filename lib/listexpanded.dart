import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Color v = Colors.green;
Color r = Colors.red;

List<Item> data = [];

class Item {
  Image img;
  String expandedValue;
  String headerValue;
  bool isExpanded;
  DateTime dt;
  int phone;
  int prix;

  Item({
    this.img,
    this.expandedValue,
    this.headerValue,
    this.dt,
    this.phone,
    this.prix,
    this.isExpanded = false,
  });
}

/*List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);


      });
    });
    return Item(
        headerValue: 'user $index',
        expandedValue: 'takewando',
        dt: DateTime.now(),
        phone: 10000,
        prix: 30);
  });
}*/

class MyStatefulWidget extends StatefulWidget {
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          data[index].isExpanded = !isExpanded;
        });
      },
      children: data.map<ExpansionPanel>((Item item) {
        var now = DateTime.now();
        var dateitemorign = item.dt;
        var form = DateFormat.yMMMd().format(item.dt);
        var dat = form.toString();
        var ind= data.indexOf(item);
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading:Container(
                margin: EdgeInsets.only(left: 0, right: 2, top: 6),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(

                    borderRadius: BorderRadius.circular(100),
                    child: item.img
                ),
              ),
              title: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: '.',
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: now.isAfter(dateitemorign)? r:v
                        )),
                    TextSpan(
                        text: item.headerValue,
                        style: TextStyle(fontSize: 16))
                  ],
                ),
              ),

            );
          },
          body: ListTile(
              title: Text(
                'Information :',
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 2, top: 6),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: item.img),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Filières :' + item.expandedValue,
                      ),
                      Text('Téléphone : ' + "${item.phone}"),
                      Text("Date EX : " + dat),
                      Text("Prix :" + "${item.prix}" + ' DT'),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          InkWell(
                            child: Text(
                              'Prolongation',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Future<Null> _selectedDate(
                                  BuildContext context) async {
                                DateTime _datePicker = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                );
                                if (_datePicker != null &&
                                    _datePicker != item.dt) {
                                  setState(() {
                                    item.dt = _datePicker;
                                  });
                                }
                              }

                              setState(() {
                                _selectedDate(context);
                              });
                            },
                          ),
                          Text('/'),
                          InkWell(
                            child: Text(
                              'Supprimer',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              setState(() {
                                data.removeWhere(
                                    (Item currentItem) => item == currentItem);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              onTap: (){},
              //trailing: const Icon(Icons.delete),
              ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
