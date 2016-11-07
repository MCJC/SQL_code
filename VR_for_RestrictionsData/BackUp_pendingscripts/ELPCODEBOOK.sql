/***************************************************************************************************************************************************************/
--Print 
--'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 015    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to                                                                                                                  ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [GRSHRcode]
GO
/***************************************************************************************************************************************************************/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER  VIEW                      [dbo].[vr___00codebook_]        AS
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*
SELECT 
  [Question_abbreviation_std]
 ,[Question_wording_std]
  FROM [GRSHRcode].[dbo].[All_Questions]  Q
*/

-----



WITH CTE AS 
(

SELECT 
 [Q] = 'GRI_01_x'
,[B] =
'
Country


Coding Year(s)
2015
Coder Name

Date(s) Coded (MM/DD/YYY)

Coder A or B?


Start/End time 
(HH:MM)


General Notes

•	Remember to check all sources for each country 
•	Note: Some SHI questions include data from previous years – IRF reports 2013, 2014, & 2015. This is discussed in the notes for the specific questions. Let Katayoun or Samirah know if there are questions.
•	Actions of public school officials are included as government actions. Actions attributed to “traditional or tribal leaders or chiefs or councils” could be social or governmental in nature. Clues to determine which is the case (or if they represent both) include whether the incident is reported in the government or social section of the IRF report, and/or whether the leaders/chiefs/councils have powers associated with governments, e.g., taxation or the creation and enforcement of laws. You may find this by looking at past IRF or Human Rights reports. 
•	We generally treat witchcraft as a religious practice, and those who practice it as members of a religious group, though witchcraft practitioners tend to operate more as shamans.
•	Also, actions of semi-official or un-official militia or policing units that operate with some tangible government support or authorization could be coded in various questions as either social and government actions or both; however, when you count abuses, generally count as social unless it is clear that the militia or policing units are taking direct orders from the government or are fully funded by the government. 
•	There may be cases where different abuses by the same group are coded as government or social depending on the context and involvement of the government. Never double count incidents, but some cases might count as social and government abuses, e.g., Saudi Mutawa. Let Katayoun or Samirah know if there are questions.

Do not change your Coder A or B scores in this document after you reconcile. Keep your original score as part of the record, and enter in the reconciled score.



Government Restrictions

'
,[A] =
'
•	See CIA Factbook for amendments; check whether these included religion provisions.
'
UNION
ALL
SELECT
[Q] = 'GRI_01'
,[B] =
''
,[A] =
'
Notes:
•	Consult the State Dept. IRF report.
•	If a change is found, ask Katayoun or Samirah about checking it against the constitution excel database. 
*Article 18 states: “Everyone has the right to freedom of thought, conscience and religion; this right includes freedom to change his religion or belief, and freedom, either alone or in community with others and in public or private, to manifest his religion or belief in teaching, practice, worship and observance.”
** E.g.: religious rites, worship or belief, each of which is less comprehensive than freedom of religion

'

UNION
ALL
SELECT
[Q] = 'GRI_02'
,[B] =
''
,[A] =
'
Notes:
•	If GRI_1 = 0, then GRI_2 could be 0, 0.33 or 0.67
•	If GRI_1 = 0.50, then GRI_2 is 0.67.
•	If GRI_1 = 1.00, then GRI_2 is 1.00.
•	If the only stipulation is for a monarch’s faith then code as a qualification; if more stipulations, then a contradiction. 
•	Limits on “unsolicited intervention” (proselytizing) are considered a contradiction.
•	Religious law provision is a contradiction only if it is the law of the land.

*Qualification means that religious freedom is provided, but some limit is set, such as freedom as long as there is ‘public order’. Only referring to religion articles in constitutions, not general freedom of rights, such as freedom of speech or assembly. 
**Contradiction means that religious freedom is provided, but that for some people and/or in some circumstances, freedom to choose, convert or proselytize is not available for all people equally; or if law cannot contradict the precepts of one religion.
'

UNION
ALL
SELECT
[Q] = 'GRI_03'
,[B] =
''
,[A] =
'
Notes:
* IRF Report often uses “generally respects” without any qualifications; however, take into account whether there are some instances where the government does not respect this right before assigning “0”.
** IRF often adds “however” or “but” after the phrase “generally respects” and/or there are numerous problems in “Restrictions” section of IRF that fall short of not providing general protections. (Check with Katayoun or Samirah if there seems to be many problems even if the IRF states that the “government generally respects” religious freedom.) If the legal framework section says the government provides for religious freedom, but restrictions and abuses are mentioned in the IRF, then it should be at least a 0.33.
*** limited and/or rights not protected, or largely restricted
**** religious freedom does not exist

• Scores for GRI-03 should be coded based on coders’ overall impression of the laws and policies, not just based on IRF summary sentences.  
If the IRF report says there is religious freedom, but the government formally bans some religious groups, this may justify coding as “0.67”, but check with Katayoun or Samirah if that is the only justification for a “0.67”.
'

UNION
ALL
SELECT
[Q] = 'GRI_20_01'
,[B] =
''
,[A] =
'
Notes:
•	Check Constitution and IRF Report.
•	Code “Yes” if the constitution mentions that the government favors or particularly protects any specific religion’s practices or beliefs, e.g., Islamic law or courts, or Christian or Buddhist principles.
•	The intent of this variable is somewhat broader than capturing whether there is a “state” or “established” religion(s) or one that function in a similar capacity.
•	If there is a national ideology or personality cult around the country’s leader, check with Katayoun or Samirah whether this might be considered a religion. 
If yes to GRI_20_1, list the religion(s) that are recognized as a favored religion by the constitution or law that functions in the place of constitution: [0= No; 1= Yes]
'

UNION
ALL
SELECT
[Q] = 'GRI_20_01_x_01'
,[B] =
''
,[A] =
'
Notes:
•	No official religion: This category includes states that are hostile toward certain religions or all religion, have strict control over religious institutions and practice, or are generally hostile to non-state organizations including religious institutions.
•	Separation of church and state: This category includes states that separate church and state, whether that relationship is neutral, slightly hostile toward religion, or supports all religions more or less equally. These states have no official/preferred religion.
•	Preferred or approved religion(s):  This category includes states that provide certain benefits to one or multiple religions, or have an unofficial preferred religion.
•	One official religion: This category includes states that have one official religion, whether it is not mandatory, mandatory for some, or mandatory for all.
'

UNION
ALL
SELECT
[Q] = 'GRI_20_02'
,[B] =
''
,[A] =
'
Notes:
•	Privileges or government access would include agreements with the Vatican, special access to hospitals or other government institutions, as well as government funding that largely goes to one religion. 
•	Code different denominations and/or sects as separate religious groups.
•	If the state religion does not have to register but all others do, this would count as privileges or government access unavailable to other religious groups.
'

UNION
ALL
SELECT
[Q] = 'GRI_20_03_a'
,[B] =
'
GRI_20_03_a-c
Does any level of government provide funds or other resources for __________?
[indicate all that apply below]
'
,[A] =
''

UNION
ALL
SELECT
[Q] = 'GRI_20_03_c_xx'
,[B] =
''
,[A] =
'
Notes:
*School prayers or religious symbols in a school are not alone sufficient evidence of funding for religious education/schools.
** This can include properties designated for religious education; but funding public schools that provide religious education is not sufficient to code > 0.
*** Other activities include media, public service, worship or religious practices, payments of religious leaders’ wages, benefits, etc.

•	Check religious demography section of the IRF report to see if there are any religious groups that are being omitted from funds or resources provided.
•	Funding can be implied by level of government support for a particular religion, or tax exemption tied to registration that generally does not discriminate based on religious belief or association, but results in some religions not registering for reasons of practicality or conscience.
•	Favoritism in government funding of a religion or religions is when preferential treatment of one or more religious groups puts other religious groups at a disadvantage.
•	“No obvious favoritism” may be a proportional balance in funding according to the size of each religious community in a country; however, there should be a clear mechanism for or commitment to assuring a proportional balance of funding to code as no obvious favoritism.
•	Code different denominations and/or sects as separate religious groups.
•	Funding can include subsidies or in-kind provisions such as land or property, i.e., tangible support that probably includes funding. Included in ‘in kind’ are subsidies to organizations run by religions, e.g., hospitals, schools, allocating state media access, etc.
•	Training of clergy is considered religious education.
'

UNION
ALL
SELECT
[Q] = 'GRI_20_04'
,[B] =
''
,[A] =
'
Notes:
•	Religious education is required if there are extra measures to withdraw from the religious classes i.e. waivers or parental permission.
•	If the federal or national government is involved in regulating how religious education is carried out, code as 1.00.
'

UNION
ALL

SELECT
[Q] = 'GRI_20_05'
,[B] =
''
,[A] =
'
Notes:
•	Non-binding government discussion with religious groups on policy issues isn’t strong enough to code as “yes”; government must defer to the religious group(s).
•	Also code “yes” if the government looks to a religion or religions to manage some public issue for all citizens, such as registration of births and deaths or cemeteries.
•	“Traditional” courts should not be taken as a synonym for “religious” unless the sources specifically equate the two.
'

UNION
ALL
SELECT
[Q] = 'GRI_20_05_x'
,[B] =
''
,[A] =
'
Notes:
•	Code “some province” if there is Shari’a law present in only some provinces or localities 
•	Code “whole country” if the country allows Islamic Shari’a law to be practiced generally throughout the country (e.g., by choice by Muslims). 
'

UNION
ALL
SELECT
[Q] = 'GRI_10'
,[B] =
''
,[A] =
'
If yes, indicate types of restrictions below:
'

UNION
ALL
SELECT
[Q] = 'GRI_10_03'
,[B] =
''
,[A] =
'
Notes:
•	Code for each component variable.
•	Public schools are included in any level of government. 
•	Other religiously-worn symbols include such things as a cross, turbans, chastity rings, etc.
•	GRI_10.x3 – Code this variable (“Other religiously-worn symbols”) if the government regulates forms of dress other than or in addition to head coverings for women and facial hair for men 
'

UNION
ALL
SELECT
[Q] = 'GRI_05'
,[B] =
''
,[A] =
'
Notes:

*It must be clear that the activity is public preaching as opposed to private religious education, for instance. This may include withholding permits or licenses for public events that include preaching, such as religious services.

•	Look for mentions of preaching, sermons, or speaking from a pulpit. Also, if sermon topics have to be approved by the government or if religious leaders self-censor in response to perceived government wishes, code as limitation on preaching.
•	If restrictions on information displays exist, count as a limit on preaching.
'

UNION
ALL
SELECT
[Q] = 'GRI_06'
,[B] =
''
,[A] =
'
Notes:

*An effort by religious groups or individuals to persuade others to join their faith.
**This may include withholding permits or licenses for public proselytizing events.

•	Limitations include self-imposed limits by religious groups in response to perceived government wishes
•	Limitations on discussions of faith through media does not necessarily indicate a restriction on proselytizing. 
•	If the report mentions some criteria for regulating proselytizing, code at least 0.50.
'

UNION
ALL
SELECT
[Q] = 'GRI_08'
,[B] =
''
,[A] =
'
Notes:

*Internet is considered broadcasting. 

•	This may include withholding permits or licenses. Code “yes” if religious groups are excluded from media access. Limits on sermons/prayers over loudspeakers are not limits on broadcasting.
•	If restrictions exist on information displays, count as limits on literature or broadcasting.
•	If a source says that there is no freedom of the press or that it is severely restricted, and there is no indication that religious media are exempt from the restriction, then code “0.50.”
'

UNION
ALL
SELECT
[Q] = 'GRI_09'
,[B] =
''
,[A] =
'
Notes:

*Restrictions include problems entering the country, e.g., visa quotas. (A restriction on missionaries does not automatically mean that proselytizing is limited.)

•	If there are restrictions on foreign aid workers, and this affects aid workers clearly representing religious organizations, count as a restriction on missionary work.
•	If missionaries can only work in a country in an unofficial capacity, this implies they are not allowed to work in the country.
•	If governmental officials or government-tied tied religious leaders must approve foreign preachers, this counts as a restriction on missionaries.
'

UNION
ALL
SELECT
[Q] = 'GRI_07'
,[B] =
''
,[A] =
'
Notes:
•	Do not code “yes” if the only evidence is a banned religion. 
•	However, code as a limitation if any converts or persons attempting to convert were abused, detained, etc.
'

UNION
ALL
SELECT
[Q] = 'GRI_04'
,[B] =
''
,[A] =
'
Notes:

*“Few” means only one or two isolated situations
** “Many” means more than two situations or one situation that affects many congregations or groups but falls short of a general government policy prohibiting the worship or religious practices of one or more religious groups

•	Worship includes meeting with others to pray, hear preaching or conduct religious rituals. Religious practices include activities such as conscientious objection to military service, religious attire or grooming, use of certain substances in worship such as peyote, how to treat human remains for burial, and other rituals that may not be specifically tied to worship.
•	If there are complaints about government education facilities holding classes on certain religious groups’ holy days but not others, and a religious group is upset at the government, this counts as interfering with worship. It would be many cases if the problems seem to affect many groups, but a “few” if it seems to be a minor inconvenience.
•	Count as at least 0.67 if religious slaughter is banned 
'

UNION
ALL
SELECT
[Q] = 'GRI_18'
,[B] =
''
,[A] =
'
Notes:

*Code 0.33 if a government asks but does not require a religious group to register for some kind of benefit, unless there is evidence of adverse effects or discrimination.
** Code 0.67 if there are bureaucratic problems with registering religious groups.
*** Code 1.00 if there religious groups are singled out, for instance, by repeatedly being denied registration or having to receive acceptance from other groups. Also code 1if the govt. requires a certain number of adherents or approval of the theology or practices of the group.

•	Code 1.00 if registration guidelines only go into effect for groups of a certain size.
•	If government will register only groups that do not contravene religious law, count this as discriminatory registration.
'

UNION
ALL
SELECT
[Q] = 'GRI_16'
,[B] =
''
,[A] =
'
Notes:

*At least one of the sources should specifically use the word ban. If a report mentions a group being “criminalized”, or other strong language suggesting a ban, check with Katayoun or Samirah. 
**Include political parties banned for their religious tenets.

•	If a group is made illegal, count as a ban
'

UNION
ALL
SELECT
[Q] = 'GRI_15'
,[B] =
''
,[A] =
'
Notes:

•	The sources note that the government specifically uses the terminology “cults” and “sects” to denounce religious groups.
•	If a prominent national government leader publically denounces one or more religious groups by characterizing them as dangerous “cults” or “sects”, code “Yes”, even if it is not official government policy to denounce the group.
•	Count if a group is denounced as deviant.
'

UNION
ALL
SELECT
[Q] = 'GRI_11'
,[B] =
''
,[A] =
'
Notes:
*A government offense against a religious group or a person due to his/her religious identity, including physical coercion or merely being singled out with the intent of making life or religious practice more difficult. Similarly, negative public government comments or characterizations about religious constitute harassment. Also, count as harassment government policies that specifically have an adverse effect on particular religious groups.
** “Limited” means infrequent or isolated and indicates that the harassment seems unlikely to continue.
*** “Widespread” does not necessarily mean the whole country, but it could be present in certain regions, have potential of spreading to other regions, affect several groups, or indicate a possible campaign against a certain religion(s) or practices.


•	Count education discrimination as harassment.
•	If a ban on a group results in dismissal from government, employment, count as widespread harassment.
•	Count as harassment if an incident in a prior coding period indicates ongoing trends as opposed to an isolated incident.
•	Count as at least 0.50 if  the government regulates head coverings for women 
'

UNION
ALL
SELECT
[Q] = 'GRI_11_01a'
,[B] =
'
If yes, which groups?
'
,[A] =
''

UNION
ALL
SELECT
[Q] = 'GRI_17'
,[B] =
''
,[A] =
'
Notes:

•	Also code “yes” if there are totalitarian or authoritarian actions by the federal government to control religious belief or practice or systematic repression of a religious group.
•	Religious groups include religion related groups that may be accused of terror, if there is some doubt that they are primarily a terror organization.  
'

UNION
ALL
SELECT
[Q] = 'GRI_12'
,[B] =
''
,[A] =
'
Notes: 

•	Code if “hostile” or “hostility” is used in the sources or if there is physical abuse, displacement, detention, killing or property destruction or defacement.
'

UNION
ALL
SELECT
[Q] = 'GRI_13'
,[B] =
''
,[A] =
'
Notes: 

•	Must have evidence of neglect, i.e., if there is federal government inaction in the face of abuses.
'

UNION
ALL
SELECT
[Q] = 'GRI_14'
,[B] =
''
,[A] =
'
Notes:
•	The organization must be created to specifically deal with religious affairs, including umbrella organizations.
•	Consider coercive if heavy-handed, such as repeatedly refusing to register an organization. (Having the power to refuse a registration is not necessarily coercion.)
•	A political party tied to the state with coercive power over religious groups counts as a governmental body.
•	For it to be considered a government body, must show signs that the government has some control over it or its members, set it up as a body to report to the government, or receive some form of government funding
•	Sometimes this information is not clear from the sources. Google to see if the country has an organization, and then try to find evidence of the organization in the sources. If it is still not in the source list, let Katayoun or Samirah know the Googled source to see if it can be submitted as a supplemental source.
'

UNION
ALL
SELECT
[Q] = 'GRX_22_01'
,[B] =
'GRX_22 Does any level of government penalize the defamation of religion, including penalizing such things as blasphemy, apostasy, and criticisms or critiques of a religion or religions? 
  0    = No 
  0.33 = No, but such a policy is being considered.
  0.67 = Yes, but penalties are not enforced.
  1.00 = Yes, and penalties are enforced.


Notes: 
•	Blasphemy – remarks or actions considered to be contemptuous of God or the divine
•	Apostasy – abandoning one’s faith
•	Hate Speech – disparagement of the members of religious groups 
•	Criticism/Critique - disparagement or criticism of particular religions or religion in general
'
,[A] =
''

UNION
ALL
SELECT
[Q] = 'GRX_22_x_01'
,[B] =
'GRX_22_x Does any level of government penalize the defamation of religion, including penalizing such things as blasphemy, apostasy, and criticisms or critiques of the official or preferred state religion specifically? 
 
  0    = No 
  0.33 = No, but such a policy is being considered.
  0.67 = Yes, but penalties are not enforced.
  1.00 = Yes, and penalties are enforced.
'
,[A] =
''

UNION
ALL
SELECT
[Q] = 'GRX_29_01'
,[B] =
''
,[A] =
'
If yes, indicate types of initiatives or actions below:
'

UNION
ALL
SELECT
[Q] = 'GRX_29_03'
,[B] =
''
,[A] =
'
•	Policies or actions to combat or redress discrimination include such things as: changes to basic laws; establishment of governmental mechanisms to address religious tensions or grievances; official recognition of religious groups that previously found themselves in legal limbo; freeing prisoners held for religious reasons; protecting those in danger of persecution; and partnering with groups in society to address religious hatred and prejudice, etc.
'

UNION
ALL
SELECT
[Q] = 'GRX_30'
,[B] =
''
,[A] =
'
Notes:
•	Police must be part of the government – with funding or authorization.
•	The police force must be specifically aiming to enforce the religious norms of society or of a particular religious group, not merely harass a particular religious group or enforce laws that aim to control a particular religion.
'

UNION
ALL
SELECT
[Q] = 'GRX_31'
,[B] =
''
,[A] =
'
Notes:
This can take a variety of forms:
•	Requiring individuals to list a religion on government-issued identification, without providing for the option of “none” or the equivalent. 
•	Requiring individuals to contribute money to religious groups, either directly or indirectly through tax-payer funding of religious groups with no means for exemptions. 
•	Requiring individuals to follow religious norms, such as observance of religious holidays, norms involving inter-gender relations, or “blue laws” governing the sale of alcohol. 
•	Individuals facing penalties from government actors (whether or not they involve legal means) for refusing to adhere to a religious tradition or not participating in religious activities  
•	Individuals reporting being unwilling to express their agnosticism, atheism, or rejection of organized religion due to potential penalties or harassment from government actors
•	Do not coder verbal or physical abuse in this question, this is coded as harassment.
•	If you encounter situations not listed here that may be relevant, talk to Katayoun or Samirah.
'

UNION
ALL
SELECT
[Q] = 'GRX_32'
,[B] =
''
,[A] =
'
Notes:
•	The harassment must be for specifically this reason, not because the individual is of a different religious group than the government or government agents. For example, a government agent in a majority-Orthodox Christian country harassing a Protestant Christian for not worshiping in the Orthodox Christian style would not be coded here. The same government agent harassing a Protestant Christian who chose not to participate in any worship services, however, would be counted here.
'

UNION
ALL
SELECT
[Q] = 'GRX_36'
,[B] =
''
,[A] =
'
Notes:
•	Exemptions refer to religious groups that oppose war or national service being allowed to not participate in military training or activities. 
•	This includes both the lack of legal exemptions and government action against religious individuals who act contrary to these laws
'

UNION
ALL
SELECT
[Q] = 'GRI_19_filter'
,[B] =
''
,[A] =
'
GRI_19
Count and paste documentation for the number of people who, due to religion, were/had ______ by any level of government action or policy in this country from January 1, 2015 through December 31, 2015

•	Enter the number of incidents in each category 
-	0
-	1 – N = 1+ cases or events were found (enter the number)
•	Count if attack occurred in religious places of worship or targeted religious people/buildings.  
•	Record actual number; however, if source gives an estimate, use the lowest value of estimate.
•	Don’t count force used against those clearly intending to do malicious harm.
•	One person may suffer more than one problem in the course of an incident but if abuse results in immediate death, code for death only. 
•	If an unconfirmed report has details on the abuses such as location, perpetrators, victims, or type of abuse, these can be counted in the numeric count.  Less specific unconfirmed reports can still inform general coding. 
•	Punishment due to religious law recognized by the government that is considered “extreme” will be coded as abuse, and people awaiting such punishment will be considered detained. “Extreme” mean that the punishment is disproportionate (far too severe) for the crime.
•	If educational discrimination forced individuals to relocate, count as displacement.
•	We count self-immolations only under SHI, not GRI. But if the government arrests people related to self-immolations, that would count under GRI-19
'

UNION
ALL
SELECT
[Q] = 'GRI_19_b'
,[B] =
''
,[A] =
'
•	We count unresolved property restitution cases under GRI_19.b Personal or religious properties damaged or destroyed.  In some countries there are thousands of cases, so rather than count them in the 1000s, we use the following scheme:
-	0=0 (and there are no data about this)
-	0=0 (but there is evidence of cer incidents)
-	1= one unresolved property restitution case
-	2= less than 100 unresolved property restitution cases
-	3= 100 or more unresolved property restitution cases
•	If people are prevented from attending worship, this is counted under property damaged or destroyed.
'

UNION
ALL
SELECT
[Q] = 'GRI_19_c'
,[B] =
''
,[A] =
'
•	For arrests, convictions and sentencings, count as imprisoned.
•	If  people are detained even for a short time, we count this as detained/imprisoned (For example if women in France are briefly detained for violating the law banning burqas, count as detained)
NOTES CONTINUE ON NEXT PAGE!
•	If the sources indicate that the government has wrongly imprisoned members of religious groups on trumped up or questionable terrorism charges, then those imprisonments could be coded as part of government imprisonments (GRI_19.c); legitimate imprisonment for harmful criminal offences do not count as religion related imprisonment.
'

UNION
ALL
SELECT
[Q] = 'SHI_01_a'
,[B] =
'

Social Hostilities

'
,[A] =
'
Notes:
•	Also specify which groups were harassed (next page).
•	“Limited” means infrequent or isolated and indicates that the harassment seems unlikely to continue.
•	“Widespread” does not necessarily mean the whole country, but it could be present in certain regions, have potential of spreading to other regions, affect several groups, or indicate a possible campaign against a certain religion(s) or practices.
•	Note: Unlike negative public comments by governments, public preaching that is negative or intolerant toward a particular religious group or the making of negative comments or characterizations in the public media do not automatically constitute social harassment – they might. But for such speech to count as harassment, it must be evident that it results in the groups or individuals feeling harassed or being tangibly and adversely impacted by that speech.

*Harassment is any offense mentioned in the sources against a group or person related to their religious identity. An “offense” can range from direct physical coercion to being singled out with the intent of making life or religious practice more difficult. Also, the coding specifies that groups or members have to feel harassed. For instance, if a report only mentions that prejudicial attitudes are held by people in society, this alone would not be coded as harassment. However, prejudices that are acted upon (i.e., discrimination) would be coded as harassment.
•	SHI_01_a – Evidence of “widespread social harassment” is if the number of cases is substantial (e.g., hundreds) and spread throughout the country (e.g., occurring in more than 25% of provinces); evidence may also include a substantial uptick (e.g., a rise of 50% or more) in the number of cases of abuse reported toward a particular religious group 
•	Count as harassment if an incident in a prior coding period indicates ongoing trends as opposed to an isolated incident.
'

UNION
ALL
SELECT
[Q] = 'SHI_01_x_01a'
,[B] =
'If yes, which groups?'
,[A] =
''

UNION
ALL
SELECT
 [Q] = 'SHI_01_b'
,[B] =
'
SHI_01_b-f
Count and paste documentation for the number of people who, due to religion, were/had ______ by nongovernment actors in this country from January 1, 2015 through December 31, 2015

Notes:
•	Enter the number of incidents in each category. 
o	0= No (and there are no data about this incident)
o	0= No (but there is evidence of no incidents)
o	1 – N = 1+ cases or events were found
•	
•	Be sure to include text describing incidents.
•	If an unconfirmed report has details on the abuses such as location, perpetrators, victims, or type of abuse, these can be counted. Less specific unconfirmed reports can still inform general coding.
•	Count for abuses, defacement, or killed if attack occurred in religious places of worship or targeted religious people or buildings.  
•	Count religion-related suicide (including self-immolation) as a social death.
•	For convictions and sentencing, count as imprisoned.
•	If people are prevented from attending worship, this is counted under property damaged or destroyed.
'
,[A] =
''

UNION
ALL
SELECT
 [Q] = 'SHI_02_01'
,[B] =
''
,[A] =
'
Notes:
•	Only SHI_2 is included in the index.
•	The sources specifically use the terminology “ethnic cleansing” and “genocide”.
'

UNION
ALL
SELECT
 [Q] = 'SHI_03'
,[B] =
''
,[A] =
'
Notes:
•	Sectarian or communal violence involves two or more religious groups facing off in repeated clashes.
•	If communal violence in an earlier period shows signs of continuing to flare up, count here.
o	SHI_03 (sectarian/communal violence) has a much higher bar for making sure that there are clearly different religious groups squaring off in violent incidents against each other. Of course, in a given year, there may be just a few incidents of isolated acts of violence between, e.g., Catholics and Protestants in Northern Ireland, but it is part of a long-term conflict, so it would count. In France, the violent conflict would need to be clearly between, e.g., Muslims and Catholics to be counted (e.g., mob violence occurring now in reaction to the Burqa ban would not count as sectarian conflict). 
'

UNION
ALL
SELECT
 [Q] = 'SHI_04_filter'
,[B] =
''
,[A] =
'
Notes:
•	Look for incidents:
-	0                  = No (not mentioned in the sources)
-	0                  = No (specifically mentioned in the sources)
-	0.25               = Yes, but their activity was limited to recruitment and fundraising
-	0.50   - or higher = Yes, and their activities included violence
•	Code "0.50   - or higher - Yes, and their activities included violence", if IRF section is titled “Abuses by Terrorist Organizations” even if it does not mention the name of a terrorist group.  
•	Terrorist groups must be recognized as such by a US government source or included in the State Department’s “Country Reports on Terrorism”.
•	Religion-related terrorism is defined as politically motivated violence against noncombatants by sub-national groups or clandestine agents with a religious justification, intent or target. At times, terrorist groups might not have explicit religious motivations but simply target religious people or groups. 
'

UNION
ALL
SELECT
 [Q] = 'SHI_04_b'
,[B] =
'
SHI_04_b-f Count and paste documentation for the number of people who, due to religion-related terrorism, were ______ from January 1 until December 31. 
Notes:
•	Enter the number of incidents in each category.
-	0
-	1 – N = 1+ cases or events were found (enter the number)
•	Be sure to include text describing the incidents.
•	Only count incidents that are clearly carried out by groups considered terrorist groups by US government sources; all other social abuses are counted under SHI_1. 
•	Estimates are based on all sources available.
•	Actual number, or if the source gave an estimated range, the lowest value of the estimate.
•	For terrorist attacks occurring the context of a religion-related war, count as both but do not double-count specific incidents.
•	If the sources characterize an act as terror, then count it as such, even if the group is not on the terror list. We count lone wolf attacks as terror. For instance, we will count the Boston marathon bombing as such.
•	For armed conflicts where one side is a terrorist entity, but which otherwise count as war under our definition, count aggregate casualty numbers and specific acts of war as war (SHI_05) but individual instances of terrorism as terror (SHI_04). This does not mean that all acts of violence by a terrorist group must be counted under SHI_04; include only incidents that fall under our definition of terrorism (see previous question for a definition). If a group''s actions would fall under other questions (like SHI_07) then they can count there as well. Specific incidents that are part of the war, like drone strikes, would still be counted under SHI_05."
'
,[A] =
''

UNION
ALL
SELECT
 [Q] = 'SHI_04_c'
,[B] =
''
,[A] =
'
•	In “imprisoned or detained”, only count people abducted or imprisoned by terrorist groups. Do not code if the government has imprisoned religion-related terrorists; however, if the sources indicate that the government has wrongly imprisoned members of religious groups on trumped up or questionable terrorism charges, then those imprisonments could be coded as part of government imprisonments (GRI_19_c)
'

UNION
ALL
SELECT
 [Q] = 'SHI_04_d'
,[B] =
''
,[A] =
'
Notes:
•	SHI_04_d, SHI_04_d_x_1 and SHI_04_d_x_2 answer the same question: Did religion-related terrorism contribute to individuals being displaced from their homes? See coding procedure for SHI_04_d_x_1.
'

UNION
ALL
SELECT
 [Q] = 'SHI_04_d_x_2'
,[B] =
''
,[A] =
'

FOR SHI_04_d_x_1 and SHI_04_d_x_2 ONLY:
•	If religion-related terrorism (SHI_04=1) did not occur in the past five years, code displacement as 0. 
o	Consult the “SHI_04 and SHI_05” Excel file to see if country experienced terrorism/conflict in the past 5 years.
•	If religion-related terrorism did occur, use UNHCR and IDMC datasets. 
o	UNHCR data: Using the UNHCR Excel file, find your country and record the number under the highlighted “Difference” column. If the number is less than 0, code as 0. If the country has “-“ listed, then code as missing: "0 - No (not mentioned in the sources)".
o	IDMC data: Identify and record the total newly displaced population for the country in the coding year using the IDMC Excel file. If the country is not listed, code as 0. If the country is listed but with no information, code as missing: "0 - No (not mentioned in the sources)".
o	In cases where a country experienced both religion-related terrorism and conflict, divide the total displacement number by 2 for SHI_04_d and SHI_05_d. 
'

UNION
ALL
SELECT
 [Q] = 'SHI_04_e'
,[B] =
''
,[A] =
'
•	Direct coercion, short of physical contact, involving a lethal weapon is coded as “injured or accosted”.
'

UNION
ALL
SELECT
 [Q] = 'SHI_04_f_x_01a'
,[B] =
'
SHI_04_f_x_01a-17
What was the religion of the victim(s) (check all that apply)

'
,[A] =
''

UNION
ALL
SELECT
 [Q] = 'SHI_05_filter'
,[B] =
''
,[A] =
'
Coding Procedure:

1) Visit the Uppsala Armed Conflict Database and identify the dyads involving the country’s government in the coding year.
2) Do the total number of deaths occurring from all dyads involving the government sum to 1,000 or greater?
	If yes: code as conflict and note the number of deaths in SHI_05_f.
3) If no: was the total number of deaths in the coding year greater than or equal to 100?
	If yes: Did the previous two years also have 100 or more deaths in each year?
		If yes: Code as conflict and note the number of deaths in SHI_05_f.
If no: Do not code as conflict. SHI_05 should equal 0. 
-	0     = No (not mentioned in the sources)
-	0     = No (specifically mentioned in the sources)
-	1 – N = 1+ cases or events were found (specify the number in the text box)
All sub-variables (except SHI_05_d) get automatically coded as 0. See Katayoun or Samirah if you think there is a case where one of these variables should be coded as non-zero but there was no conflict that year.)

Notes:
•	Religion-related war is defined as armed conflict (involving sustained casualties over time [see above] or more than 1,000 battle deaths where at least one party is the government of the state) in which religious rhetoric is commonly employed to justify the use of force, or in which one or more of the combatants primarily identifies itself or the other side by religion. Conflicts occurring along a religious cleavage, even if religion is not driving the conflict, are counted as religion-related war.
•	Conflicts require at least 100 battle deaths in the coding year and each of the two previous years to be considered as having “sustained deaths over time”
•	Code for religion-related war, religious revolution, or religious conflict if sources state that religious and ethnic identities are closely related.
•	Count ongoing displacements from previous wars.
•	For the Occupied Territories, count actions between Israelis and Palestinians as religion-related war. Actions by the Palestinians, however, would fall under government or social abuses.
•	For terrorist attacks occurring in the context of a religion-related war, count as both but do not double-count specific incidents.
•	For convictions and sentencing, count as imprisoned.
'


UNION
ALL
SELECT
 [Q] = 'SHI_05_d_x_2'
,[B] =
''
,[A] =
'
Notes:
•	SHI_05_d, SHI_05_d_x_1 and SHI_05_d_x_2 answer this question: Did religion-related war or armed conflict contribute to individuals being displaced from their homes? 
•	If religion-related conflict did not occur in the past five years, code displacement as ""0. 
•	If religion-related conflict did occur, use UNHCR and IDMC datasets. 
o	UNHCR data: Using the UNHCR Excel file, find your country and record the number under the highlighted “Difference” column. If the number is less than 0, code as 0. If the country has “-“ listed, then code as missing: "0.00 - No (not mentioned in the sources)".
o	IDMC data: Identify and record the total newly displaced population for the country in the coding year using the IDMC Excel file. If the country is not listed, code as 0. If the country is listed but with no information, code as missing: "0.00 - No (not mentioned in the sources)".
o	In cases where a country experienced both religion-related terrorism and conflict, divide the total displacement number by 2 for:
♣	 SHI_04_d and SHI_05_d
♣	 SHI_04_d_x_1 and SHI_05_d_x_1
♣	 SHI_04_d_x_2 and SHI_05_d_x_2
'

UNION
ALL
SELECT
 [Q] = 'SHI_05_01'
,[B] =
''
,[A] =
'
Notes:
- Consult all sources for evidence of inter-state conflict involving the government of the country. Just because the government of a country does not appear on the UCDP website, does not mean it is not involved in interstate conflict. Check other reports, including Freedom House and Amnesty International.'

UNION
ALL
SELECT
 [Q] = 'SHI_06'
,[B] =
''
,[A] =
'
Notes:
*“Few” means only one or two isolated situations
** “Numerous” means more than two situations or one ongoing situation with broader effect in the country.  Violence should result from tension between identifiable religious groups. 
Check current year & previous two years of IRF report social hostility sections (2013, 2014, and 2015)
•	SHI_06 follows a similar rationale to SHI-03, but the threshold is much lower. It can include acts by groups in a society that is primarily defined by one religion (including secularism) against a minority religion or vice versa. A main thing to consider is whether the violence reflects group attitudes and identities on both sides rather than just the prejudices of an individual.
'

UNION
ALL
SELECT
 [Q] = 'SHI_13'
,[B] =
''
,[A] =
'
Notes:
*Code as hostile if the word “hostile” is used or if there is physical abuse, displacement, detention, killing or property destructions or defacement.
•	Count hostilities over accusations of forced conversion.
Check current year & previous two years of IRF report social hostility sections (2013, 2014, and 2015)
'

UNION
ALL
SELECT
 [Q] = 'SHI_12'
,[B] =
''
,[A] =
'
Notes:
*Code as hostile if the word “hostile” is used or if there is physical abuse, displacement, detention, killing or property destructions or defacement.
Check current year & previous two years of IRF report social hostility sections (2013, 2014, and 2015)
'

UNION
ALL
SELECT
 [Q] = 'SHI_08'
,[B] =
''
,[A] =
'
Notes:
•	Code 1=yes if members of established or existing religions try to shut out others include clergy and/or significant number of members of religious groups.
•	Witchcraft would not count here unless it is an actual witchcraft related religious group
•	Hate groups count as organized groups (for the purposes of SHI-07), but confirm that the group has a religious element to count under SHI-08.
Check current year & previous two years of IRF report social hostility sections (2013, 2014, and 2015)
'

UNION
ALL
SELECT
 [Q] = 'SHI_07'
,[B] =
''
,[A] =
'
Notes:
•	Social movements can be viewed as collective enterprises to establish a new order [or protect a threatened order] of life. They have their inception in the condition of unrest [or protection of the threatened order], and derive their motive power on one hand from dissatisfaction with the current form of life [or changes to the status quo], and on the other hand, from wishes and hopes for a new [or preservation of the status quo] scheme or system of living.”  Blumer (1939).
•	Such groups operate separately from the government and must act of their own volition.
•	Also code “yes” if social movement(s) exist that oppose certain religious groups or seek their own dominance reported in the sources. 
•	Witchcraft would not count here unless it is an actual witchcraft related religious group
•	Hate groups count as organized groups (for the purposes of SHI-07), but confirm that the group has a religious element to count under SHI-08.
Check current year & previous two years of IRF report social hostility sections (2013, 2014, and 2015)
'

UNION
ALL
SELECT
 [Q] = 'SHI_11'
,[B] =
''
,[A] =
'
Notes:
Check current year & previous two years of IRF report social hostility sections (2013, 2014, and 2015)
'

UNION
ALL
SELECT
 [Q] = 'SHI_09'
,[B] =
''
,[A] =
'
Notes:
•	The motivation should clearly come from a religious point of view with the intent of forcing others to submit to that viewpoint. 
•	Example: If a building was burned down to keep a particular religious group out of an area – this counts.
Check current year & previous two years of IRF report social hostility sections (2013, 2014, and 2015)
'

UNION
ALL
SELECT
 [Q] = 'SHI_09_n'
,[B] =
''
,[A] =
'
Note: If the gender of the victims is not discussed, do not count the incidents. If women were targeted incidentally—for example, as part of a crowd that came under attack—do not count. 
'

UNION
ALL
SELECT
 [Q] = 'SHI_10'
,[B] =
''
,[A] =
'
Notes:
•	This includes people being abused or displaced by nongovernmental actors due to breaking religious norms or converting to other religions.
Check current year & previous two years of IRF report social hostility sections (2013, 2014, and 2015)
'

UNION
ALL
SELECT
 [Q] = 'SHI_10_n'
,[B] =
''
,[A] =
'
Note: If the gender of the victims is not discussed, do not count the incidents. If women were targeted incidentally—for example, as part of a crowd that came under attack—do not count. 
'

UNION
ALL
SELECT
[Q] = 'XSG_S_01'
,[B] =
'
*Sources: Was the following source used? 
'
,[A] =
''


)



SELECT 
  [n]  = ROW_NUMBER()
         OVER(ORDER BY   [L1], [L2] )
 ,[L1]
 ,[L2]
 ,[kk]
 ,[T]

FROM

(

SELECT 
  [L1] = [Q_Number]
 ,[L2] = -6
 ,[kk] = [Question_abbreviation_std]
 ,[T]  = [B]
  FROM [GRSHRcode].[dbo].[All_Questions]  Q
     , [CTE]                              N
 WHERE      Q.[Question_abbreviation_std]
          = N.[Q]

UNION
  ALL

SELECT 
  [L1] = [Q_Number]
 ,[L2] = -5
 ,[kk] = [Question_abbreviation_std]
 ,[T]  =
'
 ╠═════════════════════════════════════════════════════════════════════════════════════════════════════════╣
'
  FROM [GRSHRcode].[dbo].[All_Questions]  Q

UNION
  ALL

SELECT 
  [L1] = [Q_Number]
 ,[L2] = -3
 ,[kk] = [Question_abbreviation_std]
 ,[T]  =  [Question_abbreviation_std]
  FROM [GRSHRcode].[dbo].[All_Questions]  Q

UNION
  ALL

SELECT 
  [L1] = [Q_Number]
 ,[L2] = -2
 ,[kk] = [Question_abbreviation_std]
 ,[T]  = [Question_wording_std]
  FROM [GRSHRcode].[dbo].[All_Questions]  Q

UNION
  ALL

SELECT 
  [L1] = [Q_Number]
 ,[L2] = -1
 ,[kk] = [Question_abbreviation_std]
 ,[T]  = 'Possible Answers:'
  FROM [GRSHRcode].[dbo].[All_Questions]  Q


UNION
  ALL

SELECT 
  [L1] =  Q.[Q_Number]
 ,[L2] =  A.[Answer_value]
 ,[kk] =  Q.[Question_abbreviation_std]
 ,[T]  =  '     '
        + STR((
          CAST(A.[Answer_value] as decimal (4,2))) , 4,2 )
        + '   - ' 
        + A.[Answer_wording_std]
  FROM  [GRSHRcode].[dbo].[All_Questions]  Q
      , [GRSHRcode].[dbo].[All_Answers]    A
 WHERE      Q.[Question_abbreviation_std]
          = A.[Question_abbreviation_std]

UNION
  ALL

SELECT 
  [L1] = [Q_Number]
 ,[L2] = 2
 ,[kk] = [Question_abbreviation_std]
 ,[T]  =
'
 ╔══════════════════════════════════════════╗
 ║                   2015                   ║
 ╠═══════════╦═══════════╦══════════════════╣
 ║  Coder A  ║  Coder B  ║    Reconciled    ║
 ╠═══════════╬═══════════╬══════════════════╣
 ║           ║           ║                  ║
 ║           ║           ║                  ║
 ║           ║           ║                  ║
 ╚═══════════╩═══════════╩══════════════════╝
'
  FROM [GRSHRcode].[dbo].[All_Questions]  Q

/*



*/

UNION
  ALL

SELECT 
  [L1] = [Q_Number]
 ,[L2] = 3
 ,[kk] = [Question_abbreviation_std]
 ,[T]  =
'
 ╠═════════════════════════════════════════════════════════════════════════════════════════════════════════╣
'
  FROM [GRSHRcode].[dbo].[All_Questions]  Q

UNION
  ALL

SELECT 
  [L1] = [Q_Number]
 ,[L2] = 4
 ,[kk] = [Question_abbreviation_std]
 ,[T]  = [A]
  FROM [GRSHRcode].[dbo].[All_Questions]  Q
     , [CTE]                              N
 WHERE      Q.[Question_abbreviation_std]
          = N.[Q]

 )  MYCDEBOOK



/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/








--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]
--SELECT * INTO    [forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]
--            FROM                 [dbo].[vr___10_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
----	SELECT* FROM [forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines] WHERE [Variable] IS NULL
--/***************************************************************************************************************************************************************/


