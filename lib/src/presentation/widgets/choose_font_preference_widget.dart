import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../main.dart';
import '../../core/common.dart';
import '../../core/enum/box_types.dart';

class ChooseFontPreferenceWidget extends StatefulWidget {
  const ChooseFontPreferenceWidget({
    Key? key,
    required this.currentFont,
  }) : super(key: key);
  final String currentFont;

  @override
  ChooseFontPreferenceWidgetState createState() =>
      ChooseFontPreferenceWidgetState();
}

const allowedFonts = [
  'Fira Sans',
  'Lato',
  'Noto Sans',
  'Outfit',
  'Roboto',
];

class ChooseFontPreferenceWidgetState
    extends State<ChooseFontPreferenceWidget> {
  late String currentIndex = widget.currentFont;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              context.loc.chooseFontLabel,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
                children: allowedFonts
                    .map(
                      (font) => RadioListTile<String>(
                        value: font,
                        activeColor: Theme.of(context).colorScheme.primary,
                        groupValue: currentIndex,
                        onChanged: (String? value) {
                          currentIndex = value!;
                          setState(() {});
                        },
                        title: Text(
                          font,
                          style: GoogleFonts.getFont(font),
                        ),
                      ),
                    )
                    .toList()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.loc.cancelLabel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => getIt
                      .get<Box<dynamic>>(instanceName: BoxType.settings.name)
                      .put(fontPreferenceKey, currentIndex)
                      .then((value) => Navigator.pop(context)),
                  child: Text(context.loc.okLabel),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
