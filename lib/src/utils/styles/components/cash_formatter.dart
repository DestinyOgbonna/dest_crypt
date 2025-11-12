import 'package:dest_crypt/src/utils/styles/styles.dart';
import 'package:flutter/material.dart';

class CashFormatter extends StatelessWidget {
  const CashFormatter({super.key, required this.amount});
  final String amount;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        List<String> parts = amount.split('.');

        return Text.rich(
          amount == ''
              ? TextSpan(
                  children: [
                    TextSpan(
                      text: '0',

                      style: AppStyles.blackBold26.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    TextSpan(
                      text: '.00',
                      style: AppStyles.blackBold26.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                )
              : TextSpan(
                  children: [
                    TextSpan(
                      text: '${parts[0]}.',
                      style: AppStyles.blackBold26,
                    ),
                    TextSpan(
                      text: parts.length < 2 ? '00' : parts[1],
                      style: AppStyles.blackBold26,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
