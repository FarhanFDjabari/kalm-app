import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kalm/styles/kalm_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

/// Bottom sheet with drag indicator bar.
Future<T?> showBarBottomSheet<T>(BuildContext context,
    {required Widget Function(BuildContext) builder,
    bool expand = false,
    bool enableDrag = true}) {
  return showBarModalBottomSheet(
    context: context,
    barrierColor: Colors.black.withOpacity(0.35),
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: builder,
    expand: expand,
    isDismissible: true,
    enableDrag: enableDrag,
    topControl: ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Container(
        width: 52,
        height: 5,
        color: Colors.white,
      ),
    ),
  );
}

/// Bottom sheet without drag indicator.
Future<T?> showCustomBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  bool expand = false,
  bool wrap = false,
  bool dragable = false,
  double heightFactor = 0.0,
}) {
  return showMaterialModalBottomSheet(
    context: context,
    barrierColor: Colors.black.withOpacity(0.35),
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (context) {
      return wrap == true
          ? Wrap(
              children: [child],
            )
          : FractionallySizedBox(
              heightFactor: heightFactor == 0.0 ? 0.8 : heightFactor,
              child: child,
            );
    },
    expand: expand,
    isDismissible: true,
    enableDrag: dragable,
  );
}

/// Bar bottom sheet list.
Future<T?> showBarBottomList<T>(BuildContext context,
    {required List<Widget> Function(BuildContext) builder}) {
  return showBarBottomSheet<T>(
    context,
    builder: (context) => Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: builder(context),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<T?> showBarBottomListAhead<T>(BuildContext context,
    {required Widget Function(BuildContext, T, bool last, int index)
        itemBuilder,
    required Future<List<T>?> Function() sourceCallback,
    Widget? child}) {
  return showBarBottomSheet<T>(
    context,
    builder: (context) => Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: FutureBuilder<List<T>?>(
                future: sourceCallback(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError)
                      return Align(
                        heightFactor: 1,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Opacity(
                            opacity: 0.6,
                            child: Text(snapshot.error.toString()),
                          ),
                        ),
                      );

                    final items = snapshot.data ?? [];
                    if (items.isEmpty)
                      return Align(
                        heightFactor: 1,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Opacity(
                            opacity: 0.6,
                            child: child ?? Text('Tidak ada data'),
                          ),
                        ),
                      );

                    final lastItem = items.last;
                    return Container(
                      margin: EdgeInsets.only(bottom: 20, top: 16),
                      padding: EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) => itemBuilder(context,
                            items[index], items[index] == lastItem, index),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Bar bottom sheet list. without drag indicator.
Future<T?> showBarBottomListNoIndicator<T>(BuildContext context,
    {required List<Widget> Function(BuildContext) builder}) {
  return showBarModalBottomSheet<T>(
    context: context,
    isDismissible: true,
    barrierColor: Colors.black.withOpacity(0.35),
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    topControl: Container(),
    builder: (context) => Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: builder(context),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
