import 'package:flutter/material.dart';

void _f() {}

class MenuItem {
  MenuItem(this.name, {this.onTap = _f});

  final String name;
  final VoidCallback onTap;
}

class IconMenuItem extends MenuItem {
  IconMenuItem(name, this.icon, {onTap = _f}) : super(name, onTap: onTap);

  final IconData icon;
}

Widget fotogoPopupMenuIconButton({
  required List<IconMenuItem> items,
  IconData icon = Icons.more_vert,
  Color? iconColor,
  Color? foregroundColor,
  String tooltip = "More options",
}) {
  return PopupMenuButton<String>(
    icon: Icon(icon, color: iconColor),
    tooltip: tooltip,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    itemBuilder: (context) {
      return items
          .map((e) => PopupMenuItem<String>(
                value: e.name,
                onTap: e.onTap,
                child: Row(
                  children: [
                    Icon(
                      e.icon,
                      color: foregroundColor ??
                          Theme.of(context).colorScheme.primary,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      e.name,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: foregroundColor,
                          ),
                    )
                  ],
                ),
              ))
          .toList();
    },
  );
}

Widget fotogoPopupMenuButton({
  required List<MenuItem> items,
  List<VoidCallback>? funcs,
  IconData icon = Icons.more_vert,
  Color? iconColor,
  Color? foregroundColor,
  String tooltip = "More options",
}) {
  return PopupMenuButton<String>(
    icon: Icon(icon, color: iconColor),
    tooltip: tooltip,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    itemBuilder: (context) {
      return items
          .map((e) => PopupMenuItem<String>(
                value: e.name,
                onTap: e.onTap,
                child: Text(
                  e.name,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: foregroundColor,
                      ),
                ),
              ))
          .toList();
    },
  );
}



