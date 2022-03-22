import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free/page/home/model.dart';
import 'package:free/page/view/card.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../test/test.dart';

class NationnalDebt extends StatelessWidget {
  const NationnalDebt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
        builder: (ctx, v, c) => MainCard(
              child: Column(
                children: [
                  Text(
                    "十年期国债收益率",
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "股息率高于该收益率的股票才值得购买",
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    v.nationNalDebtRatio.toStringAsFixed(3) + "%",
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ));
  }
}
