$(document).ready(function() {
  // let at_new_admin_orders = document.querySelector('body.new.admin_orders') !== null
  // let at_create_admin_orders = document.querySelector('body.create.admin_orders') !== null

  // if (at_new_admin_orders || at_create_admin_orders) {
    let product_id
    let quantity

    function setTotalAmount(evt = null) {
      product_id = parseInt($('#order_product_id').val())
      quantity   = parseInt($('#order_quantity').val())

      console.log({ product_id, quantity })

      if (isNaN(product_id) || isNaN(quantity)) {
        if (evt) {
          alert("Please select product and quantity.")
        }
        evt && evt.preventDefault()
        return
      }

      const product = gon.products.find(product => product.id == product_id)
      const product_price = parseFloat(product.price)

      $('#order_total_amount').val(product_price * quantity)
    }

    $('#new_order').on('submit', function(evt) {
      setTotalAmount(evt)
    })

    $('#order_submit_action').on('click', function(evt) {
      setTotalAmount(evt)
    })

    $('#order_product_id').on('blur', () => setTotalAmount())
    $('#order_quantity').on('blur', () => setTotalAmount())
  // }
});
