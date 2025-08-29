import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/asset_utils.dart';
import '../../utils/color_utils.dart';
import '../../utils/style_utils.dart';

class SearchAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBarWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
          margin :const EdgeInsets.only(left:10),
          child: InkWell(
              onTap: (){
                Navigator.pushReplacementNamed(context, RoutesName.bottomBar,arguments: 0);
              },
              child: const Icon(Icons.home,size:28,color:ColorUtils.primaryColor))),
      title: ProText("Search",style: StyleUtils.t400_16.copyWith(color: ColorUtils.primaryColor),),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.filter_alt,
            color: ColorUtils.primaryColor,
          ),
          onPressed: () {
            showModalBottomSheet(
                context:context,
                shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                       ),
                    ),
               clipBehavior: Clip.antiAliasWithSaveLayer, builder: (BuildContext context) {
                  return Container();
                  //return FilterScreenWidget();
            },
            );

          },
        )
      ],
      backgroundColor:  ColorUtils.backgroundColor,
      bottomOpacity: 0.0,
      elevation: 0.0,);
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);//
}
