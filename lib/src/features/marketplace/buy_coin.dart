import 'package:dest_crypt/src/utils/styles/components/cash_formatter.dart';
import 'package:dest_crypt/src/utils/styles/components/keypad_component.dart';
import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BuyCoinScreen extends StatefulWidget {
  const BuyCoinScreen({
    super.key,
    required this.coinName,
    required this.coinImage,
    required this.coinSymbol,
  });

  final String coinName;
  final String coinSymbol;
  final String coinImage;

  @override
  State<BuyCoinScreen> createState() => _BuyCoinScreenState();
}

class _BuyCoinScreenState extends State<BuyCoinScreen> {
  String amount = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        title: Column(
          children: [
            Text('BUY', style: AppStyles.blackSemi15),
            Text(widget.coinName, style: AppStyles.blackBold15),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.more_horiz_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Gap(100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.coinImage),
                    backgroundColor: AppColors.blackColor,
                  ),
                  Text(
                    ' ${widget.coinName}(\$)',
                    style: AppStyles.blackSemiBold20,
                  ),
                ],
              ),
              Gap(40),
              CashFormatter(amount: amount),
              Gap(80),
              SizedBox(height: 300, child: NumericKeypad(onPressed: onPressed)),
              Gap(40),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Text(
                  'Buy ${widget.coinSymbol}',
                  style: AppStyles.blackBold16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressed(String buttonText) {
    setState(() {
      if (buttonText == "") {
        amount = amount.substring(0, amount.length - 1);
      } else {
        if (amount == "0") {
          amount = buttonText;
        }
        if (amount.length < 10) {
          amount = amount + buttonText;
        }
      }
    });
  }
}
