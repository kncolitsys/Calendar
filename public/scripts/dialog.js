// Not currently implemented... just testing
function toggleVisibility(item) {
  // line 1195
  var on='visible',off='hidden';
  var itemSection = item + "Section";
  var itemDetails = item + "Details";
  var itemSymbol = item + "Symbol";
  var itemHeader = item + "Header";

  // Initialize the list (and order) of event sections
  var section = new Array(1);
  section[0] = document.all['recurrenceSection'];
  section[1] = document.all['categorySection'];
  section[2] = document.all['contactSection'];
  section[3] = document.all['buttonSection'];

  // Search for the section of interest
  itemIndex = -1;
  for(i=0; i<section.length; i++) {
    if(document.all[itemSection] == section[i]) { itemIndex = i; }
  }
            
  if(itemIndex == -1) {
    alert("unable to find section '" + item + "'");
    return false;
  }

  // Determine the pixel offset
  itemIndex < section.length - 1 ? shift = section[itemIndex].offsetTop - section[itemIndex+1].offsetTop + 35 : shift = 0;

  // Set the visibility and location of the sections
  if(document.all[itemDetails].style.visibility == on) {
    // Hide a section
    document.all[itemDetails].style.visibility=off;
    document.all[itemSymbol].innerHTML = "[+]";
    document.all[itemHeader].className = "dialog";
//    document.all[itemSection].className = "hiddenDialog";

    // Move the layers
    for(i=itemIndex+1; i<section.length; i++) {
      //alert("moving " + i + " " + shift + "px");                
      section[i].style.top = parseInt(section[i].style.top) + shift;
    }
  } else {
    // Display a section
    document.all[itemDetails].style.visibility=on;
    document.all[itemSymbol].innerHTML = "[&#150;]";
   
    alert(document.all[itemDetails].style.top);
   
    for(i=itemIndex+1; i<section.length; i++) {
      alert("moving " + i + " " + shift + "px");
      section[i].style.top = parseInt(section[i].style.top) - shift;
    }
    document.all[itemHeader].className = "dialog";
    document.all[itemSection].className = "dialog";
  }
}
