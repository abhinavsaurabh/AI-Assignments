run:-
	write('Hello, Please answer these questions'),nl,

	retractall(recommend(_)),
	retractall(ai(_)),
	retractall(de(_)),
	retractall(is(_)),
	retractall(mc(_)),


	write('Are you interested in Artificial Intelligence?'),nl,
	read(AI),
	assert(ai(AI)),

	write('Are you interested in Data Engineering?'),nl,
	read(DE),
	assert(de(DE)),

	write('Are you interested in Information Security?'),nl,
	read(IS),
	assert(is(IS)),

	write('Are you interested in Mobile Computing?'),nl,
	read(MC),
	assert(mc(MC)),

	advice(_),
	preferences(List),nl,

	(isempty(List)
		->write('Sorry cannot recommend you anything' ),nl
		;write('Electives good for you are :'),show(List)
	),
	clear.

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
advice('Sorry, No Recommendation !').


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
	((A == y ; D == y)
		->true
		;fail
		),
	questioninterest('Do you know python ?'),
	questioninterest('Do you have basic programming skills ?'),
	assert(recommend('Machine Learning')).

ir :-
	retract(ai(A)),
	assert(ai(A)),
	retract(de(D)),
	assert(de(D)),
	((A == y ; D == y)
		->true
		;fail
		),
	questioninterest('Do you know python ?'),
	questioninterest('Do you have basic programming skills ?'),
	questioninterest('Have you done any Database Course'),
	questioninterest('Do you have advanced programming experience'),
	assert(recommend('Information Retrieval')).

dm :-
	retract(ai(A)),
	assert(ai(A)),
	retract(de(D)),
	assert(de(D)),
	((A == y ; D == y)
		->true
		;fail
		),
	questioninterest('Do you know python ?'),
	questioninterest('Do you have basic programming skills ?'),
	questioninterest('Have you done probability & stats'),
	assert(recommend('Data Mining')).


mc :-
		retract(mc(M)),
		assert(mc(M)),

		(M == y
			->true
			;fail
			),
		questioninterest('Do you have basic programming skills ?'),
		assert(recommend('Mobile Computing')).

cf :-
	retract(de(D)),
	assert(de(D)),
	( D == y
		->true
		;fail
		),
	questioninterest('Do you know python ?'),
	questioninterest('Do you have basic programming skills ?'),
	questioninterest('Do you know Machine Learning'),
	assert(recommend('Collaborative Filtering')).

bdmh :-
	retract(ai(A)),
	assert(ai(A)),
	retract(de(D)),
	assert(de(D)),
	((A == y ; D == y)
		->true
		;fail
		),

	questioninterest('Do you know Machine Learning'),
	assert(recommend('Big Data in Healthcare')).

ai :-
	retract(ai(A)),
	assert(ai(A)),
	(A == y
		->true
		;fail
		),

	assert(recommend('Artificial Intelligence')).




dl :-
	retract(ai(A)),
	assert(ai(A)),
	(A == y
		->true
		;fail
		),

	questioninterest('Do you know Machine Learning'),
	assert(recommend('Deep Learning')).


ac :-
	retract(is(A)),
	assert(is(A)),
	(A == y
		->true
		;fail
		),
	questioninterest('Do you know Discreet Maths'),
	assert(recommend('Applied Cryptography')).

aml :-
	retract(ai(A)),
	assert(ai(A)),

	(A == y
		->true
		;fail
		),

	questioninterest('Do you know Machine Learning'),
	assert(recommend('Advanced Machine Learning')).

bda :-
	retract(de(D)),
	assert(de(D)),
	( D == y
		->true
		;fail
		),

		questioninterest('Do you have basic programming skills ?'),
		questioninterest('Have you done any Database Course'),
		assert(recommend('Big Data Analytics')).

dss :-
	retract(is(A)),
	assert(is(A)),
	retract(mc(D)),
	assert(mc(D)),
	((A == y ; D == y)
		->true
		;fail
		),
  questioninterest('Do you know Computer Networks'),
	assert(recommend('Distributed System Security')).

es :-
		retract(mc(D)),
		assert(mc(D)),
		(D == y
			->true
			;fail
			),
		questioninterest('Do you know Basic Electronics'),
		assert(recommend('Embedded Systems')).

cdn :-
			retract(mc(D)),
			assert(mc(D)),
			( D == y
				->true
				;fail
				),
		  questioninterest('Do you know Computer Networks'),
			assert(recommend('Cellular Data Networks')).

ns :-
				retract(is(A)),
				assert(is(A)),
				retract(mc(D)),
				assert(mc(D)),
				((A == y ; D == y)
					->true
					;fail
					),
			  questioninterest('Do you know Computer Networks'),
				assert(recommend('Network Security')).

ahwn :-
					retract(mc(D)),
					assert(mc(D)),
					(D == y
						->true
						;fail
						),
				  questioninterest('Do you know Computer Networks'),
					assert(recommend('Ad Hoc Wireless Networks')).


sc :-
						retract(is(A)),
						assert(is(A)),

						(A == y
							->true
							;fail
							),
					  questioninterest('Do you know basic Cryptography'),
						assert(recommend('Secure Coding')).


questioninterest(In) :-
	(yes(In)
		->true
		;(no(In)
			->fail
			;ask(In))
	).

ask(Que) :-
	format('~w ?',[Que]),
	read(Ans),
	( (Ans == yes ; Ans == y)
		->assert(yes(Que))
		;assert(no(Que)), fail
		).

:- dynamic yes/1,no/1.


clear :- retract(yes(_)),fail.
clear :- retract(no(_)),fail.
clear.
