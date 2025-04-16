part of '../checkout_screen.dart';

class _OrderLoading extends StatelessWidget {
  const _OrderLoading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // CircularProgressIndicator
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(MyColors.base100),
          ),

          // Text
          Text(
            'Processando seu pagamento...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: MyColors.base100,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
