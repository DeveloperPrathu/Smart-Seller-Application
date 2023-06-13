import 'dart:ui';

import 'package:flutter/material.dart';

// const DOMAIN_URL = "http://10.0.2.2:8000";
const DOMAIN_URL = "http://192.168.29.121:8000";
const HOST_URL = "http://192.168.29.121:8000";
const BASE_URL = "$HOST_URL/api";
const UNAUTHENTICATED_USER = 'unauthenticated_user';

const ADD ='ADD';
const REMOVE = 'REMOVE';
const SUCCESS = 'SUCCESS';
const FAILED = 'FAILED';

const PAGE_LIMIT = 1;

const EMAIL_REGEX = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

//THEME COLOR

const Map<int, Color> color = {
  50: Color.fromRGBO(144, 29, 120, .1),
  100: Color.fromRGBO(144, 29, 120, .2),
  200: Color.fromRGBO(144, 29, 120, .3),
  300: Color.fromRGBO(144, 29, 120, .4),
  400: Color.fromRGBO(144, 29, 120, .5),
  500: Color.fromRGBO(144, 29, 120, .6),
  600: Color.fromRGBO(144, 29, 120, .7),
  700: Color.fromRGBO(144, 29, 120, .8),
  800: Color.fromRGBO(144, 29, 120, .9),
  900: Color.fromRGBO(144, 29, 120, .1),
};

const PRIMARY_SWATCH = MaterialColor(0xff901d78, color);
const SECONDARY_HEADER_COLOR = PRIMARY_SWATCH;

const INPUT_BORDER_COLOR = Color(0xffD9D9D9);

final OutlineInputBorder ENABLED_BORDER = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: INPUT_BORDER_COLOR));
final OutlineInputBorder FOCUSED_BORDER = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: PRIMARY_SWATCH, width: 2));
final OutlineInputBorder ERROR_BORDER = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.red, width: 2));
