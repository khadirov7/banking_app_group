import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_utils/my_utils.dart';
import '../../../../data/models/card_model.dart';
import '../../../../utils/styles/app_text_style.dart';

class CardItemView extends StatelessWidget {
  CardItemView({
    super.key,
    required this.cardModel,
    this.onTap,
    this.chipVisibility = true,
  });

  final CardModel cardModel;
  final VoidCallback? onTap;
  final bool chipVisibility;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Color(int.parse("0xff${cardModel.color}")).withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardModel.bank,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  NumberFormat.currency(locale: "uz").format(cardModel.balance),
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Visibility(
              visible: chipVisibility,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: SvgPicture.asset(
                  "assets/icons/chip.svg",
                  width: 41.w,
                  height: 41.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maskFormatter.maskText(cardModel.cardNumber),
                        style: AppTextStyle.interSemiBold.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cardModel.expireDate,
                            style: AppTextStyle.interSemiBold.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        cardModel.cardHolder.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.interSemiBold.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: cardModel.type == -1
                      ? Icon(
                    Icons.credit_card,
                    size: 56.w,
                  )
                      : SvgPicture.asset(
                    getIconPath(cardModel.type),
                    width: 20.w,
                    height: 20.w,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getIconPath(int type) {
    if (type == 1) {
      return "assets/icons/visa.svg";
    }
    if (type == 2) {
      return "assets/icons/visa.svg";
    }
    return "assets/icons/visa.svg";
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}