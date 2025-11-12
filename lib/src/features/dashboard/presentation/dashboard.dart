import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:dest_crypt/src/features/coin_details/presentation/coin_details.dart';
import 'package:dest_crypt/src/features/dashboard/data/dashboard_provider.dart';
import 'package:dest_crypt/src/features/dashboard/presentation/search_coins.dart';
import 'package:dest_crypt/src/utils/currency_formatter.dart';
import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DashboardProvider>().getCoins();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SlideInUp(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black54,
                automaticallyImplyLeading: false,
                floating: true,
                toolbarHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.containerColor,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                            ),
                          ),
                          title: Text(
                            'Destiny Ogbonna',
                            style: AppStyles.blackSemi15.copyWith(),
                          ),
                          trailing: Container(
                            width: 60,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.greyColor,
                            ),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          subtitle: Text(
                            'Destiny@gmail.com',
                            style: AppStyles.blackNormal10.copyWith(),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          'PORTFOLIO',
                          style: AppStyles.blackSemi13.copyWith(
                            color: AppColors.textBlack,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$5,327.39', style: AppStyles.blackNormal30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '+\$130.62%',
                                  style: AppStyles.blackSemi13.copyWith(
                                    color: AppColors.greenColor,
                                  ),
                                ),
                                Text(
                                  '+\$2,979.39',
                                  style: AppStyles.blackNormal15.copyWith(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 5,
                                  bottom: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: AppColors.greyColor,
                                ),
                                child: Text(
                                  'Withdraw',
                                  style: AppStyles.blackNormal16,
                                ),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 5,
                                  bottom: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: AppColors.greyColor,
                                ),
                                child: Text(
                                  'Deposit',
                                  style: AppStyles.blackNormal16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Consumer<DashboardProvider>(
                  builder: (context, dashboard, _) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              color: AppColors.containerColor,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              'Invite a friend,\nboth receive\n\$10 in BTC',
                              style: AppStyles.blackSemiBold20,
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                color: AppColors.containerColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Market',
                                        style: AppStyles.blackSemi15.copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SearchCoinsScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'See All',
                                          style: AppStyles.blackSemi13.copyWith(
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),

                                  dashboard.loadState == LoadingState.loading
                                      ? Skeletonizer(
                                          enabled: true,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      AppColors.blackColor,
                                                ),
                                                title: Text(
                                                  'BitCoin',
                                                  style:
                                                      AppStyles.blackSemiBold16,
                                                ),
                                                subtitle: Text(
                                                  'btc',
                                                  style: AppStyles.blackSemi13
                                                      .copyWith(
                                                        color:
                                                            AppColors.textBlack,
                                                      ),
                                                ),
                                                trailing: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '\$23435.0',
                                                      style:
                                                          AppStyles.blackSemi15,
                                                    ),
                                                    Text(
                                                      '-2.34533',
                                                      style: AppStyles
                                                          .blackSemi13
                                                          .copyWith(
                                                            color: AppColors
                                                                .greenColor,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            itemCount: 3,
                                          ),
                                        )
                                      : dashboard.loadState ==
                                            LoadingState.failed
                                      ? GestureDetector(
                                          onTap: () {
                                            context
                                                .read<DashboardProvider>()
                                                .getCoins();
                                          },
                                          child: Column(
                                            children: [
                                              Gap(60),
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
                                      : Expanded(
                                          child: Skeletonizer(
                                            enabled:
                                                dashboard.coinsList.isEmpty,
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BitcoinDetailScreen(
                                                              coinData: dashboard
                                                                  .coinsList[index],
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.blackColor,
                                                    backgroundImage:
                                                        NetworkImage(
                                                          dashboard
                                                              .coinsList[index]
                                                              .image,
                                                        ),
                                                  ),
                                                  title: Text(
                                                    dashboard
                                                        .coinsList[index]
                                                        .name,
                                                    style: AppStyles
                                                        .blackSemiBold16,
                                                  ),
                                                  subtitle: Text(
                                                    dashboard
                                                        .coinsList[index]
                                                        .symbol,
                                                    style: AppStyles.blackSemi13
                                                        .copyWith(
                                                          color: AppColors
                                                              .textBlack,
                                                        ),
                                                  ),
                                                  trailing: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '\$${CurrencyFormatter().formatWithCommas(dashboard.coinsList[index].currentPrice)}',
                                                        style: AppStyles
                                                            .blackSemi15,
                                                      ),
                                                      Text(
                                                        '${dashboard.coinsList[index].priceChangePercentage24H}',
                                                        style: AppStyles.blackSemi13.copyWith(
                                                          color:
                                                              dashboard
                                                                  .coinsList[index]
                                                                  .priceChangePercentage24H
                                                                  .toString()
                                                                  .contains('-')
                                                              ? AppColors
                                                                    .redColor
                                                              : AppColors
                                                                    .greenColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount: min(
                                                30,
                                                dashboard.coinsList.length,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
