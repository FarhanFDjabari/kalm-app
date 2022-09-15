import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:marquee/marquee.dart';

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
        child: Icon(
          widget.icon,
          color: widget.iconColor,
        ),
        backgroundColor: widget.iconBackgroundColor,
      ),
      title: Text(
        widget.title,
        overflow: TextOverflow.ellipsis,
        style: kalmOfflineTheme.textTheme.subtitle1!.apply(color: primaryText),
      ),
      subtitle: widget.subtitle.length > 35
          ? SizedBox(
              height: 12,
              child: Marquee(
                text: widget.subtitle,
                blankSpace: 50.0,
                numberOfRounds: 3,
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                pauseAfterRound: Duration(seconds: 4),
                style: kalmOfflineTheme.textTheme.subtitle1!
                    .apply(color: secondaryText),
              ),
            )
          : Text(
              widget.subtitle,
              overflow: TextOverflow.ellipsis,
              style: kalmOfflineTheme.textTheme.subtitle1!
                  .apply(color: secondaryText),
            ),
      trailing: widget.trailing,
    );
  }
}
