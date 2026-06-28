part of '../admin_orders_screen.dart';

class _UserFilter extends StatelessWidget {
  const _UserFilter({required this.userFilter});

  final UserModel userFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
      child: Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /// Nome do usuário
          Text(
            'Pedidos de ${userFilter.fullName}',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.base100,
              fontWeight: FontWeight.w500,
            ),
          ),

          /// Btn limpar filtro
          CustomIconButton(
            icon: AppIcons.close,
            color: AppColors.base100,
            onTap: () => context.read<AdminOrdersManager>().userFilter = null,
          ),
        ],
      ),
    );
  }
}
