$(document).ready(function(){
  $("div[id^='cart-item-count]'").blur(function(){
  $("form.form_class").submit();
  });
  });






$(document).ready(function(){
$("#1").removeClass('in')
});


$(document).ready(function(){
  $(".alert" ).fadeOut(12000)
});
$(document).ready(function(){
  $(".alert-success" ).fadeOut(12000)
});
// $(document).ready(function(){
//   $(".alert-danger" ).fadeOut(5000)
// });

$(document).ready(function(){
  $("#checkbox").click(function(){
    if($(this).is(':checked')){
      var email = $("#bill_to_email").val();
      $("#ship_to_email").val(email);
    }else{
      $("#ship_to_email").val("");
    }
  });
});


// function show_brand(id){
//   debugger
//   $('#'+id).addClass('in')
// }


// $(document).ready(function(){
// $(".category").onClickremoveClass('in')
// });

// $(document).ready(function() {
//    $('.flash').delay(500).fadeIn('normal', function() {
//       $(this).delay(2500).fadeOut();
//    });
// });


// $(document).ready(function(){
// $('.flash').fadeOut(4000)
// });

// $(document).ready(function(){
// $('.cart_quantity_up').onClick(function(){
//   $('.alert, .alert-success').alert('abc');
// });
// });


// $(document).ready(function() {
//     $(".cart_quantity_up").click( alert('abc')
//     });
// });


submitForms = function(){
  document.getElementById("address_fields").submit();
}