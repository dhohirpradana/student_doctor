import 'package:flutter/material.dart';

Widget slider(ctx, currValxLabel, onChange) => SliderTheme(
      data: SliderTheme.of(ctx).copyWith(
        activeTrackColor: Colors.green,
        inactiveTrackColor: Colors.black,
        trackHeight: 3.0,
        thumbColor: Colors.orange,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
        overlayColor: Colors.purple.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
      ),
      child: Slider(
        value: currValxLabel,
        min: 0,
        max: 100,
        divisions: 5,
        label: currValxLabel.round().toString(),
        onChanged: onChange,
      ),
    );
