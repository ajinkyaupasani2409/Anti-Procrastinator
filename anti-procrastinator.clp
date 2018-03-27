(reset)

(printout t crlf "Type Yes or No for input, case-sensitivity will be an issue in the input" crlf crlf)

(deftemplate started
	(slot answer))
	
(defglobal ?*have_start_Y* = "")
(defglobal ?*have_start_N* = "")

(defrule starter
	=>
	(printout t "Is there work to do?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(bind ?*have_start_Y* (assert (started (answer Yes))))
	else
		(if (= ?answer "No") then 
			(bind ?*have_start_N* (assert (started (answer No))))
		)	
	)
)	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
(deftemplate askstart
	(slot answer))

(defglobal ?*ask_Y* = "")
(defglobal ?*ask_N* = "")	
	
(defrule have_started
	(started (answer Yes))
	=>
	(printout t "Have you started doing your work? " crlf "1.Yes" crlf "2.No" crlf )
	(bind ?answer (read))
	(if (= ?answer "Yes")then 
	(bind ?*ask_Y* (assert (askstart(answer Yes))))
	else 
		(if (= ?answer "No")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))		
		) 
	) 
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defglobal ?*lying_Y* = "")
(defglobal ?*lying_N* = "")

(deftemplate lie
	(slot answer))

(defrule lying
	(askstart (answer Yes))
	=>
	(printout t "Are you sure? " crlf "1.Yes" crlf "2.No" crlf )
	(bind ?answer (read))
	(if (= ?answer "Yes")then 
	(bind ?*lying_Y* (assert (lie(answer Yes))))
	else 
		(if (= ?answer "No")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))
		) 
	) 
)	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*deadline_Y* = "")
(defglobal ?*deadline_N* = "")

(deftemplate deadline
	(slot answer))

(defrule is-there-deadline
	(lie (answer Yes))
	=>
	(printout t "Is there a deadline? " crlf "1.Yes" crlf "2.No" crlf )
	(bind ?answer (read))
	(if (= ?answer "Yes")then 
	(bind ?*deadline_Y* (assert (deadline(answer Yes))))
	else 
		(if (= ?answer "No")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))
		) 
	) 
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*consequence_Y* = "")
(defglobal ?*consequence_N* = "")

(deftemplate consequence
	(slot answer))

(defrule will-there-be-consequence
	(deadline (answer Yes))
	=>
	(printout t "Will there be consequences if you do it later? " crlf "1.Yes" crlf "2.No" crlf )
	(bind ?answer (read))
	(if (= ?answer "Yes")then 
	(bind ?*consequence_Y* (assert (consequence(answer Yes))))
	
	else 
		(if (= ?answer "No")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))
		) 
	) 
)	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*effect_Y* = "")
(defglobal ?*effect_N* = "")

(deftemplate effect
	(slot answer))

(defrule who-affected
	(consequence (answer Yes))
	=>
	(printout t "Will the consequences be for you or someone else? " crlf "1.You" crlf "2.Someone else" crlf )
	(bind ?answer (read))
	(if (= ?answer "You")then 
	(bind ?*effect_Y* (assert (effect (answer Yes))))
	
	else 
		(if (= ?answer "Someone else")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))
		) 
	) 
)	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*getout_Y* = "")
(defglobal ?*getout_N* = "")

(deftemplate getout
	(slot answer))

(defrule can-get-out
	(effect (answer Yes))
	=>
	(printout t "Any way to get out of the commitment? " crlf "1.Yes" crlf "2.No" crlf )
	(bind ?answer (read))
	(if (= ?answer "Yes")then 
	(bind ?*getout_Y* (assert (getout(answer Yes))))
	
	else 
		(if (= ?answer "No")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))
		) 
	) 
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*moral_Y* = "")
(defglobal ?*moral_N* = "")

(deftemplate moral
	(slot answer))

(defrule morally-objectionable
	(getout (answer Yes))
	=>
	(printout t "Won't it be morally objectionable to recuse yourself from the task? " crlf "1.Yes" crlf "2.No" crlf )
	(bind ?answer (read))
	(if (= ?answer "Yes")then 
	(bind ?*getout_Y* (assert (moral(answer Yes))))
	
	else 
		(if (= ?answer "No")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))
		) 
	) 
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*justify_Y* = "")
(defglobal ?*justify_N* = "")

(deftemplate justify
	(slot answer))

(defrule can-justify
	(moral (answer Yes))
	=>
	(printout t "Can you justify it anyways? " crlf "1.Yes" crlf "2.No" crlf )
	(bind ?answer (read))
	(if (= ?answer "Yes")then 
	(bind ?*getout_Y* (assert (justify(answer Yes))))
	
	else 
		(if (= ?answer "No")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))
		) 
	) 

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*hired_Y* = "")
(defglobal ?*hired_N* = "")

(deftemplate hired
	(slot answer))

(defrule are-you-hired
	(justify (answer Yes))
	=>
	(printout t "Is someone paying you for the work? " crlf "1.Yes" crlf "2.No" crlf )
	(bind ?answer (read))
	(if (= ?answer "Yes")then 
	(bind ?*getout_Y* (assert (hired(answer Yes))))
	
	else 
		(if (= ?answer "No")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))
		) 
	) 
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defglobal ?*see_Y* = "")
(defglobal ?*see_N* = "")

(deftemplate see
	(slot answer))

(defrule can-they-see-you
	(hired (answer Yes))
	=>
	(printout t "Can they see you right now? " crlf "1.Yes" crlf "2.No" crlf )
	(bind ?answer (read))
	(if (= ?answer "Yes")then 
	(bind ?*see_Y* (assert (see(answer Yes))))
	
	else 
		(if (= ?answer "No")then
			(printout t "Ummm....Ok then! Let's see.....  ") 
			(reset)
			(assert (started (answer No)))
		) 
	) 
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule do-the-work
	(see (answer Yes))
	=>
	(printout t "       ---------------------------- " crlf)
	(printout t "      |                            | " crlf)
	(printout t "      |  DO THE WORK RIGHT NOW!!!! | " crlf)
	(printout t "      |                            | " crlf)
	(printout t "       ---------------------------- " crlf)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate hungry
	(slot answer))
	
(defglobal ?*hungry_Y* = "")
(defglobal ?*hungry_N* = "")

(defrule are-you-hungry
	(started (answer No))
	=>
	(printout t "Are you hungry?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(bind ?*hungry_Y* (assert (hungry (answer Yes))))
	else
		(if (= ?answer "No") then 
			(bind ?*hungry_N* (assert (hungry (answer No))))
		)	
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate findfood
	(slot answer))
	
(defglobal ?*findfood_Y* = "")
(defglobal ?*findfood_N* = "")

(defrule find-some-food-yes
	(hungry (answer Yes))
	=>
	(printout t "       ---------------------------- " crlf)
	(printout t "      |    GO FIND SOME FOOD !!!!  | " crlf)
	(printout t "       ---------------------------- " crlf)
	(bind ?*findfood_Y* (assert (findfood (answer Yes))))
)

(defrule find-some-food-no
	(hungry (answer No))
	=>
	(printout t "       ------------------------------------------------------- " crlf)
	(printout t "      | NEVERMIND THAT! SEE IF YOU CAN GET A LIGHT SNACK !!!! | " crlf)
	(printout t "      |            AND REMEMBER TO EAT HEALTHY                |" crlf)
	(printout t "       -------------------------------------------------------  " crlf)
	(bind ?*findfood_N* (assert (findfood (answer Yes))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate cook
	(slot answer))
	
(defglobal ?*cook_Y* = "")
(defglobal ?*cook_N* = "")

(defrule need-to-cook
	(findfood (answer Yes))  
	=>
	(printout t crlf "Now.....Do you have something to eat on you?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(bind ?*cook_Y* (assert (cook (answer Yes))))
	else
		(if (= ?answer "No") then 
			(bind ?*cook_N* (assert (cook (answer No))))
		)	
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate eatyourfood
	(slot answer))

(defrule no-need-to-cook
	(cook (answer Yes))
	=>
	(printout t "       ------------------------- " crlf)
	(printout t "      | GREAT! EAT IT THEN !!!! | " crlf)
	(printout t "       ------------------------- " crlf)
	(printout t crlf "Now that you've had some respite...." crlf)
	(reset)
	(assert (started (answer Yes)))
	;;;(assert (eatyourfood (answer Yes))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate buyfood
	(slot answer))
	
(defglobal ?*buyfood_Y* = "")
(defglobal ?*buyfood_N* = "")

(defrule money-to-eat
	(cook (answer No)) 
	=>
	(printout t crlf "Do you have money to buy food?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(bind ?*cook_Y* (assert (buyfood (answer Yes))))
	else
		(if (= ?answer "No") then 
			(bind ?*cook_N* (assert (buyfood (answer No))))
		)	
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate dineout
	(slot answer))

(defrule eat-out
	(buyfood (answer Yes))
	=>
	(printout t "       ------------------------------------- " crlf)
	(printout t "      | GREAT! GO TO SOME DINER TO EAT !!!! | " crlf)
	(printout t "       ------------------------------------- " crlf)
	(printout t crlf "Now that you've had your fun...." crlf)
	(assert (dineout (answer Yes)))
	(reset)
	(assert (started (answer Yes)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate internet
	(slot rand_browse (default No))
	(slot fb (default No))
	(slot chat (default No))
	(slot email (default No))
	(slot time_passed (default No))
)
	
(defglobal ?*rand_browse* = "")
(defglobal ?*fb* = "")
(defglobal ?*chat* = "")
(defglobal ?*email* = "")

(defrule chill-on-internet
	(buyfood (answer No))  
	=>
	(printout t "       ---------------------------------------------------------------------- " crlf)
	(printout t "      | THAT SUCKS !! WELL THEN, CHILL OUT FOR SOME TIME ON THE INTERNET     | " crlf)
	(printout t "      | SELECT ONE OF THE OPTIONS THAT YOU WOULD LIKE TO DO (NUMBER AS I/P): |" crlf)
	(printout t "      | 1. RANDOMLY BROWSE                                                   |" crlf)
	(printout t "      | 2. FACEBOOK OR INSTAGRAM                                             |" crlf)
	(printout t "      | 3. CHAT WITH SOMEONE                                                 |" crlf)
	(printout t "      | 4. CHECK E-MAIL                                                      |" crlf)
	(printout t "       ---------------------------------------------------------------------- " crlf)
	(bind ?answer (read))
	(if (= ?answer 1)then
		(bind ?*rand_browse* (assert (internet (rand_browse Yes))))
	elif (= ?answer 2) then 
			(bind ?*fb* (assert (internet (fb Yes))))
	elif (= ?answer 3) then 
			(bind ?*chat* (assert (internet (chat Yes))))
	elif (= ?answer 4) then 
			(bind ?*email* (assert (internet (email Yes))))		
	else 	
		(printout t "Wrong Inp" crlf)	
	)	
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate browser
	(slot wiki (default No))
	(slot reddit (default No))
	(slot youtube (default No))
	(slot netflix (default No))
	(slot found_interesting (default No))
)
	
(defglobal ?*wiki* = "")
(defglobal ?*reddit* = "")
(defglobal ?*youtube* = "")
(defglobal ?*netflix* = "")

(defrule do-random-browsing
	(internet (rand_browse Yes))  
	=>
	(printout t "       ------------------------------------------------------" crlf)
	(printout t "      | LOOK FOR SOME SITE TO KILL SOME TIME (NUMBER AS I/P) |" crlf)
	(printout t "      | SELECT ONE OF THE OPTIONS THAT YOU WOULD LIKE TO DO: |" crlf)
	(printout t "      | 1. WIKIPEDIA                                         |" crlf)
	(printout t "      | 2. REDDIT OR DIGG                                    |" crlf)
	(printout t "      | 3. YOUTUBE                                           |" crlf)
	(printout t "      | 4. NETFLIX                                           |" crlf)
	(printout t "       ------------------------------------------------------ " crlf)
	(bind ?answer (read))
	(if (= ?answer 1)then
		(bind ?*wiki* (assert (browser (wiki Yes))))
	elif (= ?answer 2) then 
			(bind ?*reddit* (assert (browser (reddit Yes))))
	elif (= ?answer 3) then 
			(bind ?*youtube* (assert (browser (youtube Yes))))
	elif (= ?answer 4) then 
			(bind ?*netflix* (assert (browser (netflix Yes))))		
	else 	
		(printout t "Wrong Inp" crlf)	
	)	
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule wiki-searches
	(browser (wiki Yes)) 
	=>
	(printout t "       -------------------------------------- " crlf)
	(printout t "      | START A TRAIL OF RELATED TOPICS ...  | " crlf)
	(printout t "       -------------------------------------- " crlf)
	
	(assert (browser (found_interesting Yes)))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule reddit-searches
	(browser (reddit Yes)) 
	=>
	(printout t "       -------------------------------------------------------------" crlf)
	(printout t "      |     LOOK FOR SOME INTERESTING TOPIC ON REDDIT OR DIGG       | " crlf)
	(printout t "      |                                                             |" crlf)
	(printout t "      |         READ DOZENS OF TOPICS                               |" crlf)
	(printout t "      |         OPTINAL : WRITE COMMENTS                            |" crlf)
	(printout t "      |         CREATE A SWARM OF TABS                              |" crlf)
	(printout t "       ------------------------------------------------------------- " crlf)
	
	(assert (browser (found_interesting Yes)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule youtube-searches
	(browser (youtube Yes)) 
	=>
	(printout t "       -------------------------------------------------------------" crlf)
	(printout t "      |         LOOK FOR SOME INTERESTING VIDEOS ON YOUTUBE         | " crlf)
	(printout t "      |                                                             |" crlf)
	(printout t "      |         LOOK FOR NEW VIDEOS FROM YOUR SUBSCRIPTIONS         |" crlf)
	(printout t "      |         LOOK FOR TRENDING VIDEOS                            |" crlf)
	(printout t "      |         LOOK FOR VIDEOS MARKED TO BE WATCHED LATER          |" crlf)
	(printout t "       ------------------------------------------------------------- " crlf)
	
	(assert (browser (found_interesting Yes)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule netflix-searches
	(browser (netflix Yes)) 
	=>
	(printout t "       ----------------------------------------------- " crlf)
	(printout t "      | LOOK FOR SOME GOOD MOVIE OR EPISODE TO WATCH  | " crlf)
	(printout t "       -----------------------------------------------	 " crlf)
	
	(assert (browser (found_interesting Yes)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate find_something
	(slot answer))
	
(defglobal ?*find_something_Y* = "")
(defglobal ?*find_something_N* = "")

(defrule found-something-good
	(browser (found_interesting Yes))
	=>
	(printout t "Found anything interesting?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(bind ?*find_something_Y* (assert (find_something (answer Yes))))
	else
		(if (= ?answer "No") then 
			(assert ( internet (time_passed Yes))) 
		)	
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate motivated
	(slot answer))
	
(defglobal ?*motivated* = "")

(defrule found-something-motivational
	(find_something (answer Yes))
	=>
	(printout t "Did you find something that motivated you or made you realise that you're not living up to your life's full potential ?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(printout t "       ------------------------------------------------------ " crlf)
		(printout t "      | MAKE A LIST OF GOALS THAT YOU WOULD LIKE TO ACHIEVE  | " crlf)
		(printout t "       ------------------------------------------------------	 " crlf)
		(bind ?*motivated* (assert (motivated (answer Yes))))
	else
		(if (= ?answer "No") then 
			(bind ?*motivated* (assert (motivated (answer Yes)))) 
		)	
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate other_care
	(slot answer))
	
(defglobal ?*other_care* = "")

(defrule will-others-care
	(motivated (answer Yes))
	=>
	(printout t "Will other people in your social circle care about it ?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(printout t "       -------------------------------------------------- " crlf)
		(printout t "      | TWEET, FACEBOOK, BLOG OR GRAM ABOUT THE THOUGHT  | " crlf)
		(printout t "       --------------------------------------------------	 " crlf)
		
		(assert ( internet (time_passed Yes))) 
	else
		(if (= ?answer "No") then 
			(assert ( internet (time_passed Yes))) 
		)	
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate socialize
	(slot answer))
	
(defglobal ?*socialize_Y* = "")
(defglobal ?*socialize_N* = "")

(defrule socaial-network
	(internet (fb Yes))  
	=>
	(printout t "       ----------------------------------- " crlf)
	(printout t "      | LOOK AT PROFILES AND UPDATES !!!  | " crlf)
	(printout t "       ----------------------------------- " crlf)
	(printout t crlf "Do you know them well?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(bind ?*socialize_Y* (assert (socialize (answer Yes))))
	else
		(if (= ?answer "No") then 
			(bind ?*socialize_N* (assert (socialize (answer No))))
		)	
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate date
	(slot answer))

(defrule have-you-dated
	(socialize (answer Yes))  
	=>
	(printout t crlf "Have you dated?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(assert (date (answer Yes)))
	else
		(if (= ?answer "No") then 
			(bind ?*socialize_N* (assert (socialize (answer No))))
		)	
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule still-talk
	(date (answer Yes))  
	=>
	(printout t crlf "Do you still talk?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(printout t "       ------------------- " crlf)
		(printout t "      | GET IN TOUCH !!!  | " crlf)
		(printout t "       ------------------- " crlf)
		
		(assert ( internet (time_passed Yes)))
	else
		(if (= ?answer "No") then 
			(bind ?*socialize_N* (assert (socialize (answer No))))
		)	
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule live-vicariously
	(socialize (answer No))  
	=>
	(printout t "       ---------------------------------------------------------- " crlf)
	(printout t "      | LIVE VICARIOUSLY THROUGH THEIR PICTURES OR STATUSES !!!  | " crlf)
	(printout t "       ---------------------------------------------------------- " crlf)
		
	(assert ( internet (time_passed Yes)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deftemplate chatting
	(slot answer))
	
(defglobal ?*chatting_Y* = "")
(defglobal ?*chatting_N* = "")

(defrule chat-with-someone
	(internet (chat Yes))  
	=>
	(printout t crlf "Anyone online to chat to?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(bind ?*chatting_Y* (assert (chatting (answer Yes))))
	else
		(if (= ?answer "No") then 
			(bind ?*chatting_N* (assert (chatting (answer No))))
			(retract ?*chat* ?*cook_N*)
			(assert ?*cook_N*)
		)	
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate are_interesting
	(slot answer))
	
(defglobal ?*are_interesting_Y* = "")
(defglobal ?*are_interesting_N* = "")

(defrule are-they-interesting-to-chat
	(chatting (answer Yes))  
	=>
	(printout t crlf "Are they interesting to chat to?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(printout t "       ------------------------------------- " crlf)
		(printout t "      |    CHAT WITH THEM FOR A WHILE !!!!  | " crlf)
		(printout t "       ------------------------------------- " crlf)
		(assert (internet (time_passed Yes)))
	else
		(if (= ?answer "No") then 
			(printout t "       ------------------------------------------------------- " crlf)
			(printout t "      |    CALL SOME FRIEND AND TALK TO HIM FOR A WHILE !!!!  | " crlf)
			(printout t "       ------------------------------------------------------- " crlf)
	
			(assert ( internet (time_passed Yes)))
		)	
	)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate check_mail
	(slot answer))
	
(defglobal ?*check_mail_Y* = "")
(defglobal ?*check_mail_N* = "")

(defrule check-your-mails
	(internet (email Yes)) 
	=>
	(printout t "       --------------------------- " crlf)
	(printout t "      |    CHECK YOUR MAILS !!!!  | " crlf)
	(printout t "       --------------------------- " crlf)
	(printout t crlf "Any new mails?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(bind ?*check_mail_Y* (assert (check_mail (answer Yes))))
	else
		(if (= ?answer "No") then 
			(assert ( internet (time_passed Yes)))  ;;;;;;;;;;;;;
		)	
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate reply_mail
	(slot answer))
	
(defglobal ?*reply_mail_Y* = "")
(defglobal ?*reply_mail_N* = "")

(defrule check-the-mail
	(check_mail (answer Yes)) 
	=>
	(printout t crlf "Is it something you have to reply to?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(printout t "       ------------------------------ " crlf)
		(printout t "      |    REPLY TO YOUR MAILS !!!!  | " crlf)
		(printout t "       ------------------------------ " crlf)
		(assert ( internet (time_passed Yes)))
	else
		(if (= ?answer "No") then 
			(assert ( internet (time_passed Yes)))  ;;;;;;;;;;;;;
		)	
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftemplate has_time_passed
	(slot answer))
	
(defglobal ?*has_time_passed_Y* = "")
(defglobal ?*has_time_passed_N* = "")

(defrule significant-time-passed
	(internet (time_passed Yes)) 
	=>
	(printout t crlf "Has significant time passed?" crlf "1 Yes     2.No" crlf)
	(bind ?answer (read))
	(if (= ?answer "Yes")then
		(reset)
		(assert (started (answer Yes)))
	else
		(if (= ?answer "No") then 
			(reset)
			(assert (started (answer No)))
		)
	)
)


(reset) 
(run)



