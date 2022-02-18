
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free/page/home/model.dart';
import 'package:free/page/view/card.dart';
import 'package:provider/provider.dart';

class PE extends StatelessWidget {
  const PE({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
        builder: (ctx, v, c) => MainCard(
              child: Column(
                children: [
                  Text(
                    "深证今日平均市盈率",
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "如果在20以下就是好价格",
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    v.todayPE?.pe?.toString()??"",
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    getPriceDesc(v.todayPE?.pe),
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ));
  }
  String getPriceDesc(double? pe){
    if(pe==null) return "";
    if(pe-20>20){
      return "价格很高";
    }
    if(pe-20>10){
      return "价格偏高";
    }
    if(pe-20>5){
      return "价格还行";
    }
    if(pe<=20){
      return "好价格，买它";
    }
    return "";
  }
}
