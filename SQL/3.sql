#introduction to the dataset#
SELECT * FROM facebook LIMIT 100;
SELECT AVG(converted)*100 FROM facebook ;
SELECT test_condition, COUNT(id) FROM facebook GROUP BY test_condition;
SELECT SUM(converted) FROM facebook;

#1-
SELECT test_condition, exposed, AVG(converted) as CR FROM facebook GROUP BY test_condition, exposed;

#2-
SELECT test_condition,  
		COUNT(age),
		MIN(age),
		MAX(age),
		AVG(age) ,
		STD(age) FROM facebook GROUP BY test_condition;
#create dummy coding for character variable female
SELECT test_condition,  
			COUNT(gender),
			MIN(gender='female'),
			MAX(gender='female'),
			AVG(gender='female') ,
			STD(gender='female') FROM facebook GROUP BY test_condition;
#for friends
SELECT test_condition,  
			COUNT(n_friends),
			MIN(n_friends),
			MAX(n_friends),
			AVG(n_friends) ,
			STD(n_friends) FROM facebook  group BY test_condition ;
#for those where test condition = test 
SELECT test_condition,  
		COUNT(age),
		MIN(age),
		MAX(age),
		AVG(age) ,
		STD(age) FROM facebook  WHERE test_condition = 'test' GROUP BY exposed ;
SELECT test_condition,  
			COUNT(gender),
			MIN(gender='female'),
			MAX(gender='female'),
			AVG(gender='female') ,
			STD(gender='female') FROM facebook WHERE test_condition = 'test' GROUP BY exposed ;
SELECT test_condition,  
			COUNT(n_friends),
			MIN(n_friends),
			MAX(n_friends),
			AVG(n_friends) ,
			STD(n_friends) FROM facebook WHERE test_condition = 'test' GROUP BY exposed ;


#question 3  fill the EVALUATING RTC table

SELECT test_condition,
			COUNT(id) AS N ,
			COUNT(id)/(SELECT COUNT(id)FROM facebook) AS perc 
			 FROM facebook GROUP BY test_condition;
			 
SELECT test_condition,AVG(converted) FROM facebook GROUP BY test_condition;

SELECT test_condition,exposed,COUNT(id) AS n , avg(converted) FROM facebook WHERE test_condition ='test' GROUP BY exposed;
#fro CR
SELECT exposed, AVG(converted) FROM facebook WHERE test_condition='test'GROUP BY exposed ; 

#the sum is 19966 , the perc is 2803/19966 , etc...


#question 4 -conclusion ad lift etc.

# itt = CRtest-CRcontrol =0.0186-0.0097=0.0089
# ICR=ITT/%exposed users =0.0089/0.1404=0.06339
# counterfactual CR = cr_exposed-irc=0.0246-0.06339 = -0.03879
# counterfactual CR =cr_unexposed
#lift on excel
#CR	0.0246		
#counterfactual	-0.03879	   (cr-counter)/counter *100=	-163%

##question 6
#FOR THE TEST GROUP ONLY
#ATT only for exposed/unexposed=CRexposed-CRunexposed=0.0246-0.0177=0.0069
#which is lower than the ICR

##standart deviation error
#number of obs 
SELECT exposed ,AVG(converted),STD(converted),COUNT(converted)
FROM facebook WHERE test_condition ='test' GROUP BY exposed ;
			 