import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer {
  static Widget boxGlassContainer(
      {color = Colors.blue, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          // blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            // child: Container(),
          ),
          // gradient effect
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(.15),
                      color.shade200.withOpacity(.05),
                    ]),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: color.withOpacity(.13))),
          ),
          // child
          Padding(
            padding: const EdgeInsets.all(5),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }

  static Widget circularGlassContainer(
      {color = Colors.blue, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          // blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            // child: Container(),
          ),
          // gradient effect
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(.15),
                      color.shade200.withOpacity(.05),
                    ]),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: color.withOpacity(.13))),
          ),
          // child
          Padding(
            padding: const EdgeInsets.all(5),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
