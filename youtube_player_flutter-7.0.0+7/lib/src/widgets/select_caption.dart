// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../enums/caption_type.dart';
import '../utils/youtube_player_controller.dart';

/// A widget to display playback speed changing button.
class SelectCaption extends StatefulWidget {
  /// Overrides the default [YoutubePlayerController].
  final YoutubePlayerController controller;

  /// Defines icon for the button.
  final Widget icon;

  /// Creates [SelectCaption] widget.
  const SelectCaption({
    this.controller,
    this.icon,
  });

  @override
  _SelectCaptionState createState() => _SelectCaptionState();
}

class _SelectCaptionState extends State<SelectCaption> {
  YoutubePlayerController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = YoutubePlayerController.of(context);
    if (_controller == null) {
      assert(
        widget.controller != null,
        '\n\nNo controller could be found in the provided context.\n\n'
        'Try passing the controller explicitly.',
      );
      _controller = widget.controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: _controller.setCaptionType,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
        child: widget.icon ??
            Image.asset(
              'assets/cc.webp',
              package: 'youtube_player_flutter',
              width: 20.0,
              height: 20.0,
              color: Colors.white,
            ),
      ),
      tooltip: 'Caption Type',
      itemBuilder: (context) => [
        _popUpItem('En', CaptionType.en),
        _popUpItem('Tr', CaptionType.tr),
        _popUpItem('Lt', CaptionType.lt),
        _popUpItem('Pt', CaptionType.pt),
        _popUpItem('Gr', CaptionType.gr),
      ],
    );
  }

  Widget _popUpItem(String text, String cc) {
    return CheckedPopupMenuItem(
      checked: _controller.value.captionType == cc,
      child: Text(text),
      value: cc,
    );
  }
}
