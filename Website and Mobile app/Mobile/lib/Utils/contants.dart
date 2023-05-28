import 'package:drawerbehavior/drawerbehavior.dart' as drawer;
import 'package:flutter/material.dart';

List<drawer.MenuItem<int>> items = [
  drawer.MenuItem<int>(
    id: 0,
    title: 'THE PADDOCK',
    prefix: const Icon(Icons.fastfood),
  ),
  drawer.MenuItem<int>(
    id: 1,
    title: 'THE HERO',
    prefix: const Icon(Icons.person),
  ),
  drawer.MenuItem<int>(
    id: 2,
    title: 'HELP US GROW',
    prefix: const Icon(Icons.terrain),
  ),
  drawer.MenuItem<int>(
    id: 3,
    title: 'SETTINGS',
    prefix: const Icon(Icons.settings),
  ),
];
final menu = drawer.Menu(
  items: items.map((e) => e.copyWith(prefix: null)).toList(),
);

final menuWithIcon = drawer.Menu(
  items: items,
);
