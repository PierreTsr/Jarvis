$(document).ready(function() {
  var totalQuestions = $('.questions:not(.hide-text)').length;
  var currentQuestion = 0;
  $questions = $('.questions:not(.hide-text)');
  $submit_bt = $('.submit_bt');
  $next_bt = $('.next');
  $all_set_text = $('.all-set-text');

  $($questions.get(currentQuestion)).removeClass('v-none'); //css('visibility','visible')
  $('.next').show();

  $('#questions-form').keypress((e) => {
    if(e.keyCode == 13) e.preventDefault();
    // console.log(e)
  })
  $('input').keypress(e => {
    if(e.keyCode == 13) {
      return;
    }
  })
  $('.next').click(function (e) {
    let field;
    if(e.target.id == 'create_account_next_btn') {
      field = e.currentTarget.parentElement.children[1].children[1];
    } else {
      field = e.currentTarget.parentElement.children[1].children[0];
    }
    console.log("Field Value", field.value)
    if(field.value.trim() == 0 || field.value.trim().toLowerCase() == 'select country') {
      return;
    }
    if (currentQuestion < totalQuestions - 1) {
        $($questions.get(currentQuestion)).fadeOut (function () {
            console.log()
            $(this).hide();
            currentQuestion += 1 
            $($questions.get(currentQuestion)).removeClass('v-none');
        });
      
    } else {
        $($questions.get(currentQuestion)).fadeOut(function () {
          $all_set_text.removeClass('v-none');
          $next_bt.hide();
          $submit_bt.removeClass('v-none');
        });
    }
  });
})
