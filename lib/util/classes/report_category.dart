class ReportCategory {
  static final Map<String, int> types = {
    "Police Station": 1,
    "Hospital": 2,
    "Weather": 3,
    "Fire Station": 4,
    "Social Services": 5,
  };

  Set<int> _selected = {};

  List<int> get selected => _selected.toList();

  void add(int type) {
    if (type == 5) {
      _selected = {};
      _selected.add(type);
    } else {
      _selected.remove(5);
      _selected.add(type);
    }
  }

  void remove(int type) {
    _selected.remove(type);
  }

  void clear() {
    _selected.clear();
  }

  @override
  String toString() {
    return "[${_selected.toList().join(',')}]";
  }
}
