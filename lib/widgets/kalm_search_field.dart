import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class KalmSearchField extends StatelessWidget {
  const KalmSearchField({
    Key? key,
    this.searchController,
    this.suffixOnPressed,
    this.onTap,
    this.isAutofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
  }) : super(key: key);

  final TextEditingController? searchController;
  final bool isAutofocus;
  final bool readOnly;
  final Function()? suffixOnPressed;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      maxLines: 1,
      cursorColor: primaryColor,
      keyboardType: TextInputType.url,
      onSubmitted: onSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      autofocus: isAutofocus,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: 'Cari musik meditasi',
        contentPadding: const EdgeInsets.all(20),
        hintStyle:
            kalmOfflineTheme.textTheme.subtitle1!.apply(color: secondaryText),
        hintMaxLines: 1,
        focusColor: accentColor,
        filled: true,
        fillColor: tertiaryColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: tertiaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: accentColor),
        ),
        suffixIcon: IconButton(
          onPressed: suffixOnPressed,
          icon: Icon(
            Iconsax.search_normal,
            color: primaryText,
          ),
        ),
      ),
    );
  }
}
