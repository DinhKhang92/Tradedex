List<String> fillList(List<String> list, List<dynamic> listTotal) {
  for (int i = 0; i < listTotal.length; i++) {
    if (!list.contains(listTotal[i])) {
      list.add(listTotal[i]);
    }
  }

  return list;
}
