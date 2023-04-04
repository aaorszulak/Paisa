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

class ChooseFontPreferenceWidgetState
    extends State<ChooseFontPreferenceWidget> {
  late String _currentIndex = widget.currentFont;
  final _fonts = GoogleFonts.asMap().keys.toList();

  _onChanged(String? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _currentIndex = value;
    });
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    final font = _fonts[index];
    return RadioListTile<String>(
      value: font,
      activeColor: Theme.of(context).colorScheme.primary,
      groupValue: _currentIndex,
      onChanged: _onChanged,
      title: Text(
        font,
        style: GoogleFonts.getFont(font),
      ),
    );
  }

  _save() async {
    await getIt
        .get<Box<dynamic>>(instanceName: BoxType.settings.name)
        .put(fontPreferenceKey, _currentIndex);
    if (!mounted) {
      return;
    }
    Navigator.pop(context);
  }

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
            child: ListView.builder(
              itemBuilder: _itemBuilder,
              itemCount: _fonts.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.loc.cancelLabel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: _save,
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
