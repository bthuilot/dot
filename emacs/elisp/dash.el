;;; dash.el --- emacs dashboard config file -*- lexical-binding: t; -*-

;; Copyright (C) Bryce Thuilot 2021


;; Author: Bryce Thuilot <bryce@thuilot.io>
;; Created: 21 Oct 2021

;; URL: https://github.com/bthuilot/dot

;;; Commentary:
;; This file is used for config relating to the `dashboard` package

;;; Code:

(setq epigrams '(
		 "One man's constant is another man's variable."
		 "Functions delay binding; data structures induce binding. oral: Structure data late in the programming process."
		 "Syntactic sugar causes cancer of the semicolon."
		 "Every program is a part of some other program and rarely its."
		 "If a program manipulates a large amount of data, it does o in a small number of ways."
		 "Symmetry is a complexity-reducing concept (co-routines nclude subroutines); seek it everywhere."
		 "It is easier to write an incorrect program than nderstand a correct one."
		 "A programming language is low level when its programs equire attention to the irrelevant."
		 "It is better to have 100 functions operate on one data tructure than 10 functios on 10 data structures."
		 "Get into a rut early: Do the same process the same way. ccumulate idioms. Standardize. The only difference(!) etween Shakespeare and you was the size of his idiom list - ot the size of his vocabulary."
		 "If you have a procedure with ten parameters, you robably missed some."
		 "Recursion is the root of computation since it trades escription for time."
		 "If two people write exactly the same program, each hould be put into microcode and then they certainly won't e the same."
		 "In the long run every program becomes rococo - then ubble."
		 "Everything should be built top-down, except the first ime."
		 "Every program has (at least) two purposes: the one for hich it was written, and another for which it wasn't."
		 "If a listener nods his head when you're explaining your rogram, wake him up."
		 "A program without a loop and a structured variable isn't orth writing."
		 "A language that doesn't affect the way you think about rogramming, is not worth knowing."
		 "Wherever there is modularity there is the potential for isunderstanding: Hiding information implies a need to check ommunication."
		 "Optimization hinders evolution."
		 "A good system can't have a weak command language."
		 "To understand a program you must become both the machine nd the program."
		 "Perhaps if we wrote programs from childhood on, as dults we'd be able to read them."
		 "One can only display complex information in the mind. ike seeing, movement or flow or alteration of view is more mportant than the static picture, no matter how lovely."
		 "There will always be things we wish to say in our rograms that in all known languages can only be said oorly."
		 "Once you understand how to write a program get someone lse to write it."
		 "Around computers it is difficult to find the correct nit of time to measure progress. Some cathedrals took a entury to complete. Can you imagine the grandeur and scope f a program that would take as long?"
		 "For systems, the analogue of a face-lift is to add to he control graph an edge that creates a cycle, not just an dditional node."
		 "In programming, everything we do is a special case of omething more general -- and often we know it too quickly."
		 "Simplicity does not precede complexity, but follows it."
		 "Programmers are not to be measured by their ingenuity nd their logic but by the completeness of their case nalysis."
		 "The eleventh commandment was \"Thou Shalt Compute\" or
\"Thou Shalt Not Compute\" - I forget which."
		 "The string is a stark data structure and everywhere it s passed there is much duplication of process. It is a erfect vehicle for hiding information."
		 "Everyone can be taught to sculpt: Michelangelo would ave had to be taught not to. So it is with great rogrammers."
		 "The use of a program to prove the 4-color theorem will ot change mathematics - it merely demonstrates that the heorem, a challenge for a century, is probably not mportant to mathematics."
		 "The most important computer is the one that rages in our kulls and ever seeks that satisfactory external emulator. he standarization of real computers would be a disaster - nd so it probably won't happen."
		 "Structured Programming supports the law of the excluded iddle."
		 "Re graphics: A picture is worth 10K words - but only hose to describe the picture. Hardly any sets of 10K words an be adequately described with pictures."
		 "There are two ways to write error-free programs; only he third one works."
		 "Some programming languages manage to absorb change, but ithstand progress."
		 "You can measure a programmer's perspective by noting his ttitude on the continuing vitality of FORTRAN."
		 "In software systems, it is often the early bird that akes the worm."
		 "Sometimes I think the only universal in the computing ield is the fetch-execute cycle."
		 "The goal of computation is the emulation of our ynthetic abilities, not the understanding of our analytic nes."
		 "Like punning, programming is a play on words."
		 "As Will Rogers would have said, \"There is no such thing s a free variable.\" "
		 "The best book on programming for the layman is \"Alice in onderland\"; but that's because it's the best book on nything for the layman."
		 "Giving up on assembly language was the apple in our arden of Eden: Languages whose use squanders machine cycles re sinful. The LISP machine now permits LISP programmers to bandon bra and fig-leaf."
		 "When we understand knowledge-based systems, it will be s before -- except our fingertips will have been singed."
		 "Bringing computers into the home won't change either ne, but may revitalize the corner saloon."
		 "Systems have sub-systems and sub-systems have sub- ystems and so on ad infinitum - which is why we're always tarting over."
		 "So many good ideas are never heard from again once they mbark in a voyage on the semantic gulf."
		 "Beware of the Turing tar-pit in which everything is ossible but nothing of interest is easy."
		 "A LISP programmer knows the value of everything, but the ost of nothing."
		 "Software is under a constant tension. Being symbolic it s arbitrarily perfectible; but also it is arbitrarily hangeable."
		 "It is easier to change the specification to fit the rogram than vice versa."
		 "Fools ignore complexity. Pragmatists suffer it. Some can void it.  Geniuses remove it."
		 "In English every word can be verbed. Would that it were o in our programming languages."
		 "In seeking the unattainable, simplicity  only  gets  in he way."
		 "In programming, as in everything else, to be in error is o be reborn."
		 "In computing, invariants are ephemeral."
		 "When we write programs that \"learn\", it turns  out  that e do and they don't."
		 "Often it is the  means  that  justify  the  ends:  Goals dvance  technique  and  technique  survives  even when goal tructures crumble."
		 "Make no mistake about it: Computers  process  numbers  - ot  symbols.  We measure our understanding (and control) by he extent to which we can arithmetize an activity."
		 "Making something variable is easy. Controlling  duration of constancy is the trick."
		 "Think of all the psychic energy expended  in  seeking  a fundamental distinction between \"algorithm\" and \"program\"."
		 "If we believe in data structures,  we  must  believe  independent  (hence  simultaneous)  processing. For why else ould we  collect  items  within  a  structure?  Why  do  we olerate languages that give us the one without the other?"
		 "In a  5  year  period  we  get  one  superb  programming anguage.  Only we can't control when the 5 year period will e."
		 "Over the centuries the Indians developed  sign  language or  communicating  phenomena  of interest. Programmers from ifferent tribes (FORTRAN, LISP, ALGOL, SNOBOL, etc.)  could se  one  that doesn't require them to carry a blackboard on heir ponies."
		 "Documentation  is  like  term  insurance:  It  satisfies ecause  almost  no  one who subscribes to it depends on its enefits."
		 "An adequate bootstrap is a contradiction in terms."
		 "It is not a language's weakness but its  strengths  that ontrol  the  gradient of its change: Alas, a language never scapes its embryonic sac."
		 "Is it possible that software is not like anything  else, hat it is meant to be discarded: that the whole point is to ee it as a soap bubble?"
		 "Because of its vitality, the computing field  is  always n  desperate  need  of  new  cliches:  Banality soothes our erves."
		 "It is the user who should parameterize  procedures,  not heir creators."
		 " The  cybernetic  exchange  between  man,  computer  and lgorithm  is  like  a  game  of musical chairs: The frantic earch for balance always leaves one of the  three  standing ll at ease."
		 "If your computer speaks English, it was probably made in apan."
		 "A year spent in artificial  intelligence  is  enough  to ake one believe in God."
		 "Prolonged contact with the computer turns mathematicians nto clerks and vice versa."
		 "In computing, turning the obvious into the useful  is  a iving definition of the word \"frustration\"."
		 "We are on the verge: Today our program  proved  Fermat's ext-to-last theorem."
		 "What is the difference between a Turing machine and  the odern  computer?   It's  the same as that between Hillary's scent of Everest and the establishment of a Hilton hotel on ts peak."
		 "Motto for a research laboratory: What we work on  today, thers will first think of tomorrow."
		 "Though the Chinese should adore APL, it's  FORTRAN  they ut their money on."
		 "We kid ourselves if we think that the ratio of procedure o   data   in  an  active  data-base  system  can  be  made rbitrarily small or even kept small."
		 "We have  the  mini  and  the  micro  computer.  In  what emantic niche would the pico computer fall?"
		 "It is not the computer's fault that Maxwell's  equations re not adequate to design the electric motor."
		 "One does not learn computing by using a hand calculator, but one can forget arithmetic."
		 "Computation has made the tree flower."
		 "The computer reminds one of Lon  Chaney  --  it  is  the achine of a thousand faces."
		 "The computer is the ultimate  polluter:  its  feces  are ndistinguish- able from the food it produces."
		 "When someone says \"I  want  a  programming  language  in hich  I  need  only  say  what  I  wish  done,\"  give him a ollipop."
		 " Interfaces  keep  things  tidy,  but  don't  accelerate rowth: Functions do."
		 "Don't have good  ideas  if  you  aren't  willing  to  be esponsible for them."
		 "Computers don't introduce order anywhere as much as they xpose opportunities."
		 "When a professor insists computer science is X  but  not , have compassion for his graduate students."
		 "In computing, the mean time  to  failure  keeps  getting horter."
		 "In man-machine symbiosis, it is man who must adjust: The achines can't."
		 "We will never run out of things to program as  long  as here is a single program around."
		 "Dealing with failure is easy:  Work  hard  to  improve. uccess  is  also  easy  to  handle: You've solved the wrong roblem. Work hard to improve."
		 "One can't proceed from the informal to  the  formal  by ormal means."
		 "Purely applicative languages are poorly applicable."
		 "The proof of a system's value is its existence."
		 "You can't communicate complexity, only an awareness  of t."
		 "It's difficult  to  extract  sense  from  strings,  but hey're the only communication coin we can count on."
		 "The debate rages on: is PL/I Bachtrian or Dromedary?"
		 " Whenever  two  programmers  meet  to  criticize  their rograms, both are silent."
		 "Think of it! With VLSI we can pack 100 ENIACS in 1  sq. m."
		 "Editing is a rewording activity."
		 "Why did the Roman Empire collapse? What  is  Latin  for ffice automation?"
		 "Computer Science is embarrassed by the computer."
		 "The only constructive  theory  connecting  neuroscience nd psychology will arise from the study of software."
		 "Within a computer natural language is unnatural."
		 "Most people find the concept  of  programming  obvious, ut the doing impossible."
		 "You think you know when you can learn,  are  more  sure hen  you  can  write,  even  more  when  you can teach, but ertain when you can program."
		 "It goes against the grain of modern education to  teach hildren  to  program.  What  fun  is there in making plans, cquiring  discipline  in  organizing   thoughts,   devoting ttention to detail and learning to be self-critical?"
		 "If you can imagine a society  in  which  the  computer- obot is the only menial, you can imagine anything."
		 "Programming is an unnatural act."
		 "Adapting old programs to fit new machines usually means dapting new machines to behave like old ones."
		 ))

(setq dashboard-footer-messages epigrams)

(setq dashboard-startup-banner 'logo)

(setq dashboard-set-navigator t)

(setq dashboard-items '((recents  . 10)
                        ;; (projects . 5)
                        ;; (agenda . 5))
			))


;; Dashboard
(dashboard-setup-startup-hook)

(provide 'dash)
;;; dash.el ends here
