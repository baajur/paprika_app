class Transaction extends Object {
  static const stateList = [
    {'A': 'Activo'},
    {'I': 'Inactivo'},
    {'E': 'Eliminado'},
    {'P': 'Procesado'}
  ];

  static String stateName(String state) {
    return stateList.firstWhere((s) => s.containsKey(state)).values.first;
  }
}
