import 'package:flutter/material.dart';
import 'package:tradedex/Contacts/Subpages/ContactOfficialCollectionSubpage.dart';
import 'package:tradedex/Contacts/Subpages/ContactPrimaryListSubpage.dart';
import 'package:tradedex/Contacts/Subpages/ContactWantedPrimaryListSubpage.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/Components/getPokemonImage.dart';
import 'package:tradedex/Global/Components/loadDataFirebase.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage();

  @override
  State<StatefulWidget> createState() {
    return ContactsPageState();
  }
}

class ContactsPageState extends State<ContactsPage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditControllerIdInput = TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String validId;

  bool isSearching;
  Icon searchIcon = Icon(Icons.search);
  String searchText;

  List<String> searchResult = List<String>();
  TextEditingController textEditController = TextEditingController();

  // variables
  int navIndex;
  bool autoValidate;
  Map pokemonNamesDict;
  Map pokemonNamesDictCopy;
  List<String> totalList;
  Map primaryListCounter;
  Map secondaryListCounter;
  bool isFavorite;
  bool isOfficialCollection;

  // contacts
  List<Contact> myContacts;

  // appbar
  Widget appBarTitle;

  Profile myProfile;

  ContactsPageState(pokemonNamesDict, myProfile) {
    this.navIndex = 0;
    this.autoValidate = false;
    this.totalList = new List<String>();
    this.isSearching = false;
    this.isFavorite = true;
    this.isOfficialCollection = false;

    this.myContacts = new List<Contact>();
    this.myProfile = myProfile;

    this.pokemonNamesDict = pokemonNamesDict;
    this.pokemonNamesDictCopy = new Map.from(pokemonNamesDict);
    this.primaryListCounter = new Map();
    this.secondaryListCounter = new Map();

    this.appBarTitle = Text(languageFile['PAGE_CONTACTS']['TITLE_02']);

    this.textEditController.addListener(() {
      if (this.textEditController.text.isEmpty) {
        setState(() {
          this.isSearching = false;
          searchText = "";
        });
      } else {
        setState(() {
          this.isSearching = true;
          searchText = this.textEditController.text;
        });
      }
    });

    this.pokemonNamesDict.forEach((key, value) {
      if (key.contains('alolan')) {
        this.pokemonNamesDictCopy.remove(key);
      }
    });
    // print(this.pokemonNamesDictCopy.length);
  }

  @override
  void initState() {
    loadContactsFirebase(this.myProfile).then((contacts) {
      setState(() {
        this.myContacts = contacts;
        getTotalList();
        getWantedCounterList();
      });
    });

    super.initState();
  }

  void getTotalList() {
    this.myContacts.forEach((contact) {
      for (int i = 0; i < contact.primaryList.length; i++) {
        if (!this.totalList.contains(contact.primaryList[i])) {
          this.totalList.add(contact.primaryList[i]);
        }
      }
      for (int i = 0; i < contact.secondaryList.length; i++) {
        if (!this.totalList.contains(contact.secondaryList[i])) {
          this.totalList.add(contact.secondaryList[i]);
        }
      }
    });
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    Map reversed = pokemonNamesDict.map((key, value) => MapEntry(value, key));

    if (isSearching != null) {
      // search in keys
      for (int i = 0; i < this.pokemonNamesDict.keys.length; i++) {
        String pokemon = this.pokemonNamesDict[this.pokemonNamesDict.keys.toList()[i]];
        if (pokemon.toLowerCase().contains(searchText.toLowerCase())) {
          String key = reversed[pokemon];
          for (int j = 0; j < this.myContacts.length; j++) {
            for (int k = 0; k < this.myContacts[j].primaryList.length; k++) {
              if (this.myContacts[j].primaryList[k].trim() == key) if (!searchResult.contains(key)) searchResult.add(key);
            }
          }
        }
      }
      // search in values
      for (int i = 0; i < this.pokemonNamesDict.values.length; i++) {
        String nr = reversed[this.pokemonNamesDict.values.toList()[i]];
        if (nr.contains(searchText.toLowerCase())) {
          for (int j = 0; j < this.myContacts.length; j++) {
            for (int k = 0; k < this.myContacts[j].primaryList.length; k++) {
              if (this.myContacts[j].primaryList[k].trim() == nr.trim()) if (!searchResult.contains(nr)) searchResult.add(nr);
            }
          }
        }
      }
    }
  }

  void handleSearchStart() {
    setState(() {
      isSearching = true;
    });
  }

  void handleSearchEnd() {
    setState(() {
      this.searchIcon = new Icon(
        Icons.search,
        color: iconColor,
      );
      this.appBarTitle = new Text(
        languageFile['PAGE_CONTACTS']['TITLE_02'],
        style: new TextStyle(
          color: titleColor,
        ),
      );
      isSearching = false;
      this.textEditController.clear();
    });
  }

  void searchPressed() {
    if (this.searchIcon.icon == Icons.search) {
      this.searchIcon = Icon(
        Icons.close,
        color: iconColor,
      );
      this.appBarTitle = TextField(
        autofocus: true,
        controller: this.textEditController,
        style: new TextStyle(color: iconColor),
        cursorColor: iconColor,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: iconColor)),
          prefixIcon: Icon(Icons.search, color: iconColor),
          hintText: languageFile['PAGE_CONTACTS']['SEARCH'],
          hintStyle: TextStyle(color: iconColor),
        ),
        onChanged: searchOperation,
      );
      handleSearchStart();
    } else {
      searchResult.clear();
      handleSearchEnd();
    }
  }

  void deleteContacts(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            languageFile['PAGE_CONTACTS']['DIALOG_DELETE']['TITLE'],
            style: TextStyle(color: textColor),
          ),
          content: Text(
            languageFile['PAGE_CONTACTS']['DIALOG_DELETE']['DESCRIPTION'],
            style: TextStyle(color: textColor),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                languageFile['PAGE_CONTACTS']['DIALOG_DELETE']['CANCEL'],
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(
                languageFile['PAGE_CONTACTS']['DIALOG_DELETE']['ACCEPT'],
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () {
                setState(() {
                  this.myContacts.clear();
                  this.primaryListCounter.clear();
                  this.secondaryListCounter.clear();
                });
                saveContactsFirebase(this.myContacts, this.myProfile);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  String getCandyList() {
    String myCopyString = '';
    List<String> candyList = new List<String>.from(pokemonNamesDict.keys.toList());
    this.primaryListCounter.keys.toList().forEach((key) => candyList.remove(key));

    for (int i = 0; i < candyList.length; i++) {
      if (!candyList[i].contains('alolan')) myCopyString = myCopyString + ',' + int.parse(candyList[i]).toString();
    }
    if (myCopyString != '') myCopyString = myCopyString.substring(1);

    return myCopyString;
  }

  Widget getAppBar() {
    if (this.navIndex == 0) {
      return AppBar(
        title: Text(languageFile['PAGE_CONTACTS']['TITLE_01']),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              MdiIcons.pokeball,
              color: iconColor,
            ),
            onPressed: () => setIconView(false, true),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: iconColor,
            ),
            onPressed: () => setIconView(true, false),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => deleteContacts(context),
          )
        ],
      );
    } else {
      return AppBar(
        title: this.appBarTitle,
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: this.searchIcon,
            color: iconColor,
            onPressed: () => searchPressed(),
          ),
          IconButton(
            icon: Icon(MdiIcons.candycane),
            onPressed: () {
              String copyToClipBoardString = getCandyList();
              copyToClipboard(this.scaffoldKey, copyToClipBoardString);
            },
          ),
        ],
      );
    }
  }

  void setIconView(bool isFavorite, bool isOfficialCollection) {
    setState(() {
      this.isFavorite = isFavorite;
      this.isOfficialCollection = isOfficialCollection;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contactPages = [
      contactsPageBody(),
      wantedPageBody(),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      key: this.scaffoldKey,
      floatingActionButton: Visibility(
        visible: this.navIndex == 0 ? true : false,
        child: FloatingActionButton(
          backgroundColor: buttonColor,
          child: Icon(
            Icons.add,
            color: buttonTextColor,
          ),
          onPressed: () => addContactDialog(context),
        ),
      ),
      appBar: getAppBar(),
      body: contactPages[this.navIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: backgroundColor,
          primaryColor: buttonColor,
          textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: subTextColor)),
        ),
        child: BottomNavigationBar(
          currentIndex: this.navIndex,
          fixedColor: buttonColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('Contacts'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.donut_small),
              title: Text('Wanted'),
            ),
          ],
          onTap: (index) {
            setState(() {
              this.navIndex = index;
            });
          },
        ),
      ),
    );
  }

  void addContactDialog(BuildContext scaffoldContext) async {
    await showDialog(
      context: scaffoldContext,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        contentPadding: const EdgeInsets.all(18.0),
        content: Row(
          children: <Widget>[
            Form(
              child: Expanded(
                child: Form(
                  key: this.formKey,
                  autovalidate: this.autoValidate,
                  child: TextFormField(
                    style: TextStyle(color: textColor),
                    validator: (id) => validateTradingCode(id.trim()),
                    onSaved: (id) => this.validId = id.trim(),
                    controller: this.textEditControllerIdInput,
                    autofocus: true,
                    cursorColor: buttonColor,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: textColor)),
                      labelText: languageFile['PAGE_CONTACTS']['DIALOG_ADD']['TITLE'],
                      labelStyle: TextStyle(color: textColor),
                      hintText: '-LVePy20jxxxxxxxxxxx',
                      hintStyle: TextStyle(color: prefillTextColor),
                    ),
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: buttonColor,
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: buttonTextColor,
                ),
                color: iconColor,
                onPressed: () {
                  validateInputs();
                  if (this.validId != null) {
                    addContact();
                    this.validId = null;
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String validateTradingCode(String id) {
    if (id.length != 20)
      return languageFile['PAGE_CONTACTS']['INVALID_CODE'];
    else if (id[0] != '-')
      return languageFile['PAGE_CONTACTS']['INVALID_CODE'];
    else if (codeInContactList(id))
      return languageFile['PAGE_CONTACTS']['INVALID_CODE_IN_LIST'];
    // else if (code == myID)
    //   return 'you cannot add yourself';
    else
      return null;
  }

  bool codeInContactList(String id) {
    for (int i = 0; i < this.myContacts.length; i++) {
      if (this.myContacts[i].id == id) return true;
    }
    return false;
  }

  void validateInputs() {
    if (this.formKey.currentState.validate()) {
      this.formKey.currentState.save();
    } else {
      setState(() {
        this.autoValidate = true;
      });
    }
  }

  void addContact() {
    Contact newContact = new Contact();
    OfficialCollection officialCollection = new OfficialCollection();
    newContact.id = this.validId;

    database.reference().child(newContact.id).once().then((DataSnapshot snapshot) {
      // account name
      if (snapshot.value['account_name'] != null)
        newContact.accountName = snapshot.value['account_name'];
      else
        newContact.accountName = languageFile['PAGE_CONTACTS']['INVALID_NAME'];

      // icon
      if (snapshot.value['icon'] != null)
        newContact.icon = snapshot.value['icon'];
      else
        newContact.icon = '001';

      // primary list
      if (snapshot.value['myMostWantedList'] != null && snapshot.value['myMostWantedList'] != '[]')
        newContact.primaryList = snapshot.value['myMostWantedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
      else
        newContact.primaryList = new List<String>();

      // secondary list
      if (snapshot.value['myNeedList'] != null && snapshot.value['myNeedList'] != '[]')
        newContact.secondaryList = snapshot.value['myNeedList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
      else
        newContact.secondaryList = new List<String>();

      if (snapshot.value['officialCollection'] != null) {
        if (snapshot.value['officialCollection']['luckyList'] != null)
          officialCollection.luckyList = snapshot.value['officialCollection']['luckyList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.luckyList = new List<String>();

        if (snapshot.value['officialCollection']['shinyList'] != null)
          officialCollection.shinyList = snapshot.value['officialCollection']['shinyList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.shinyList = new List<String>();

        if (snapshot.value['officialCollection']['genderList']['maleList'] != null)
          officialCollection.maleList =
              snapshot.value['officialCollection']['genderList']['maleList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.maleList = new List<String>();

        if (snapshot.value['officialCollection']['genderList']['femaleList'] != null)
          officialCollection.femaleList =
              snapshot.value['officialCollection']['genderList']['femaleList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.femaleList = new List<String>();

        if (snapshot.value['officialCollection']['genderList']['neutralList'] != null)
          officialCollection.neutralList =
              snapshot.value['officialCollection']['genderList']['neutralList'].toString().replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '').split(',');
        else
          officialCollection.neutralList = new List<String>();
      }

      newContact.officialCollection = officialCollection;

      setState(() {
        this.myContacts.add(newContact);
      });

      getTotalList();
      getWantedCounterList();

      saveContactsFirebase(this.myContacts, this.myProfile);
    });
  }

  void getWantedCounterList() {
    for (int i = 0; i < this.myContacts.length; i++) {
      for (int j = 0; j < this.myContacts[i].primaryList.length; j++) {
        this.primaryListCounter[this.myContacts[i].primaryList[j]] = 0;
      }
      for (int j = 0; j < this.myContacts[i].secondaryList.length; j++) {
        this.secondaryListCounter[this.myContacts[i].secondaryList[j]] = 0;
      }
    }

    for (int i = 0; i < this.myContacts.length; i++) {
      for (int j = 0; j < this.myContacts[i].primaryList.length; j++) {
        this.primaryListCounter[this.myContacts[i].primaryList[j]]++;
      }
      for (int j = 0; j < this.myContacts[i].secondaryList.length; j++) {
        this.secondaryListCounter[this.myContacts[i].secondaryList[j]]++;
      }
    }
  }

  List<Widget> getContactIcons(int i) {
    List<Widget> iconWidgets = List<Widget>();
    if (this.isOfficialCollection) {
      iconWidgets.add(
        IconButton(
          icon: Icon(
            MdiIcons.pokeball,
            color: buttonColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactOfficialCollectionSubpage(this.myContacts[i], this.pokemonNamesDict),
              ),
            );
          },
        ),
      );
      iconWidgets.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactOfficialCollectionSubpage(this.myContacts[i], this.pokemonNamesDict),
              ),
            );
          },
          child: Text(
            (this.pokemonNamesDictCopy.length - this.myContacts[i].officialCollection.luckyList.length).toString() +
                ' | ' +
                (this.pokemonNamesDictCopy.length - this.myContacts[i].officialCollection.shinyList.length).toString(),
            style: TextStyle(color: textColor),
            textScaleFactor: 1.2,
          ),
        ),
      );
    }
    if (this.isFavorite) {
      iconWidgets.add(
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: primaryListColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactPrimaryListSubpage(this.myContacts[i], this.pokemonNamesDict),
              ),
            );
          },
        ),
      );
      iconWidgets.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactPrimaryListSubpage(this.myContacts[i], this.pokemonNamesDict),
              ),
            );
          },
          child: Text(
            this.myContacts[i].primaryList.length.toString(),
            style: TextStyle(color: textColor),
            textScaleFactor: 1.2,
          ),
        ),
      );
    }
    return iconWidgets;
  }

  void goToPage(int i) {
    if (this.isFavorite) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactPrimaryListSubpage(this.myContacts[i], this.pokemonNamesDict),
        ),
      );
    } else if (this.isOfficialCollection) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactOfficialCollectionSubpage(this.myContacts[i], this.pokemonNamesDict),
        ),
      );
    }
  }

  Widget contactsPageBody() {
    this.myContacts.sort((a, b) => a.accountName.toString().toLowerCase().compareTo(b.accountName.toString().toLowerCase()));
    return Container(
      color: backgroundColor,
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
          child: Divider(
            color: dividerColor,
          ),
        ),
        itemCount: this.myContacts.length,
        itemBuilder: (context, i) {
          String idx = this.myContacts[i].icon;
          return Dismissible(
            key: Key(this.myContacts[i].id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: dismissibleColor,
              child: ListTile(
                title: Text(
                  languageFile['PAGE_CONTACTS']['DELETE_CONTACT'],
                  style: TextStyle(color: buttonTextColor),
                  textAlign: TextAlign.center,
                ),
                trailing: Icon(
                  Icons.delete,
                  color: buttonTextColor,
                ),
              ),
            ),
            child: Container(
              child: ListTile(
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: new BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: getPokemonAssetImage(idx),
                    ),
                  ),
                ),
                title: Text(
                  this.myContacts[i].accountName,
                  style: TextStyle(color: textColor),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: getContactIcons(i),
                ),
                onTap: () => goToPage(i),
              ),
            ),
            onDismissed: (direction) {
              String name = this.myContacts[i].accountName;
              deleteFromCounterList(i);
              this.myContacts.removeAt(i);

              saveContactsFirebase(this.myContacts, this.myProfile);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("$name" + languageFile['PAGE_CONTACTS']['DELETE_CONTACT_SNACKBAR']),
                duration: Duration(milliseconds: 2000),
              ));
            },
          );
        },
      ),
    );
  }

  void deleteFromCounterList(int i) {
    for (int j = 0; j < this.myContacts[i].primaryList.length; j++) {
      this.primaryListCounter[this.myContacts[i].primaryList[j]]--;
      if (this.primaryListCounter[this.myContacts[i].primaryList[j]] < 1) this.primaryListCounter.remove(this.myContacts[i].primaryList[j]);
    }
    for (int j = 0; j < this.myContacts[i].secondaryList.length; j++) {
      this.secondaryListCounter[this.myContacts[i].secondaryList[j]]--;
      if (this.secondaryListCounter[this.myContacts[i].secondaryList[j]] < 1) this.secondaryListCounter.remove(this.myContacts[i].secondaryList[j]);
    }
  }

  void sortList() {
    for (int i = 0; i < this.myContacts.length; i++) {
      this.myContacts[i].primaryList.sort((a, b) => a.trim().compareTo(b.trim()));
      this.myContacts[i].secondaryList.sort((a, b) => a.trim().compareTo(b.trim()));
    }

    this.totalList.sort((a, b) => a.trim().compareTo(b.trim()));
  }

  Widget wantedPageBody() {
    sortList();
    List<dynamic> tmpList = this.primaryListCounter.keys.toList()..sort();

    return Container(
      color: backgroundColor,
      child: ListView.builder(
        itemCount: searchResult.length != 0 || textEditController.text.isNotEmpty ? this.searchResult.length : this.primaryListCounter.length,
        itemBuilder: (context, i) {
          String idx;
          searchResult.length != 0 || textEditController.text.isNotEmpty ? idx = this.searchResult.elementAt(i) : idx = tmpList.elementAt(i);
          return ListTile(
            leading: getPokemonImage(idx),
            title: Text(
              "#" + idx.split('_')[0] + ' ' + this.pokemonNamesDict[idx],
              style: TextStyle(color: textColor),
            ),
            trailing: getTrailing(idx),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactWantedPrimaryListSubpage(this.myContacts, idx, this.pokemonNamesDict)),
              );
            },
          );
        },
      ),
    );
  }

  Widget getTrailing(String idx) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: primaryListColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactWantedPrimaryListSubpage(this.myContacts, idx, this.pokemonNamesDict)),
            );
          },
        ),
        Text(
          this.primaryListCounter[idx].toString(),
          style: TextStyle(color: textColor),
          textScaleFactor: 1.2,
        ),
      ],
    );
  }
}
