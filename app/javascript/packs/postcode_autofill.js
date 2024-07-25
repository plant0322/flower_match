$(document).on('turbolinks:load', function () {
  $('#shop_postal_code').jpostal({
    postcode : [
      '#shop_postal_code'
    ],
    address : {
      '#shop_prefecture_code' : '%3',
      '#shop_address'    : '%4%5',
    }
  });
});