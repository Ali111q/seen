import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seen/controlller/show_controller.dart';
import 'package:seen/layout/Episode.dart';
import 'package:seen/model/show.dart';
import '../utils/colors.dart' as myColors;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    List<Show> list = Provider.of<ShowController>(context).searchList;
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [myColors.firstBackGround, myColors.sceondBackGround],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            title: TextField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                Provider.of<ShowController>(context, listen: false)
                    .search(value);
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
          ),
          body: ListView(children: [
            ...list.map((e) => ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(context) => EpisodeScreen(e.id),));
              },
              title: Text(e.name, style: TextStyle(color: Colors.white),),
            subtitle: Text(e.year!, style: TextStyle(color: Colors.grey),),
            leading: Image.network(e.image!),
            ))
          ],),
        ));
  }
}
