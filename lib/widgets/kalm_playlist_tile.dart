import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class KalmPlaylistTile extends StatefulWidget {
  final Color iconColor;
  final Color iconBackgroundColor;
  final Color tileColor;
  final String title;
  final String subtitle;
  final IconData icon;
  final Function()? onTap;
  final Widget? trailing;

  KalmPlaylistTile(
      {required this.iconColor,
      required this.iconBackgroundColor,
      required this.title,
      required this.subtitle,
      required this.icon,
      this.onTap,
      this.trailing,
      this.tileColor = tertiaryColor});

  @override
  _KalmPlaylistTileState createState() => _KalmPlaylistTileState();
}

class _KalmPlaylistTileState extends State<KalmPlaylistTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: widget.onTap,
      tileColor: widget.tileColor,
      contentPadding: const EdgeInsets.only(left: 8),
      leading: CircleAvatar(
        radius: 25,
        child: IconButton(
          onPressed: () {},
          color: widget.iconColor,
          icon: Icon(widget.icon),
        ),
        backgroundColor: widget.iconBackgroundColor,
      ),
      title: Text(
        widget.title,
        style: kalmOfflineTheme.textTheme.subtitle1!.apply(color: primaryText),
      ),
      subtitle: Text(
        widget.subtitle,
        style:
            kalmOfflineTheme.textTheme.subtitle1!.apply(color: secondaryText),
      ),
      trailing: widget.trailing,
    );
  }
}
