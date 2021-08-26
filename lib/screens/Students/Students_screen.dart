import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/navigation/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'components/Filter_Container.dart';
import 'components/Students_Top_Page.dart';
import 'components/Students_page_title.dart';

import 'components/table/Row_builder.dart';
import 'components/table/table_head.dart';

class Students_Screen extends StatelessWidget {
  final String? groupid;
  static MaterialPage page({
    required String group_id,
  }) {
    return MaterialPage(
      name: Attendance_Screens.data_students,
      key: ValueKey(Attendance_Screens.data_students),
      child: Students_Screen(
        groupid: group_id,
      ),
    );
  }

  const Students_Screen({
    Key? key,
    this.groupid,
  }) : super(key: key);

  Widget build(BuildContext context) {
    // print(groupid);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kbackgroundColor2,
        body: (Column(
          children: [
            Student_Top_Page(size: size, groupId: groupid),
            Consumer<AppStateManager>(
              builder: (builder, appstatemanager, child) => Students_Page_Title(
                  title: appstatemanager.getGroupSelected.name),
            ),
            Filter_Container(),
            Expanded(
              child: Column(
                children: [
                  TABLE_HEAD(size: size),
                  Rows_Builder(groupId: groupid, size: size),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
