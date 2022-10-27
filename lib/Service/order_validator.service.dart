class OrderValidator {
  static String? validarTroco(String moneyChange, double valueTotal) {
    double troco = moneyChange.isNotEmpty
        ? double.parse(moneyChange.toString().replaceAll(",", "."))
        : 0;
    if (moneyChange.isEmpty) return 'Troco é obrigatório';
    if (valueTotal > troco) return 'Não é possível retornar troco';
    return null;
  }
}