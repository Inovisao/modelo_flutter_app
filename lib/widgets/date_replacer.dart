String dateReplaceAll(String date) {
  date = date.replaceAll(' ', '-').replaceAll('.', '-').replaceAll(':', '-');
  return date;
}
