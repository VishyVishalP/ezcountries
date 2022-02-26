import 'package:ezcountries/repo/provider/countries_provider.dart';
import 'package:ezcountries/views/drawer.dart';
import 'package:ezcountries/views/filter_list.dart';
import 'package:ezcountries/views/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search_countries.dart';

class CountryNames extends StatefulWidget {
  CountryNames({Key? key}) : super(key: key);

  @override
  _CountryNamesState createState() => _CountryNamesState();
}

class _CountryNamesState extends State<CountryNames> {
  late CountryProvider provider;

  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await provider.getCountryName();
      await provider.getLanguages();
    });
  }

  @override
  void dispose() {
    provider.countries!.clear();
    provider.languages.clear();
    provider.filterCountries.clear();

    super.dispose();
  }

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CountryProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Route route = MaterialPageRoute(builder: (_) => SearchCountry());
          Navigator.push(context, route);
        },
      ),
      appBar: AppBar(
        title: Text("eZCountries"),
        actions: [
          provider.filterCountries.isEmpty
              ? TextButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: Text(
                    "Filter",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : TextButton(
                  onPressed: () {
                    provider.filterCountries.clear();
                    provider.notifylistener();
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: provider.countries!.isEmpty
                ? Center(child: CupertinoActivityIndicator())
                : provider.filterCountries.isEmpty
                    ? CountryListView()
                    : FilterList(),
          ),
        ],
      ),
    );
  }
}
