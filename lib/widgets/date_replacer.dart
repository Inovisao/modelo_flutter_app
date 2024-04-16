String dateReplaceAll(String date) {
  // date = date.replaceAll(' ', '-').replaceAll('.', '-').replaceAll(':', '-');
  date = date.replaceAll(' ', 'T');
  return date;
}
