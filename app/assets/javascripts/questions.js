$(document).ready(function() {
  var totalQuestions = $('.questions:not(.hide-text)').length;
  var currentQuestion = 0;
  $questions = $('.questions:not(.hide-text)');
  $submit_bt = $('.submit_bt');
  $next_bt = $('.next');
  $all_set_text = $('.all-set-text');

  // $questions.hide(); //css('visibility','hidden');
  // $submit_bt.hide();
  // $all_set_text.hide();
  $($questions.get(currentQuestion)).removeClass('v-none'); //css('visibility','visible')
  // $($questions.get(currentQuestion)).fadeIn(); //css('visibility','visible')
  $('.next').show();

  $('.next').click(function () {
      if (currentQuestion < totalQuestions - 1) {
          $($questions.get(currentQuestion)).fadeOut(function () {
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
      //fade out the current question,
  //     $($questions.get(currentQuestion)).fadeOut(function () {
          
  //        //increment the current question by one
  //         currentQuestion = currentQuestion + 1;
  //         console.log(currentQuestion)
  //        //if there are no more questions do stuff
  //        if (currentQuestion == totalQuestions) {
  //             $next_bt.hide();
  //             //$submit_bt.show();
  //            //Redirect to businesses page here 
  //            console.log('at the last question')

  //        } else {
  //            $(this).remove();
  //            $submit_bt.show()
  //            //otherwise show the next question
  //            console.log("HERE: ")
  //            $($questions.get(currentQuestion)).fadeIn();

  //        }
  //    });

  });
})
