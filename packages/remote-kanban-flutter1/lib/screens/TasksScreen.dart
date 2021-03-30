import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fl_kanban/entities/BoardColumn.dart';
import 'package:test_fl_kanban/entities/LocalName.dart';
import 'package:test_fl_kanban/localizations/MainLocalizations.dart';
import 'package:test_fl_kanban/models/TasksModel.dart';

List<BoardColumn> columns = [
  BoardColumn(id: '0', name: LocalName(en: 'On hold', ru: 'В очереди')),
  BoardColumn(id: '1', name: LocalName(en: 'In progress', ru: 'В процессе')),
  BoardColumn(id: '2', name: LocalName(en: 'Needs review', ru: 'Нужен отзыв')),
  BoardColumn(id: '3', name: LocalName(en: 'Approved', ru: 'Принято')),
];

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: columns.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 80.0,
          automaticallyImplyLeading: false,
          actions: [
            FittedBox(
              child: FloatingActionButton(
                  onPressed: () => Navigator.of(context).pushNamed('/'),
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryTextTheme.bodyText1.color,
                  ),
                  backgroundColor: Theme.of(context).accentColor),
            )
          ],
          bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              tabs: columns
                  .map((BoardColumn e) => Text(
                        e.name.getName(MainLocalizations.locale),
                      ))
                  .toList()),
        ),
        body: TabBarView(
          controller: _tabController,
          children: columns.map((e) => TabTasksView(columnId: e.id)).toList(),
        ));
  }
}

class TabTasksView extends StatelessWidget {
  final String columnId;
  TabTasksView({@required this.columnId});
  @override
  Widget build(BuildContext context) {
    TasksModel tasksModel = Provider.of<TasksModel>(context);

    return FutureBuilder(
        future: tasksModel.fetchTasksForColumn(columnId: columnId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            return ReorderableListView(
                children: tasksModel
                    .getTasksForColumn(columnId: columnId)
                    .map((e) => Card(
                        key: Key(e.id.toString()),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('ID: ${e.id.toString()}',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w100)),
                                ],
                              ),
                              Align(
                                child: Text(e.text),
                                alignment: Alignment.centerLeft,
                              )
                            ],
                          ),
                        )))
                    .toList(),
                // TODO: implement reorder function
                onReorder: (int i, int b) {});
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
