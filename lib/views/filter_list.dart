import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repo/provider/countries_provider.dart';

class FilterList extends StatefulWidget {
  const FilterList({Key? key}) : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  late CountryProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CountryProvider>(context);
    return ListView.separated(
        itemCount: provider.filterCountries.length,
        separatorBuilder: (context, index) => Divider(color: Colors.black),
        itemBuilder: (context, index) {
          final countryName = provider.filterCountries[index].name!;
          final countryLanguage = provider.filterCountries[index].languages!;
          return ListTile(
            leading: Icon(CupertinoIcons.globe),
            title: Text(countryName),
            trailing: countryLanguage.isNotEmpty
                ? Text(countryLanguage[0].name!)
                : Text(""),
          );
        });
  }
}
