function sort(selection) {
  quickSort(selection, 0, selection.length-1);
}

function quickSort(A,p,r) {
//  alert("quickSort: " + p + "," + r);
  if (p < r) {
    q = partition(A,p,r);
    quickSort(A,p,q);
    quickSort(A,q+1,r);
  }
}

function partition(A,p,r) {
//  alert("partition: " + p + "," + r);
  x = new String(A[p].text).toLowerCase();
  i = p-1;
  j = r+1;
  while (true) {
    do { j--; } while (new String(A[j].text).toLowerCase() > x)
    do { i++; } while (new String(A[i].text).toLowerCase() < x)
    if (i < j) {
      // Swap the value, then swap the text
      tmp = A[i].value; A[i].value = A[j].value; A[j].value = tmp;
      tmp = A[i].text; A[i].text = A[j].text; A[j].text = tmp;
    } else {
      return j;
    }      
  }
}
