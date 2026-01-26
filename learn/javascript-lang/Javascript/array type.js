// {}
Object.keys(variable).length === 0

// string compare

export function localeSort(str1, str2) {
  return str1.localeCompare(str2, 'en', {numeric: true});
}

// date compare

export function dateStringSort(date1, date2) {
  date1 = moment.utc(date1);
  date2 = moment.utc(date2);

  return date1.diff(data2);

  // Algorithm 2
  // if (date1.isBefore(date2)) {
  //   return -1;
  // } else if (date1.isAfter(date2)) {
  //   return 1;
  // } else {
  //   return 0;
  // }
}

## array: get last one but not remove array[-1]
array.slice(-1)[0]
