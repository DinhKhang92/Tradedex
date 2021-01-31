import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradedex/model/device.dart';
import 'package:tradedex/pages/contacts/cubit/contacts_cubit.dart';
import 'package:tradedex/localization/app_localization.dart';
import 'package:tradedex/pages/contacts/pages/contact_overview/cubit/contact_overview_cubit.dart';
import 'package:tradedex/pages/contacts/pages/contact_overview/components/overview_griditem.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ContactOverviewPage extends StatefulWidget {
  final String contactKey;
  ContactOverviewPage({@required this.contactKey});
  @override
  _ContactOverviewPageState createState() => _ContactOverviewPageState(contactKey: this.contactKey);
}

class _ContactOverviewPageState extends State<ContactOverviewPage> with Device {
  final String contactKey;
  _ContactOverviewPageState({@required this.contactKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242423),
      resizeToAvoidBottomPadding: false,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: BlocBuilder<ContactsCubit, ContactsState>(
              builder: (context, contactsState) {
                Map pokemonMap = contactsState.contacts[this.contactKey]['pokemon'];
                BlocProvider.of<ContactOverviewCubit>(context).loadOverview(pokemonMap);
                return Container(
                  height: Device.height - Device.safeAreaTop - 77 - Device.safeAreaBottom,
                  child: BlocBuilder<ContactOverviewCubit, ContactOverviewState>(
                    builder: (context, state) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        children: [
                          OverviewGridItem(
                            collectionLength: state.primaryMap.length.toString(),
                            title: AppLocalizations.of(context).translate('PAGE_PRIMARY_LIST.TITLE'),
                            icon: Icons.favorite,
                            iconColor: Color(0xffee6c4d),
                          ),
                          OverviewGridItem(
                            collectionLength: state.secondaryMap.length.toString(),
                            title: AppLocalizations.of(context).translate('PAGE_SECONDARY_LIST.TITLE'),
                            icon: MdiIcons.hexagon,
                            iconColor: Color(0xffffcd05),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 5, right: 5, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          Text(
            this.contactKey,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Container(
            width: 48,
            height: 48,
            padding: EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}
