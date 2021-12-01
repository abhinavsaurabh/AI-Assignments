get_advice:-

	
	advice(_),
	preferences(List),nl,

	(isempty(List)
		->write('Cannot recommend any elective for you' ),nl
		;write('Electives for you are :'),show(List)			
	),
	retractall(recommend(_)),
	% this is for the AI
	retractall(ai(_)),
	% this is for the Data engineering
	retractall(de(_)),
	
	% this is for the information security
	retractall(is(_)),
	% this is for the mobile computing
	retractall(mc(_)),	
	clear.


%getting facts from the facts.txt in yes and no format
get_facts:-
%location for the facts.txt storing file
  open('/Users/abhinavsaurabh/Desktop/IIITD/Abhinav-MT20127/facts.txt', read, Str),
  read_file(Str,Lines),
  close(Str),
  facts(Lines).

% reading the facts converting them for the program interpretation.
facts([Head|Tail]):-
		((Head == end_of_file)
			->facts(Tail)
			;assert(Head), facts(Tail)
			).
facts([]).

advice('Machine Learning') :- ml,fail.
advice('Information Retrieval') :- ir,fail.
advice('Data Mining') :- dm,fail.
advice('Mobile Computing') :- mc,fail.
advice('Collaborative Filtering') :- cf, fail.
advice('Big Data Mining in Healthcare') :- bdmh,fail.
advice('Artificial Intelligence') :- ai,fail.
advice('Deep learning') :- dl,fail.
advice('Applied Cryptography') :- ac,fail.
advice('Advanced Machine Learning') :- aml,fail.
advice('Big Data Analytics') :- bda,fail.
advice('Distributed Systems Security') :- dss,fail.
advice('Embedded Systems') :- es,fail.
advice('Cellular Data Networks') :- cdn,fail.
advice('Network Security') :- ns,fail.
advice('Ad Hoc Wireless Networks') :- ahwn,fail.
advice('Secure Coding') :- sc,fail.
advice('No Elective recommendation available for you. !').


%analyzing preference and searching and attaching them.
preferences([Head|Tail]):- retract(recommend(Head)), preferences(Tail).
preferences([]).

show([Head|Tail]):-
	format('~n ~w',[Head]),show(Tail).

show([]).

isempty([]).


ml :-
	retract(ai(A)),
	assert(ai(A)),
	retract(de(D)),
	assert(de(D)),
	((A == yes ; D == yes)
		->true
		;fail
		),
	questioninterest('python'),
	questioninterest('programming'),
	assert(recommend('Machine Learning')).

ir :-
	retract(ai(A)),
	assert(ai(A)),
	retract(de(D)),
	assert(de(D)),
	((A == yes ; D == yes)
		->true
		;fail
		),
	questioninterest('python'),
	questioninterest('programming'),
	questioninterest('database'),
	questioninterest('advancedprogramming'),
	assert(recommend('Information Retrieval')).

dm :-
	retract(ai(A)),
	assert(ai(A)),
	retract(de(D)),
	assert(de(D)),
	((A == yes ; D == yes)
		->true
		;fail
		),
	questioninterest('python'),
	questioninterest('programming'),
	questioninterest('probability'),
	assert(recommend('Data Mining')).


mc :-
		retract(mc(M)),
		assert(mc(M)),

		(M == yes
			->true
			;fail
			),
		questioninterest('programming'),
		assert(recommend('Mobile Computing')).

cf :-
	retract(de(D)),
	assert(de(D)),
	( D == yes
		->true
		;fail
		),
	questioninterest('python'),
	questioninterest('programming'),
	questioninterest('ml'),
	assert(recommend('Collaborative Filtering')).

bdmh :-
	retract(ai(A)),
	assert(ai(A)),
	retract(de(D)),
	assert(de(D)),
	((A == yes ; D == yes)
		->true
		;fail
		),

	questioninterest('ml'),
	assert(recommend('Big Data in Healthcare')).

ai :-
	retract(ai(A)),
	assert(ai(A)),
	(A == yes
		->true
		;fail
		),

	assert(recommend('Artificial Intelligence')).




dl :-
	retract(ai(A)),
	assert(ai(A)),
	(A == yes
		->true
		;fail
		),

	questioninterest('ml'),
	assert(recommend('Deep Learning')).


ac :-
	retract(is(A)),
	assert(is(A)),
	(A == yes
		->true
		;fail
		),
	questioninterest('discreetmaths'),
	assert(recommend('Applied Cryptography')).

aml :-
	retract(ai(A)),
	assert(ai(A)),

	(A == yes
		->true
		;fail
		),

	questioninterest('ml'),
	assert(recommend('Advanced Machine Learning')).

bda :-
	retract(de(D)),
	assert(de(D)),
	( D == yes
		->true
		;fail
		),

		questioninterest('programming'),
		questioninterest('database'),
		assert(recommend('Big Data Analytics')).

dss :-
	retract(is(A)),
	assert(is(A)),
	retract(mc(D)),
	assert(mc(D)),
	((A == yes ; D == yes)
		->true
		;fail
		),
  questioninterest('cn'),
	assert(recommend('Distributed System Security')).

es :-
		retract(mc(D)),
		assert(mc(D)),
		(D == yes
			->true
			;fail
			),
		questioninterest('electronics'),
		assert(recommend('Embedded Systems')).

cdn :-
			retract(mc(D)),
			assert(mc(D)),
			( D == yes
				->true
				;fail
				),
		  questioninterest('cn'),
			assert(recommend('Cellular Data Networks')).

ns :-
				retract(is(A)),
				assert(is(A)),
				retract(mc(D)),
				assert(mc(D)),
				((A == yes ; D == yes)
					->true
					;fail
					),
			  questioninterest('cn'),
				assert(recommend('Network Security')).

ahwn :-
					retract(mc(D)),
					assert(mc(D)),
					(D == yes
						->true
						;fail
						),
				  questioninterest('cn'),
					assert(recommend('Ad Hoc Wireless Networks')).


sc :-
						retract(is(A)),
						assert(is(A)),

						(A == yes
							->true
							;fail
							),
					  questioninterest('cryptography'),
						assert(recommend('Secure Coding')).


questioninterest(In) :-
	(yes(In)
		->true
		;(no(In)
			->fail
			;ask(In))
	).

ask(Que) :-
	%asking question in yes format storing them
	format('~w ?',[Que]),
	read(Ans),
	%ans should be either in form of yes or y
	( (Ans == yes ; Ans == y)
		->assert(yes(Que))
		;assert(no(Que)), fail
		).

:- dynamic yes/1,no/1.


%to clear thing up.
clear :- retract(yes(_)),fail.
clear :- retract(no(_)),fail.
clear.


%for the file reading and stream required for that.
read_file(Stream,[]) :-
  at_end_of_stream(Stream).
read_file(Stream,[X|L]) :-
  \+ at_end_of_stream(Stream),
  read(Stream,X),
  read_file(Stream,L).


