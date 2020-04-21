
document.querySelector(document).ready(function() {

/* Set rates + misc */
var taxRate = 0.05;
var shippingRate = 15.00;
var fadeTime = 300;


/* Assign actions */
document.querySelector('.product-quantity input').change( function() {
  updateQuantity(this);
});

document.querySelector('.product-removal button').click( function() {
  removeItem(this);
});


/* Recalculate cart */
function recalculateCart()
{
  var subtotal = 0;

  /* Sum up row totals */
  document.querySelector('.product').each(function () {
    subtotal += parseFloat(document.querySelector(this).children('.product-line-price').text());
  });

  /* Calculate totals */
  var tax = subtotal * taxRate;
  var shipping = (subtotal > 0 ? shippingRate : 0);
  var total = subtotal + tax + shipping;

  /* Update totals display */
  document.querySelector('.totals-value').fadeOut(fadeTime, function() {
    document.querySelector('#cart-subtotal').html(subtotal.toFixed(2));
    document.querySelector('#cart-tax').html(tax.toFixed(2));
    document.querySelector('#cart-shipping').html(shipping.toFixed(2));
    document.querySelector('#cart-total').html(total.toFixed(2));
    if(total == 0){
      document.querySelector('.checkout').fadeOut(fadeTime);
    }else{
      document.querySelector('.checkout').fadeIn(fadeTime);
    }
    document.querySelector('.totals-value').fadeIn(fadeTime);
  });
}


/* Update quantity */
function updateQuantity(quantityInput)
{
  /* Calculate line price */
  var productRow = document.querySelector(quantityInput).parent().parent();
  var price = parseFloat(productRow.children('.product-price').text());
  var quantity = document.querySelector(quantityInput).val();
  var linePrice = price * quantity;

  /* Update line price display and recalc cart totals */
  productRow.children('.product-line-price').each(function () {
    document.querySelector(this).fadeOut(fadeTime, function() {
      document.querySelector(this).text(linePrice.toFixed(2));
      recalculateCart();
      document.querySelector(this).fadeIn(fadeTime);
    });
  });
}


/* Remove item from cart */
function removeItem(removeButton)
{
  /* Remove row from DOM and recalc cart total */
  var productRow = document.querySelector(removeButton).parent().parent();
  productRow.slideUp(fadeTime, function() {
    productRow.remove();
    recalculateCart();
  });
}

});
