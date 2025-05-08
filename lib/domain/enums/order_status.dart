enum OrderStatus {
  canceled(label: 'Cancelado'),
  preparing(label: 'Em preparação'),
  transporting(label: 'Em transporte'),
  delivered(label: 'Entregue');

  const OrderStatus({required this.label});

  final String label;

  bool get isCanceled => this == OrderStatus.canceled;
}
