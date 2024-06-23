import 'package:flutter/material.dart';

class PageManager {
  PageManager(this._controller);

  final PageController _controller;
  int page = 0;

  void setPage(int value) {
    if (page == value) return;
    
    page = value;
    _controller.jumpToPage(value);
  }
}
