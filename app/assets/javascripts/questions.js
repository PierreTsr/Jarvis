// var totalQuestions = $('.questions').size();
// console.log(totalQuestions)
// var currentQuestion = 0;

// $questions = $('.questions');
// $submit_bt = $('.submit_bt');
// $next_bt = $('.next');

// $questions.hide(); //css('visibility','hidden');
// $submit_bt.hide();

// $($questions.get(currentQuestion)).fadeIn(); //css('visibility','visible')

// $('.next').click(function () {

//     if (currentQuestion < totalQuestions - 1) {
//         $($questions.get(currentQuestion)).fadeOut(function () {
//             console.log()
//             $(this).remove();
//             currentQuestion += 1 
//             $($questions.get(currentQuestion)).fadeIn();

//         });
       
//     } else {
//         console.log()
//         $next_bt.hide();
//         $submit_bt.show()
//     }
//     //fade out the current question,
// //     $($questions.get(currentQuestion)).fadeOut(function () {
        
// //        //increment the current question by one
// //         currentQuestion = currentQuestion + 1;
// //         console.log(currentQuestion)
// //        //if there are no more questions do stuff
// //        if (currentQuestion == totalQuestions) {
// //             $next_bt.hide();
// //             //$submit_bt.show();
// //            //Redirect to businesses page here 
// //            console.log('at the last question')

// //        } else {
// //            $(this).remove();
// //            $submit_bt.show()
// //            //otherwise show the next question
// //            console.log("HERE: ")
// //            $($questions.get(currentQuestion)).fadeIn();

// //        }
// //    });

// });