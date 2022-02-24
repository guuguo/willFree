import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free/bean/stock_bean.dart';
import 'package:free/page/home/model.dart';
import 'package:free/page/view/card.dart';
import 'package:provider/provider.dart';

class Stock extends StatelessWidget {
  const Stock({
    required this.stock,
    Key? key,
  }) : super(key: key);
  final StockBean stock;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
        builder: (ctx, v, c) => MainCard(
              child: Column(
                children: [
                  Text(
                    "${stock.name} (${stock.code})",
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    stock.priceDetail?.currentPrice.toString()??"",
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    stock.priceDetail?.pricePlus??"",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "TTM市盈率:${stock.priceDetail?.ttm??""}",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ));
  }
}
