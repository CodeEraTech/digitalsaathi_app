// import 'package:digitalsaathi/utils/app_utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// class ContentUi extends StatelessWidget {
//   final String creativeImage;
//   final VoidCallback navigateTo ;
//   const ContentUi({
//     super.key,
//     required this.creativeImage, required this.navigateTo,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {navigateTo();},
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Card(
//             elevation: 2,
//             shadowColor: Color(0xffffffff),
//             margin: const EdgeInsets.only(top: 33),
//             child: Container(
//               width: screenWidth(context) * 0.8,
//               height: 175,
//               decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.2),
//                   borderRadius: BorderRadius.all(Radius.circular(11)),
//                   // image: DecorationImage(image: AssetImage(creativeImage), fit: BoxFit.fill)
//               ),
//             ),
//           ),
//           Card(
//             // elevation: 3,
//             margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
//             child: Container(
//               width: screenWidth(context) * 0.88,
//               height: 175,
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.3),
//                   borderRadius: const BorderRadius.all(Radius.circular(11)),
//               ),
//             ),
//           ),
//           Card(
//             elevation: 4,
//             margin: EdgeInsets.zero,
//             child: Container(
//               height: 170,
//               padding: const EdgeInsets.only(
//                 top: 10,
//                 right: 10,
//               ),
//               width: screenWidth(context),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(11)),
//                   image: DecorationImage(
//                       image: AssetImage(creativeImage), fit: BoxFit.fill
//                   )
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ContentUi extends StatelessWidget {
  final String creativeImage;
  final VoidCallback navigateTo ;
  const ContentUi({
    super.key,
    required this.creativeImage, required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {navigateTo();},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Card(
            margin: const EdgeInsets.only(top: 33),
            elevation: 1,
            child: Container(
              width: screenWidth(context) * 0.8,
              height: 175,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(11)),
                image: DecorationImage(image: AssetImage(AssetUtils.bgCardFive), fit: BoxFit.fill)
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
            elevation: 1,
            child: Container(
              width: screenWidth(context) * 0.88,
              height: 175,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
                borderRadius: const BorderRadius.all(Radius.circular(11)),
                  image: DecorationImage(image: AssetImage(AssetUtils.bgCardFour), fit: BoxFit.fill)
              ),
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.zero,
            child: Container(
              height: 170,
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
              ),
              width: screenWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                  image: DecorationImage(
                      image: AssetImage(creativeImage), fit: BoxFit.fill
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
