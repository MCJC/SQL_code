/******************************************************************************************/
-- December 21
/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Question]

SET   Question_wording_std =
'Which comes closer to describing your view? Western music, movies, and television have hurt morality in our country, OR Western music, movies, and television have not hurt morality in our country.'
WHERE Question_pk =
595

UPDATE     [forum].[dbo].[Pew_Question]

SET   Question_short_wording_std =
'Have Western music, movies, and television hurt morality in the country?'
WHERE Question_pk =
595

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Question]

SET   Question_short_wording_std =
'How concerned are you about extremist religious groups in the country?'
WHERE Question_pk =
606

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]   -- it wasn't neccessary to update...

SET   Answer_wording =
'The constitution or basic law does not specifically provide for freedom of religion but does protect some religious practices'
WHERE Answer_pk      IN 
(
2999, 
3220, 
2708, 
7013, 
3666 
)

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]

SET   answer_wording_std =
'Yes'
WHERE Answer_pk      IN 
(
7869 
)

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]
-- my error
SET   answer_wording_std =
NULL
WHERE Answer_pk      IN 
(
989 
)

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]

SET   answer_wording_std =
'Yes'
WHERE Answer_pk      IN 
(
4036, 
13663 
)


/******************************************************************************************/
-- December 26
/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]

SET   answer_wording_std = RTRIM(LTRIM(answer_wording_std))
/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]

SET   answer_wording_std =
'Yes, but their activity was limited to recruitment and fundraising'
WHERE Answer_pk      IN 
(
2977,
3198,
3419,
4087
)


/******************************************************************************************/



