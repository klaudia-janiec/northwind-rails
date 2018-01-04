$(document).on("ready page:load turbolinks:load", function() {
  var targetNode = document.getElementById('order_details_fieldset');
  if(targetNode != null) {
    var config = {  childList: true, attributes: true, characterData: true };
    var callback = function(mutationsList) {
      for(var mutation of mutationsList) {
        if (mutation.type == 'childList') {
          var added_nodes = mutation.addedNodes;

          for (var added_node of added_nodes) {
            input_fields  = added_node.getElementsByTagName("input");
            select_fields = added_node.getElementsByTagName("select");

            for(var input_field of input_fields) {
              input_field.addEventListener('change', calculateTotalPrice, false);
            }
            for(var select_field of select_fields) {
              select_field.addEventListener('change', calculateTotalPrice, false);
              if(select_field.id.endsWith("_product_id")) {
                select_field.addEventListener('change', fillUnitPrice, false);
              }
            }
          }
        }
        calculateTotalPrice();
      }
    };

    var observer = new MutationObserver(callback);
    observer.observe(targetNode, config);
    for(var child of targetNode.children) {
      observer.observe(child, config);
    }

    document.getElementById("order_freight").addEventListener('change', calculateTotalPrice, false);
  }
});

function fillUnitPrice() {
  var select_fields = document.getElementsByTagName("select");
  for (var select_field of select_fields) {
    if(select_field.id.endsWith("_product_id")) {
      var product_id = select_field.value;
      var product_field_id = select_field.id;
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

function calculateTotalPrice() {
  var select_fields = document.getElementById('order_details_fieldset').getElementsByTagName("select");
  var total_price = 0.0;

  for (var select_field of select_fields) {
    if(select_field.id.endsWith("_product_id") && select_field.parentNode.parentNode.style.display !== "none") {
      var product_field_id = select_field.id;
      var quantity = parseInt(document.getElementById(product_field_id.replace("product_id", "quantity")).value);
      var discount = parseFloat(document.getElementById(product_field_id.replace("product_id", "discount")).value);
      var unit_price = parseInt(document.getElementById(product_field_id.replace("product_id", "unit_price")).value);

      if(!isNaN(unit_price) && !isNaN(quantity) && !isNaN(discount)) {
        total_price += (unit_price * quantity * (1 - discount));
      }
    }
  }

  var freight = parseInt(document.getElementById("order_freight").value)
  if(!isNaN(freight)) {
    total_price += freight;
  }
  document.getElementById("total_price").innerHTML = "$".concat(total_price.toFixed(2));
}
