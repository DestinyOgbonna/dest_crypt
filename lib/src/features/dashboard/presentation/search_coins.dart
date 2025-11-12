import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:dest_crypt/src/features/coin_details/presentation/coin_details.dart';
import 'package:dest_crypt/src/features/dashboard/data/dashboard_provider.dart';
import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchCoinsScreen extends StatefulWidget {
  const SearchCoinsScreen({super.key});

  @override
  State<SearchCoinsScreen> createState() => _SearchCoinsScreenState();
}

class _SearchCoinsScreenState extends State<SearchCoinsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        title: Text(
          'Search Coins',
          style: AppStyles.blackSemiBold16.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Consumer<DashboardProvider>(
        builder: (context, dashboard, _) {
          final filteredCoins = dashboard.coinsList.where((coin) {
            final searchLower = _searchQuery.toLowerCase();
            return coin.name.toLowerCase().contains(searchLower) ||
                coin.symbol.toLowerCase().contains(searchLower);
          }).toList();

          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SlideInLeft(
                  child: TextField(
                    controller: _searchController,
                    style: AppStyles.blackNormal16,
                    decoration: InputDecoration(
                      hintText: 'Search coins...',
                      hintStyle: AppStyles.blackNormal16.copyWith(
                        color: AppColors.textBlack,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.greyColor,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: AppColors.whiteColor,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.containerColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                        borderSide: BorderSide(
                          color: AppColors.whiteColor,
                          width: 1,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                Gap(16),

                if (_searchQuery.isNotEmpty && filteredCoins.isEmpty)
                  Expanded(
                    child: FadeIn(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 84,
                              color: AppColors.greyColor,
                            ),
                            Gap(16),
                            Text(
                              'No coins found',
                              style: AppStyles.blackSemiBold18.copyWith(
                                color: AppColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  dashboard.loadState == LoadingState.loading
                      ? Skeletonizer(
                          enabled: true,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Gap(10),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.containerColor,
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.blackColor,
                                  ),
                                  title: Text(
                                    'BitCoin',
                                    style: AppStyles.blackSemiBold16,
                                  ),
                                  subtitle: Text(
                                    'btc',
                                    style: AppStyles.blackSemi13.copyWith(
                                      color: AppColors.textBlack,
                                    ),
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$23435.0',
                                        style: AppStyles.blackSemi15,
                                      ),
                                      Text(
                                        '-2.34533',
                                        style: AppStyles.blackSemi13.copyWith(
                                          color: AppColors.greenColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: 5,
                          ),
                        )
                      : dashboard.loadState == LoadingState.failed
                      ? GestureDetector(
                          onTap: () {
                            context.read<DashboardProvider>().getCoins();
                          },
                          child: Column(
                            children: [
                              Gap(180),
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
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Gap(10),
                            itemBuilder: (context, index) {
                              final coin = filteredCoins[index];
                              return SlideInRight(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor,
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BitcoinDetailScreen(
                                                coinData: coin,
                                              ),
                                        ),
                                      );
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundColor: AppColors.blackColor,
                                      backgroundImage: NetworkImage(coin.image),
                                    ),
                                    title: Text(
                                      coin.name,
                                      style: AppStyles.blackSemiBold16,
                                    ),
                                    subtitle: Text(
                                      coin.symbol.toUpperCase(),
                                      style: AppStyles.blackSemi13.copyWith(
                                        color: AppColors.textBlack,
                                      ),
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '\$${coin.currentPrice.toStringAsFixed(2)}',
                                          style: AppStyles.blackSemi15,
                                        ),
                                        Text(
                                          '${coin.priceChangePercentage24H.toStringAsFixed(2)}%',
                                          style: AppStyles.blackSemi13.copyWith(
                                            color:
                                                coin.priceChangePercentage24H <
                                                    0
                                                ? AppColors.redColor
                                                : AppColors.greenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: min(30, filteredCoins.length),
                          ),
                        ),
              ],
            ),
          );
        },
      ),
    );
  }
}
