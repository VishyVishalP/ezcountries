import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repo/provider/countries_provider.dart';

class CountryListView extends StatefulWidget {
  const CountryListView({Key? key}) : super(key: key);

  @override
  State<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  late CountryProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CountryProvider>(context);
    return ListView.separated(
      itemCount: provider.countries!.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemBuilder: (context, index) {
        final countryName = provider.countries![index].name!;
        return ListTile(
          leading: Icon(CupertinoIcons.globe),
          title: Text(countryName),
        );
      },
    );
  }
}
