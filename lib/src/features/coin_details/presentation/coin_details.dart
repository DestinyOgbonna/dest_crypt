import 'package:dest_crypt/src/features/coin_details/data/coin_details_provider.dart';
import 'package:dest_crypt/src/features/dashboard/data/dashboard_provider.dart';
import 'package:dest_crypt/src/features/marketplace/buy_coin.dart';
import 'package:dest_crypt/src/model/chart_data_model.dart';
import 'package:dest_crypt/src/model/coins_list_model.dart';
import 'package:dest_crypt/src/utils/currency_formatter.dart';
import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BitcoinDetailScreen extends StatefulWidget {
  const BitcoinDetailScreen({super.key, required this.coinData});

  final CoinstListModel coinData;

  @override
  State<BitcoinDetailScreen> createState() => _BitcoinDetailScreenState();
}

class _BitcoinDetailScreenState extends State<BitcoinDetailScreen> {
  String selectedPeriod = '1W';

  final List<String> periods = ['1D', '1W', '1M', '6M'];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CoinDetailsProvider>().getCoins(id: widget.coinData.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    '${widget.coinData.symbol} • ${widget.coinData.name}',
                    style: AppStyles.blackBold15,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 24,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${CurrencyFormatter().formatWithCommas(widget.coinData.currentPrice)}',

                                style: AppStyles.blackBold36.copyWith(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.blackColor,
                                backgroundImage: NetworkImage(
                                  widget.coinData.image,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              !widget.coinData.priceChangePercentage24H
                                      .toString()
                                      .contains('-')
                                  ? Icon(
                                      Icons.arrow_upward,
                                      color: AppColors.greenColor,
                                      size: 16,
                                    )
                                  : Icon(
                                      Icons.arrow_downward,
                                      color: AppColors.redColor,
                                      size: 16,
                                    ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.coinData.priceChangePercentage24H}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      !widget.coinData.priceChangePercentage24H
                                          .toString()
                                          .contains('-')
                                      ? AppColors.greenColor
                                      : AppColors.redColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 280,
                      child: Consumer<CoinDetailsProvider>(
                        builder: (context, coinDetails, _) {
                          if (coinDetails.loadState == LoadingState.loading) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: AppColors.whiteColor,
                              ),
                            );
                          }

                          if (coinDetails.loadState == LoadingState.failed ||
                              coinDetails.coinData.isEmpty) {
                            return const Center(
                              child: Text('Failed to load chart data'),
                            );
                          }

                          final prices = coinDetails.coinData
                              .map((e) => e.price)
                              .toList();
                          final maxPrice = prices.reduce(
                            (a, b) => a > b ? a : b,
                          );
                          final minPrice = prices.reduce(
                            (a, b) => a < b ? a : b,
                          );

                          return SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            margin: const EdgeInsets.all(0),
                            primaryXAxis: NumericAxis(
                              isVisible: false,
                              minimum: 0,
                              maximum:
                                  coinDetails.coinData.length.toDouble() - 1,
                            ),
                            primaryYAxis: NumericAxis(
                              isVisible: false,
                              minimum: minPrice.toDouble() * 0.999,
                              maximum: maxPrice.toDouble() * 1.001,
                            ),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              format: '\$point.y',
                              color: Colors.black87,
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            series: <CartesianSeries>[
                              LineSeries<ChartDataPoint, num>(
                                dataSource: coinDetails.coinData,
                                xValueMapper:
                                    (ChartDataPoint data, int index) => index,
                                yValueMapper: (ChartDataPoint data, _) =>
                                    data.price,
                                pointColorMapper:
                                    (ChartDataPoint data, int index) {
                                      return index ==
                                              coinDetails.coinData.length - 1
                                          ? const Color(0xFFFF9500)
                                          : Colors.grey[300];
                                    },
                                enableTooltip: true,
                                enableTrackball: true,
                                isVisibleInLegend: true,
                                width: 0.6,
                                name: 'Price',
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    Gap(50),

                    // Trading Statistics
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trading Statistics',
                            style: AppStyles.blackBold18.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildStatRow(
                            'Market Cap',
                            '\$${CurrencyFormatter().formatWithCommas(widget.coinData.marketCap)}',
                          ),
                          const SizedBox(height: 12),
                          _buildStatRow(
                            'Market Cap Rank',
                            '#${widget.coinData.marketCapRank} ',
                          ),
                          const SizedBox(height: 12),
                          _buildStatRow(
                            '24h Volume',
                            '\$${CurrencyFormatter().formatWithCommas(widget.coinData.totalVolume)}',
                          ),
                          const SizedBox(height: 12),
                          _buildStatRow(
                            'Circulating Supply',
                            '${CurrencyFormatter().formatWithCommas(widget.coinData.totalSupply)}'
                                ' ${widget.coinData.symbol}',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: AppColors.containerColor,
                      ),
                      child: const Text(
                        'Sell',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuyCoinScreen(
                              coinImage: widget.coinData.image,
                              coinName: widget.coinData.name,
                              coinSymbol: widget.coinData.symbol,
                            ),
                          ),
                        );
                      },

                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: AppColors.containerColor,
                        ),
                        child: const Text(
                          'Buy',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.blackBold12.copyWith(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: AppStyles.blackBold12.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
