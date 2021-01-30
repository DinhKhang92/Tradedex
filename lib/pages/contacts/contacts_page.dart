import 'package:flutter/material.dart';
import 'package:tradedex/Contacts/Subpages/ContactOfficialCollectionSubpage.dart';
import 'package:tradedex/Contacts/Subpages/ContactPrimaryListSubpage.dart';
import 'package:tradedex/Contacts/Subpages/ContactWantedPrimaryListSubpage.dart';
import 'package:tradedex/Global/Components/copyToClipboard.dart';
import 'package:tradedex/Global/Components/loadDataFirebase.dart';
import 'package:tradedex/Global/Components/saveDataFirebase.dart';
import 'package:tradedex/Global/GlobalConstants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/model/device.dart';
import 'package:tradedex/pages/contacts/cubit/contacts_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tradedex/components/pokemon_image.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage();

  @override
  State<StatefulWidget> createState() {
    return ContactsPageState();
  }
}

class ContactsPageState extends State<ContactsPage> with Device {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> contactPages = [
      _contactsPageBody(),
      // wantedPageBody(),
    ];

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff242423),
      key: this._scaffoldKey,
      body: SafeArea(child: contactPages[0]),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xff242423),
          primaryColor: Color(0xffee6c4d),
          textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white)),
        ),
        child: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.navIdx,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Contacts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.donut_small),
                  label: 'Wanted',
                ),
              ],
              onTap: (index) => BlocProvider.of<ContactsCubit>(context).setNavIdx(index),
            );
          },
        ),
      ),
    );
  }

  Widget _contactsPageBody() {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: Device.height - Device.safeAreaTop - 177 - Device.safeAreaBottom,
          child: BlocBuilder<ContactsCubit, ContactsState>(builder: (contex, state) {
            if (state is ContactsLoaded)
              return this._buildLoaded();
            else
              return Container();
          }),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 12),
      child: Column(
        children: [
          _buildNavbar(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                _buildTradingCodeInput(),
                SizedBox(width: 14),
                _buildAddButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        Text(
          AppLocalizations.of(context).translate('PAGE_OFFICIAL_COLLECTION.LUCKYDEX.TITLE'),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }

  Widget _buildTradingCodeInput() {
    return Container(
      height: 30,
      width: Device.width / 1.4,
      child: TextField(
        maxLength: 20,
        controller: this._textController,
        cursorColor: Color(0xff242423),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(32.0),
          ),
          hintText: "-LpARDUIetmYbFdUTEsY",
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: () => this._addContact(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.5,
            color: Colors.white.withOpacity(0.20),
          ),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLoaded() {
    return BlocBuilder<ContactsCubit, ContactsState>(builder: (contex, state) {
      return ListView.builder(
        itemCount: state.contacts.keys.length,
        itemBuilder: (context, i) {
          String contactKey = state.contacts.keys.toList()[i];
          String name = state.contacts[contactKey]['name'];
          String icon = state.contacts[contactKey]['icon'];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.20),
              ),
            ),
            child: ListTile(
              leading: getPokemonImage(icon),
              title: Text(
                name,
                style: TextStyle(color: Colors.white),
              ),
              onLongPress: () => BlocProvider.of<ContactsCubit>(context).deleteContact(contactKey),
            ),
          );
        },
      );
    });
  }

  void _addContact() {
    BlocProvider.of<ContactsCubit>(context).addContact(this._textController.text);
    // this._textController.clear();
  }
}
