import 'package:flutter/material.dart';

void navigatorPush(ctx, page) {
  Navigator.push(ctx, MaterialPageRoute(builder: (context) => page));
}
