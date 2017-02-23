$(document).ready(function(){
  $("div[id^='cart-item-count]'").blur(function(){
  $("form.form_class").submit();
  });

  $(document).on("click",".link_to_add",function(){
  $(".payment").show()
  });

  submitForms = function(){
    document.getElementById("address_fields").submit();
  }

  $('[data-toggle="popover"]').popover(); 
});

// $(document).ready(function(){
//   $("#1").removeClass('in')
// });


// $(document).ready(function(){
//   $(".alert" ).fadeOut(12000)
// });


// $(document).ready(function(){
//   $(".alert-success" ).fadeOut(12000)
// });

// $(document).ready(function(){
//   $(".alert-danger" ).fadeOut(5000)
// });

// $(document).ready(function(){
//   $(document ).on( "click", "#checkbox", function() {
//     if($(this).is(':checked')){
//       var email = $("#bill_to_email").val();
//       var first_name = $("#bill_to_first_name").val();
//       var last_name = $("#bill_to_last_name").val();
//       var address1 = $("#bill_to_address1").val();
//       var address2 = $("#bill_to_address2").val();
//       var postal_code = $("#bill_to_postal_code").val();
//       var country = $("#bill_to_country").val();
//       var state = $("#bill_to_state").val();
//       var mobile_no = $("#bill_to_mobile_no").val();
//       $("#ship_to_email").val(email);
//       $("#ship_to_first_name").val(first_name);
//       $("#ship_to_last_name").val(last_name);
//       $("#ship_to_address1").val(address1);
//       $("#ship_to_address2").val(address2);
//       $("#ship_to_postal_code").val(postal_code);
//       $("#ship_to_country").val(country);
//       $("#ship_to_state").val(state);
//       $("#ship_to_mobile_no").val(mobile_no);
//       $('.ship_to_form :input').attr("disabled", true);
//     }else{
//       $("#ship_to_email").val("");
//       $("#ship_to_first_name").val("");
//       $("#ship_to_last_name").val("");
//       $("#ship_to_address1").val("");
//       $("#ship_to_address2").val("");
//       $("#ship_to_postal_code").val("");
//       $("#ship_to_country").val("");
//       $("#ship_to_state").val("");
//       $("#ship_to_mobile_no").val("");
//       $('.ship_to_form').show();
//       $('.ship_to_form :input').attr("disabled", false);
//     }
//   });
// });



  // console.log(picture_url)
//     // $(document).on('click','#large-image-'+ picture_id, function() {
//       $('#picture-image').css()
//     }
    


// show_
//     $('#product-image').css('background-image', 'url(http://placehold.it/200x200/ff0000)');
// })
// $(document).ready(function(){
//   $(document).on('click','.link_to_add', function(){
//     $('#payment').show()
// });
// });


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


// $(document).ready(function(){
//     $('[data-toggle="popover"]').popover();   
// });