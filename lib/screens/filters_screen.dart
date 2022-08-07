import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree;
  bool _vegetarian;
  bool _vegan;
  bool _lactoseFree;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => widget.saveFilters({
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            }),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meals!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            alignment: Alignment.center,
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                    title: const Text('Gluten Free'),
                    subtitle: const Text('Only see meals that are Gluten free'),
                    value: _glutenFree,
                    onChanged: (value) {
                      _glutenFree = value;
                      setState(() {});
                    }),
                SwitchListTile(
                    title: const Text('Vegetarian'),
                    subtitle: const Text('Only see meals that are Vegetarian'),
                    value: _vegetarian,
                    onChanged: (value) {
                      _vegetarian = value;
                      setState(() {});
                    }),
                SwitchListTile(
                    title: const Text('Vegan'),
                    subtitle: const Text('Only see meals that are Vegan'),
                    value: _vegan,
                    onChanged: (value) {
                      _vegan = value;
                      setState(() {});
                    }),
                SwitchListTile(
                    title: const Text('Lactose Free'),
                    subtitle:
                        const Text('Only see meals that are Lactose free'),
                    value: _lactoseFree,
                    onChanged: (value) {
                      _lactoseFree = value;
                      setState(() {});
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
