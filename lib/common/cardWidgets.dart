import 'package:base/constants.dart';
import 'package:flutter/material.dart';

class ExampleCard extends StatelessWidget {
  final String tittle;
  final String subTitle;
  final String textBody;
  final String textTrailing;

  final VoidCallback openContainer;

  const ExampleCard(
      {this.openContainer,
      @optionalTypeArgs this.tittle,
      @optionalTypeArgs this.subTitle,
      @optionalTypeArgs this.textBody,
      this.textTrailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: _InkWellOverlay(
        openContainer: openContainer,
        height: MediaQuery.of(context).size.height * .16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(
                tittle,
                style: kTitkeLabelListViewTextStyle,
              ),
              subtitle: Text(
                subTitle,
                style: kSubtitleTextStyle,
              ),
              dense: true,
              trailing: (textTrailing == '')
                  ? Icon(Icons.arrow_right)
                  : IconButton(
                      icon: Icon(
                        Icons.error_outline,
                        size: 16.0,
                      ),
                      color: Colors.deepOrange,
                      onPressed: () {},
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.width,
    this.height,
    this.child,
  });

  final VoidCallback openContainer;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}
