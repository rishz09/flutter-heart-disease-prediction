//ignore_for_file: prefer_const_constructors

import 'package:app/database_helper.dart';
import 'package:flutter/material.dart';
import 'detail.dart';
import 'card_detail.dart';

class DetailsList extends StatefulWidget {
  const DetailsList({super.key});

  @override
  State<DetailsList> createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Detail>? detailList;
  int count = 0, flag = 0;
  @override
  Widget build(BuildContext context) {
    if (flag == 0) {
      updateDetailView();
      flag = 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Saved Profiles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            icon: Icon(Icons.home_sharp),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 226, 89, 135),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 218, 231),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: getDetailListView(),
      ),
    );
  }

  ListView getDetailListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleMedium;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  Colors.red[this.detailList![position].pred.toInt()],
              child: Icon(Icons.person, color: Colors.red),
            ),
            title: Text(this.detailList![position].title, style: titleStyle),
            subtitle: Text(this.detailList![position].date),
            trailing: GestureDetector(
              onTap: () {
                debugPrint('Delete icon tapped');
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Profile?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _delete(context, detailList![position]);
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
              child: Icon(Icons.delete, color: Colors.grey),
            ),
            onTap: () {
              debugPrint('ListTile tapped');
              navigateToCardDetail(this.detailList![position]);
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Detail detail) async {
    int result = await databaseHelper.deleteDetail(detail.id!);
    if (result != 0) {
      _showSnackBar(context, 'Profile Deleted Successfully!');
      updateDetailView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateDetailView() async {
    await databaseHelper.initializeDatabase();
    List<Detail> detailListFuture = await databaseHelper.getDetailList();
    setState(() {
      this.detailList = detailListFuture;
      this.count = detailListFuture.length;
      debugPrint('COUNT = $count');
    });
  }

  void navigateToCardDetail(Detail detail) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CardDetail(detail);
    }));

    updateDetailView();
  }
}
