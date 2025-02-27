import 'dart:ui';

import 'package:flutter/material.dart';

const API_KEY = 'AIzaSyDDap0MlM-rIXEPrHzrvOy5elrX7KWRHUc';

const REAL_URL = 'https://gestionesugas.minambiente.gov.co';
const TEST_URL = 'https://gestionesugas.minambiente.gov.co';

const ON_TEST = false;
const BASE_URL = ON_TEST ? TEST_URL : REAL_URL;

const BASE_API_URL = BASE_URL + '/api';
const BASE_IMG_URL = BASE_URL + '/img';

const BASE_IMG_NOTICIA_URL = BASE_IMG_URL + '/noticia/';
const BASE_IMG_PERSONA_URL = BASE_IMG_URL + '/persona/';

const COLOR_BLACK = Color(0xFF293333);
const COLOR_GREY = Color(0xFFBCBCBC);
const COLOR_YELLOW_LIGHT = Color(0xFFffde7f);
const COLOR_YELLOW = Color(0xFFefac50);
const COLOR_YELLOW_DARK = Color(0xFFb97d20);
const COLOR_GREEN = Color.fromRGBO(109, 187, 49, 1);

const COLORS_PROFILE = {
  "ADMIN": Colors.red,
  "CA": Colors.deepPurple,
  "CAD": Colors.purple,
  "CR": Colors.blue,
  "RIOR": Colors.deepOrange,
  "TEC": Colors.green,
  "EMP": Colors.teal,
  "USR": Colors.indigo,
  "IMP": Colors.brown,
};

Map<String, Color> colorPerfil = {
  "ADMIN": Color(0xFF4B8BBF),
  "USUARIO": Color(0xFF867469),
  "USUARIO.USR": Color(0xFF584A7C),
  "USUARIO.IMP": Color(0xFF7278E2),
  "TECNICO": Color(0xFF6F5158),
  "TECNICO.TEC": Color(0xFF28526A),
  "TECNICO.EMP": Color(0xFFE96D4C),
  "GESTOR": Color(0xFF28262B),
  "GESTOR.CA": Color(0xFFE3903D),
  "GESTOR.CAD": Color(0xFF4E4760),
  "GESTOR.CR": Color(0xFFE23B51),
  "GESTOR.RIOR": Color(0xFF2D3244),
};
