import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/Utils/characters_colors.dart';

class CharactersTextStyles {
  static TextStyle _baseFont =  TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      fontStyle: FontStyle.normal,
      fontSize: 16,
      height: 1.3);

  static TextStyle baseFontOriginalHeight() =>  const TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontSize: 16,
  );


  static TextStyle robotoBold()=>
      _baseFont.copyWith(
          fontWeight: FontWeight.bold,
          color: CharactersColors.darkBlue);

  static TextStyle robotoLight()=>
      _baseFont.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 18,
          color: CharactersColors.darkBlue);


  static TextStyle robotoRegular()=>
      _baseFont.copyWith(
          fontWeight: FontWeight.w400,
          color: CharactersColors.darkBlue);

  static TextStyle buttonTextStyle = _baseFont.copyWith(color: CharactersColors.darkBlue);

  static TextStyle errorLabelStyle = _baseFont.copyWith(color: CharactersColors.darkGray, fontSize: 16);

}