//**************************************************************************
// function: isEmail(string)
//  purpose: Validates that the argument is a valid email address
//    input: string - a string representing the email address to validate
//  returns: [true|false]
function isEmail(email) {
  var regexp = new RegExp("([a-z0-9_.-]+@[a-zA-Z0-9_.-]+\.[a-zA-Z0-9_.-]+)", "i")
  return regexp.test(email);
}
