import 'package:flutter/material.dart';

void _f() {}

class FotogoMenuItem {
  final String name;
  final VoidCallback onTap;
  final bool enabled;

  FotogoMenuItem(this.name, {this.onTap = _f, this.enabled = true});
}

class FotogoIconMenuItem extends FotogoMenuItem {
  final IconData icon;

  FotogoIconMenuItem(name, this.icon, {onTap = _f, enabled = true})
      : super(name, onTap: onTap, enabled: enabled);
}

// TODO: make factory for both constructors + . constructor (popupMenu.icon())
Widget fotogoPopupMenuIconButton({
  required List<FotogoIconMenuItem> items,
  IconData icon = Icons.more_vert,
  Color? iconColor,
  Color? foregroundColor,
  String tooltip = "More options",
  bool enabled = true,
}) {
  return PopupMenuButton<String>(
    enabled: enabled,
    icon: Icon(icon, color: iconColor),
    tooltip: tooltip,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    offset: const Offset(0, 50),
    itemBuilder: (context) {
      return items
          .map((e) => PopupMenuItem<String>(
                enabled: e.enabled,
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
  required List<FotogoMenuItem> items,
  IconData icon = Icons.more_vert,
  Color? iconColor,
  Color? foregroundColor,
  void Function(String)? onSelected,
  String tooltip = "More options",
  bool enabled = true,
}) {
  return PopupMenuButton<String>(
    enabled: enabled,
    icon: Icon(icon, color: iconColor),
    tooltip: tooltip,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    offset: const Offset(0, 50),
    onSelected: onSelected,
    itemBuilder: (context) {
      return items
          .map((e) => PopupMenuItem<String>(
                enabled: e.enabled,
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
