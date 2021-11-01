var totalQuestions = $('.questions').size();

var currentQuestion = 0;

$questions = $('.questions');

// $questions.hide();
$questions.css('display', 'none');
$($questions.get(currentQuestion)).fadeIn();

$('.next').click(function () {

    //fade out the current question,
    //putting a function inside of fadeOut calls that function 
    //immediately after fadeOut is completed, 
    //this is for a smoother transition animation
    $($questions.get(currentQuestion)).fadeOut(function () {

       //increment the current question by one
       currentQuestion = currentQuestion + 1;
        console.log(currentQuestion)
       //if there are no more questions do stuff
       if (currentQuestion == totalQuestions) {
           
           //Redirect to businesses page here 
           console.log('showed all questions')

       } else {
           $(this).remove();
           //otherwise show the next question
           $($questions.get(currentQuestion)).fadeIn();

       }
   });

});