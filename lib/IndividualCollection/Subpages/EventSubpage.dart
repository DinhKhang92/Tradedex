import 'package:flutter/material.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import '../../Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Components/fillList.dart';

class EventSubpage extends StatefulWidget {
  final List<dynamic> eventList;
  final List<dynamic> eventListTotal;
  final String name;
  final Profile myProfile;
  EventSubpage(this.eventList, this.eventListTotal, this.name, this.myProfile);

  @override
  State<StatefulWidget> createState() {
    return EventSubpageState(this.eventList, this.eventListTotal, this.name, this.myProfile);
  }
}

class EventSubpageState extends State<EventSubpage> {
  List<dynamic> eventList;
  List<dynamic> eventListTotal;
  String name;
  Profile myProfile;
  EventSubpageState(eventList, eventListTotal, name, myProfile) {
    this.eventList = eventList;
    this.eventListTotal = eventListTotal;
    this.name = name;
    this.myProfile = myProfile;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageFile['PAGE_INDIVIDUAL_COLLECTION']['EVENT_SUBPAGE']['TITLE'],
          style: TextStyle(color: titleColor),
        ),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              MdiIcons.eyeOff,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                this.eventList.clear();
              });
              saveIndividualCollectionSingleListFirebase(this.eventList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['EVENT']);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                this.eventList = fillList(this.eventList, this.eventListTotal);
              });
              saveIndividualCollectionSingleListFirebase(this.eventList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['EVENT']);
            },
          ),
        ],
      ),
      body: eventSubpageBody(),
    );
  }

  Widget showEvent(String idx, bool needPokemon) {
    return Stack(
      children: <Widget>[
        Center(
          child: Image(
            color: needPokemon ? silhouetteColor : null,
            image: AssetImage('assets_bundle/pokemon_icons_event/$idx'),
            fit: BoxFit.scaleDown,
          ),
        ),
        idx.contains('shiny')
            ? Image(
                alignment: Alignment(-1, -1),
                height: 30,
                width: 30,
                image: AssetImage('collection/ic_shiny.png'),
                color: secondaryListColor,
              )
            : Text(" "),
      ],
    );
  }

  bool checkNeedPokemon(String idx) {
    if (this.eventList.contains(idx))
      return false;
    else
      return true;
  }

  Widget eventSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.eventListTotal.length,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, i) {
          String idx = this.eventListTotal[i];
          bool needPokemon = checkNeedPokemon(idx);
          return GridTile(
            child: InkResponse(
              child: showEvent(idx, needPokemon),
              onTap: () {
                setState(() {
                  needPokemon ? this.eventList.add(idx) : this.eventList.remove(idx);
                });
                saveIndividualCollectionSingleListFirebase(this.eventList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['EVENT']);
              },
            ),
          );
        },
      ),
    );
  }
}
