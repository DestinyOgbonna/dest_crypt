import 'package:animate_do/animate_do.dart';
import 'package:dest_crypt/src/features/dashboard/data/dashboard_provider.dart';
import 'package:dest_crypt/src/features/marketplace/buy_coin.dart';
import 'package:dest_crypt/src/utils/currency_formatter.dart';
import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:dest_crypt/src/utils/time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({super.key});

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        title: Text('Market Place', style: AppStyles.blackSemiBold18),
      ),
      body: SafeArea(
        child: Consumer<DashboardProvider>(
          builder: (context, market, _) {
            return SlideInUp(
              child: market.loadState == LoadingState.loading
                  ? Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.containerColor,
                                  borderRadius: BorderRadius.circular(26),
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      horizontalTitleGap: 10,
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        'BitCoin',
                                        style: AppStyles.blackSemiBold16,
                                      ),
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColors.blackColor,
                                        backgroundImage: NetworkImage(''),
                                      ),
                                      trailing: Container(
                                        alignment: Alignment.center,
                                        height: 20,
                                        width: 50,
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            26,
                                          ),
                                          border: Border.all(
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                        child: Text(
                                          '11:30',
                                          style: AppStyles.blackSemi13.copyWith(
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),

                                      subtitle: Text(
                                        '99% positive 202 trades',
                                        style: AppStyles.blackNormal12,
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          '104956.0',
                                          style: AppStyles.blackBold20,
                                        ),
                                        Gap(10),
                                        Text(
                                          '-0.34353',
                                          style: AppStyles.blackSemi13.copyWith(
                                            color: AppColors.greenColor,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Text(
                                      '1 USD = 1.08 USD of BTC',
                                      style: AppStyles.blackNormal12,
                                    ),
                                    Gap(5.0),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Order limit',
                                        style: AppStyles.blackNormal12,
                                        children: [
                                          TextSpan(
                                            text: ' 10-50 USD',
                                            style: AppStyles.semiBold12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Remitta',
                                          style: AppStyles.blackNormal13,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              26,
                                            ),
                                            color: AppColors.greenColor,
                                          ),
                                          child: Text(
                                            'Buy',
                                            style: AppStyles.blackSemi13
                                                .copyWith(fontSize: 13),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Gap(10),
                            ],
                          );
                        },
                        itemCount: 4,
                      ),
                    )
                  : market.loadState == LoadingState.failed
                  ? GestureDetector(
                      onTap: () {
                        context.read<DashboardProvider>().getCoins();
                      },
                      child: Column(
                        children: [
                          Gap(250),
                          Center(
                            child: Icon(
                              Icons.error_outline,
                              color: AppColors.redColor,
                              size: 50,
                            ),
                          ),
                          Text(
                            'An error occured',
                            style: AppStyles.blackBold17,
                          ),
                          Text(
                            'Click to refresh',
                            style: AppStyles.blackBold14,
                          ),

                          Icon(
                            Icons.refresh,
                            color: AppColors.whiteColor,
                            size: 40,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.containerColor,
                                borderRadius: BorderRadius.circular(26),
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    horizontalTitleGap: 10,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      market.coinsList[index].name,
                                      style: AppStyles.blackSemiBold16,
                                    ),
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppColors.blackColor,
                                      backgroundImage: NetworkImage(
                                        market.coinsList[index].image,
                                      ),
                                    ),
                                    trailing: Container(
                                      alignment: Alignment.center,
                                      height: 20,
                                      width: 50,
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(26),
                                        border: Border.all(
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                      child: Text(
                                        DateFormatter().formatDateString(
                                          market.coinsList[index].lastUpdated
                                              .toString(),
                                          true,
                                        ),
                                        style: AppStyles.blackSemi13.copyWith(
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),

                                    subtitle: Text(
                                      '99% positive 202 trades',
                                      style: AppStyles.blackNormal12,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        '\$${CurrencyFormatter().formatWithCommas(market.coinsList[index].currentPrice)}',
                                        style: AppStyles.blackBold20,
                                      ),
                                      Gap(10),
                                      Text(
                                        '${market.coinsList[index].priceChangePercentage24H}',
                                        style: AppStyles.blackSemi13.copyWith(
                                          color:
                                              market
                                                  .coinsList[index]
                                                  .priceChangePercentage24H
                                                  .toString()
                                                  .contains('-')
                                              ? AppColors.redColor
                                              : AppColors.greenColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Text(
                                    '1 USD = 1.08 USD of BTC',
                                    style: AppStyles.blackNormal12,
                                  ),
                                  Gap(5.0),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Order limit',
                                      style: AppStyles.blackNormal12,
                                      children: [
                                        TextSpan(
                                          text: ' 10-50 USD',
                                          style: AppStyles.semiBold12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Remitta',
                                        style: AppStyles.blackNormal13,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BuyCoinScreen(
                                                    coinImage: market
                                                        .coinsList[index]
                                                        .image,
                                                    coinName: market
                                                        .coinsList[index]
                                                        .name,
                                                    coinSymbol: market
                                                        .coinsList[index]
                                                        .symbol,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              26,
                                            ),
                                            color: AppColors.greenColor,
                                          ),
                                          child: Text(
                                            'Buy',
                                            style: AppStyles.blackSemi13
                                                .copyWith(fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gap(10),
                          ],
                        );
                      },
                      itemCount: market.coinsList.length,
                    ),
            );
          },
        ),
      ),
    );
  }
}
