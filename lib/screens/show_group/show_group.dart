import 'dart:ui';

import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/group_manager.dart';
import 'package:attendance/navigation/screens.dart';
import 'package:attendance/screens/show_group/components/group_top_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Show_Group extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: Attendance_Screens.groupcheck,
      key: ValueKey(Attendance_Screens.groupcheck),
      child: Show_Group(),
    );
  }

  Show_Group({
    Key? key,
  }) : super(key: key);

  @override
  _Show_GroupState createState() => _Show_GroupState();
}

class _Show_GroupState extends State<Show_Group> {
  var colors = [
    Colors.grey[600],
    Colors.white,
  ];
  var text_colors = [Colors.white, Colors.black];

  Map<String, dynamic> _add_data = {
    'year': null,
  };
  // ScrollController _sc = new ScrollController();

  var yearController = TextEditingController();

  String text_value = '';

  bool _isloading = true;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      Provider.of<GroupManager>(context, listen: false).resetlist();
      try {
        await Provider.of<GroupManager>(context, listen: false)
            .getMoreData()
            .then((_) {
          setState(() {
            _isloading = false;
          });
        });
      } catch (e) {}
      if (!mounted) return;

      // _sc.addListener(() {
      //   if (_sc.position.pixels == _sc.position.maxScrollExtent) {
      //     Provider.of<GroupManager>(context, listen: false).getMoreData();
      //   }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[350],
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Show_Group_Top_Page(
                  size: size,
                ),
                Container(
                  color: Colors.white,
                  height: 20,
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20,
                        end: 20,
                        top: 10,
                      ),
                      child: Container(
                        child: Consumer<GroupManager>(
                          builder: (builder, groupManager, child) =>
                              groupManager.groups.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        'لا يوجد مجموعات',
                                        style: TextStyle(fontFamily: 'GE-Bold'),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: groupManager.groups.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int Index) =>
                                              Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        color: colors[Index % colors.length],
                                        child: ListTile(
                                          trailing: Text(
                                            groupManager.groups[Index]
                                                        .teacher ==
                                                    null
                                                ? ''
                                                : groupManager.groups[Index]
                                                    .teacher!.name!,
                                            style: TextStyle(
                                                color: text_colors[
                                                    Index % colors.length],
                                                fontFamily: 'GE-light'),
                                          ),
                                          subtitle: Text(
                                            groupManager.groups[Index].subject!
                                                    .name ??
                                                '',
                                            style: TextStyle(
                                                color: text_colors[
                                                    Index % colors.length],
                                                fontFamily: 'GE-light'),
                                          ),
                                          onTap: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => Show_Group_Class()));
                                            Provider.of<AppStateManager>(
                                                    context,
                                                    listen: false)
                                                .goToSinglegroup(
                                                    true,
                                                    groupManager
                                                        .groups[Index].id
                                                        .toString(),
                                                    groupManager.groups[Index]);
                                          },
                                          title: Text(
                                            groupManager.groups[Index].name!,
                                            style: TextStyle(
                                                color: text_colors[
                                                    Index % colors.length],
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'GE-medium'),
                                          ),

                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Container(
                                          //     decoration: BoxDecoration(
                                          //       borderRadius:
                                          //           BorderRadius.all(Radius.circular(5)),
                                          //       border: Border.all(
                                          //         color: Colors.grey,
                                          //         width: 0.7,
                                          //       ),
                                          //     ),
                                          //     height: 50,
                                          //     child: Material(
                                          //       elevation: 5.0,
                                          //       borderRadius: BorderRadius.circular(5.0),
                                          //       color: colors[Index % colors.length],
                                          //       child: Center(
                                          //         child: Text(
                                          //           groupManager.groups[Index].name!,
                                          //           style: TextStyle(
                                          //               color: text_colors[
                                          //                   Index % colors.length],
                                          //               fontWeight: FontWeight.bold),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    ));
  }
}
