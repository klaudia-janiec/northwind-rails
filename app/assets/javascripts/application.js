//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require cocoon

function fillUnitPrice() {
  var select_fields = document.getElementsByTagName("select");
  for (var i = 0; i < select_fields.length; i++) {
    if(select_fields[i].id.endsWith("_product_id")) {
      var product_id = select_fields[i].value;
      var product_field_id = select_fields[i].id;
      var unit_price_field_id = product_field_id.replace("product_id", "unit_price");

      $.ajax({
         url: "/products/".concat(product_id),
         dataType: "json",
         success: function(data){
           document.getElementById(unit_price_field_id).defaultValue = data.unit_price;
         }
      });
    }
  }
}
