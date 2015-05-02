document.addEventListener("DOMContentLoaded", function(event) { 
  // Activate list sorting and filtering.
  var userList = new List('recipetable', {
    valueNames: [
      'title',
      'category',
      'method',
      'yield',
      'prep',
      'cook',
      'total'
    ],
    page: 500
  });

});