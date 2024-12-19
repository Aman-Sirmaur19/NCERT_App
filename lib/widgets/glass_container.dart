import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer {
  static Widget stylishGlassContainer({
    double topLeft = 20,
    double topRight = 20,
    double bottomLeft = 20,
    double bottomRight = 20,
    dynamic color = Colors.blue,
    required List<Widget> children,
  }) {
    return Stack(
      children: [
        // blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          // child: Container(),
        ),
        // gradient effect
        Container(
          height: 200,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(.15),
                    color.shade200.withOpacity(.1),
                  ]),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeft),
                topRight: Radius.circular(topRight),
                bottomLeft: Radius.circular(bottomLeft),
                bottomRight: Radius.circular(bottomRight),
              ),
              border: Border.all(color: color.withOpacity(.13))),
        ),
        // child
        Padding(
          padding: const EdgeInsets.all(15),
          child: Center(child: Column(children: children)),
        ),
      ],
    );
  }

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
      {required dynamic color, required Widget child}) {
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
                    color.shade200,
                    color.shade100,
                  ],
                ),
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
