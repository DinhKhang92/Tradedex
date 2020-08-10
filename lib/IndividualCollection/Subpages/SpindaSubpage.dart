import 'package:flutter/material.dart';
import '../../Global/GlobalConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'Components/fillList.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';

class SpindaSubpage extends StatefulWidget {
  final List<dynamic> spindaList;
  final List<dynamic> spindaListTotal;
  final String name;
  final Profile myProfile;
  SpindaSubpage(this.spindaList, this.spindaListTotal, this.name, this.myProfile);
  @override
  State<StatefulWidget> createState() {
    return SpindaSubpageState(this.spindaList, this.spindaListTotal, this.name, this.myProfile);
  }
}

class SpindaSubpageState extends State<SpindaSubpage> {
  List<dynamic> spindaList;
  List<dynamic> spindaListTotal;
  String name;
  Profile myProfile;
  SpindaSubpageState(spindaList, spindaListTotal, name, myProfile) {
    this.spindaList = spindaList;
    this.spindaListTotal = spindaListTotal;
    this.name = name;
    this.myProfile = myProfile;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          languageFile['PAGE_INDIVIDUAL_COLLECTION']['SPINDA_SUBPAGE']['TITLE'],
          style: TextStyle(color: titleColor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              MdiIcons.eyeOff,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                this.spindaList.clear();
              });
              saveIndividualCollectionSingleListFirebase(this.spindaList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SPINDA']);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: iconColor,
            ),
            onPressed: () {
              setState(() {
                fillList(this.spindaList, this.spindaListTotal);
              });
              saveIndividualCollectionSingleListFirebase(this.spindaList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SPINDA']);
            },
          ),
        ],
      ),
      body: spindaSubpageBody(),
    );
  }

  Widget showSpinda(String idx, bool needPokemon) {
    return Stack(
      children: <Widget>[
        Center(
          child: Image(
            color: needPokemon ? silhouetteColor : null,
            image: AssetImage('assets_bundle/pokemon_icons_spinda/$idx'),
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
    if (this.spindaList.contains(idx))
      return false;
    else
      return true;
  }

  String getSpindaForm(String idx) {
    String spindaForm = (int.parse(idx.split('_')[1].split('.')[0]) - 10).toString();
    return spindaForm;
  }

  Widget spindaSubpageBody() {
    return Container(
      color: backgroundColor,
      child: GridView.builder(
        itemCount: this.spindaListTotal.length,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, i) {
          String idx = this.spindaListTotal[i];
          bool needPokemon = checkNeedPokemon(idx);
          return GridTile(
            child: InkResponse(
              child: showSpinda(idx, needPokemon),
              onTap: () {
                setState(() {
                  needPokemon ? spindaList.add(idx) : spindaList.remove(idx);
                });
                saveIndividualCollectionSingleListFirebase(this.spindaList, this.myProfile, name, rootLanguageFile['PAGE_INDIVIDUAL_COLLECTION']['LIST_TYPES']['SPINDA']);
              },
            ),
            footer: Text(
              '"${getSpindaForm(idx)}"',
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
          );
        },
      ),
    );
  }
}
