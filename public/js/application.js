$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $("form").on('click','#guessbutton',function(e){
    console.log(e);
    e.preventDefault();
    $.ajax({
        type: 'POST',
        url: '/play',
        data: $("form").serialize()
    }).done(function(response) {
        // console.log(response.message);
        // console.log(response.front);
        // console.log(response.back);
        $('#server_answer').text(response.message);
        window.setTimeout(function() {
          $('#card_answer').attr('value', response.back);
          $('#new_front').text(response.front);
        }, 3000);
      });
  });
});
