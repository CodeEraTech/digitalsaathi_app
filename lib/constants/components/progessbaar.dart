import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgessBaar extends StatelessWidget {
  const ProgessBaar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? ColorUtils.errorColor : ColorUtils.colorGreen,
          ),
        );
      },
    ),);
  }
}

