import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repo/provider/countries_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late CountryProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CountryProvider>(context);
    return Drawer(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding:
                const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 60),
                const Text(
                  "Filter By Language",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: provider.languages.length,
                      itemBuilder: (context, index) {
                        final name = provider.languages[index].name!;
                        return ListTile(
                          onTap: () async {
                            await provider.filter(name, provider);
                            provider.notifylistener();
                            Navigator.of(context).pop();
                          },
                          title: Text(name),
                        );
                      }),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
