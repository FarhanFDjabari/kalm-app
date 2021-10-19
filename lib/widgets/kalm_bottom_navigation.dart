import 'package:flutter/material.dart';
import 'package:kalm/utilities/iconsax_icons.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class KalmBottomNavigation extends StatefulWidget {
  final int itemCount;
  final Color color;

  KalmBottomNavigation({required this.itemCount, this.color = accentColor});

  @override
  _KalmBottomNavigationState createState() => _KalmBottomNavigationState();
}

class _KalmBottomNavigationState extends State<KalmBottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _buildNavigationItem(
              icon: Iconsax.home5, itemCount: 5, index: 0, color: widget.color),
          _buildNavigationItem(
              icon: Iconsax.graph5,
              itemCount: 5,
              index: 1,
              color: widget.color),
          _buildNavigationItem(
              icon: Iconsax.message5,
              itemCount: 5,
              index: 2,
              color: widget.color),
          _buildNavigationItem(
              icon: Iconsax.music5,
              itemCount: 5,
              index: 3,
              color: widget.color),
          _buildNavigationItem(
              icon: Iconsax.flag5, itemCount: 5, index: 4, color: widget.color),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required int itemCount,
    required int index,
    Color color = accentColor,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / itemCount,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Icon(
                  icon,
                  color: index == _selectedIndex ? primaryColor : secondaryText,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: 28,
              height: index == _selectedIndex ? 6 : 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
