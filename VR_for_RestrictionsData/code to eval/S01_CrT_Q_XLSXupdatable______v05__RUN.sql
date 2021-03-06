/***************************************************************************************************************************************************************/
/***                                                                  ******************************************************************************************/
/***************************************************************************************************************************************************************/
-- this works as a STEP BY STEP procedure
-- in the future we should have this data as part of the std question table or as a view having some of the notes in other table
USE 
            [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
IF OBJECT_ID
         (N'[forum_ResAnal].[dbo].[AllQuestions]', N'U') IS NOT NULL
DROP TABLE
            [forum_ResAnal].[dbo].[AllQuestions]
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE
               [AllQuestions]
                                      (
                                       [Q_Number]        [bigint]          NULL
                                     , [Variable]        [nvarchar] (128)  NULL
                                     , [Label_minus4]    [nvarchar]  (50)  NULL
                                     , [Wording_minus3]  [nvarchar] (max)  NULL
                                     , [Notes1_plus201]  [nvarchar] (max)  NULL
                                     , [Notes2_plus202]  [nvarchar] (max)  NULL
                                     , [Notes3_plus203]  [nvarchar] (max)  NULL
                                      )
ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SET ANSI_PADDING OFF
GO
/***************************************************************************************************************************************************************/
/****** Load values using code from Excel **********************************************************************************************************************/
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO
               [AllQuestions]
                                      (
                                       [Q_Number]
                                     , [Variable]
                                     , [Label_minus4]
                                     , [Wording_minus3]
                                     , [Notes1_plus201]
                                     , [Notes2_plus202]
                                     , [Notes3_plus203]
                                                       )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                 1 , 'GRI_scaled', 'GRI', 'Government Restrictions Index (GRI)', '', '', ''
UNION ALL SELECT 2 , 'SHI_scaled', 'SHI', 'Social Hostilities Index (SHI)', '', '', ''
UNION ALL SELECT 3 , 'GFI_scaled', 'GFI', 'Government Favoritism Index (GFI)', '', 'In this analysis, GRI.Q.20 is treated as a Government Favoritism Index. The Pew Forum categorizes the levels of government favoritism of religion by percentiles. Countries with scores in the top 5% on GRI.Q.20 were categorized as “very high.” The next highest 15% of scores were categorized as “high,” and the following 20% were categorized as “moderate.” The bottom 60% of scores were categorized as “low.”', 'In this analysis, GRI.Q.20 is treated as a Government Favoritism Index (see page TK). The Pew Forum categorizes the levels of government favoritism of religion by percentiles. Countries with scores in the top 5% on GRI.Q.20 were categorized as “very high.” The next highest 15% of scores were categorized as “high,” and the following 20% were categorized as “moderate.” The bottom 60% of scores were categorized as “low.”'
UNION ALL SELECT 4 , 'GRI_rd_1d', 'GRI', 'Calculated Year Value of the Government Restrictions Index (rounded to one decimal)', '', '', ''
UNION ALL SELECT 5 , 'SHI_rd_1d', 'SHI', 'Calculated Year Value of the Social Hostilities Index (rounded to one decimal)', '', '', ''
UNION ALL SELECT 6 , 'GFI_rd_1d', 'GFI', 'Calculated Year Value of the Government Favoritism Index (rounded to one decimal)', '', '', ''
UNION ALL SELECT 7 , 'GRI', 'GRI', 'Calculated Year Value of the Government Restrictions Index', '', '', ''
UNION ALL SELECT 8 , 'SHI', 'SHI', 'Calculated Year Value of the Social Hostilities Index', '', '', ''
UNION ALL SELECT 9 , 'GFI', 'GFI', 'Calculated Year Value of the Government Favoritism Index', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 10 , 'GRI_01_x', 'GRI_01_x', 'Is there any evidence that the constitution changed since the former coding period?', '', '', ''
UNION ALL SELECT 11 , 'GRI_01_x2', 'GRI_01_x2', 'Did the constitution change make a change in either GRI_01 and GRI_02?', '', '', ''
UNION ALL SELECT 12 , 'GRI_01_x2_a', 'GRI_01_x2_a', 'Did the constitution change make a change in GRI_01?', '', '', ''
UNION ALL SELECT 13 , 'GRI_01', 'GRI.Q.1', 'Does the constitution, or law that functions in the place of a constitution (basic law), specifically provide for "freedom of religion" or include language used in Article 18 of the United Nations Universal Declaration of Human Rights? *', '* Article 18 states: "Everyone has the right to freedom of thought, conscience and religion; this right includes freedom to change his religion or belief, and freedom, either alone or in community with others and in public or private, to manifest his religion or belief in teaching, practice, worship and observance."', '', ''
UNION ALL SELECT 14 , 'GRI_01_x2_b', 'GRI_01_x2_b', 'Did the constitution change make a change in GRI_02?', '', '', ''
UNION ALL SELECT 15 , 'GRI_02', 'GRI.Q.2', 'Does the constitution or basic law include stipulations that appear to qualify or substantially contradict the concept of “religious freedom”?', ' ', '', ''
UNION ALL SELECT 16 , 'GRI_03', 'GRI.Q.3', 'Taken together, how do the constitution/basic law and other national laws and policies affect religious freedom?', ' ', '', ''
UNION ALL SELECT 17 , 'GRI_04', 'GRI.Q.4', 'Does any level of government interfere with worship or other religious practices?', ' ', '', ''
UNION ALL SELECT 18 , 'GRI_05', 'GRI.Q.5', 'Is public preaching by religious groups limited by any level of government?', ' ', '', ''
UNION ALL SELECT 19 , 'GRI_06', 'GRI.Q.6', 'Is proselytizing limited by any level of government?', ' ', '', ''
UNION ALL SELECT 20 , 'GRI_07', 'GRI.Q.7', 'Is converting from one religion to another limited by any level of government?', ' ', '', ''
UNION ALL SELECT 21 , 'GRI_08_for_index', 'GRI.Q.8', 'Is religious literature or broadcasting limited by any level of government?', ' ', '', ''
UNION ALL SELECT 22 , 'GRI_08', 'GRI_08', 'Is religious literature or broadcasting limited by any level of government?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 23 , 'GRI_09', 'GRI.Q.9', 'Are foreign missionaries allowed to operate?', ' ', '', ''
UNION ALL SELECT 24 , 'GRI_10', 'GRI.Q.10', 'Is the wearing of religious symbols, such as head coverings for women and facial hair for men, regulated by law or by any level of government?', ' ', '', ''
UNION ALL SELECT 25 , 'GRI_10_01', 'GRI_10_01', 'Is the wearing of scarves or head coverings for women regulated by law or by any level of government?', '', '', ''
UNION ALL SELECT 26 , 'GRI_10_02', 'GRI_10_02', 'Is the wearing of beards or facial hair for men regulated by law or by any level of government?', '', '', ''
UNION ALL SELECT 27 , 'GRI_10_03', 'GRI_10_03', 'Is the wearing of other religious symbols, besides head coverings for women and facial hair for men, regulated by law or by any level of government?', '', '', ''
UNION ALL SELECT 28 , 'GRI_11', 'GRI.Q.11', 'Was there harassment or intimidation of religious groups by any level of government?', ' ', '', ''
UNION ALL SELECT 29 , 'GRI_11_01a', 'GRI_11_01a', 'Was there harassment or intimidation of Orthodox Christianity by any level of government?', '', '', ''
UNION ALL SELECT 30 , 'GRI_11_01b', 'GRI_11_01b', 'Was there harassment or intimidation of Catholic Christianity by any level of government?', '', '', ''
UNION ALL SELECT 31 , 'GRI_11_02', 'GRI_11_02', 'Was there harassment or intimidation of Protestant/Anglican Christianity by any level of government?', '', '', ''
UNION ALL SELECT 32 , 'GRI_11_03', 'GRI_11_03', 'Was there harassment or intimidation of Christianity (unspecified) by any level of government?', '', '', ''
UNION ALL SELECT 33 , 'GRI_11_04', 'GRI_11_04', 'Was there harassment or intimidation of Sunni Islam by any level of government?', '', '', ''
UNION ALL SELECT 34 , 'GRI_11_05', 'GRI_11_05', 'Was there harassment or intimidation of Shia Islam by any level of government?', '', '', ''
UNION ALL SELECT 35 , 'GRI_11_06', 'GRI_11_06', 'Was there harassment or intimidation of Islam (unspecified) by any level of government?', '', '', ''
UNION ALL SELECT 36 , 'GRI_11_07', 'GRI_11_07', 'Was there harassment or intimidation of Buddhism by any level of government?', '', '', ''
UNION ALL SELECT 37 , 'GRI_11_08', 'GRI_11_08', 'Was there harassment or intimidation of Hinduism by any level of government?', '', '', ''
UNION ALL SELECT 38 , 'GRI_11_09', 'GRI_11_09', 'Was there harassment or intimidation of Judaism by any level of government?', '', '', ''
UNION ALL SELECT 39 , 'GRI_11_10', 'GRI_11_10', 'Was there harassment or intimidation of other "new" religions (Scientology or Bahai) by any level of government?', '', '', ''
UNION ALL SELECT 40 , 'GRI_11_11', 'GRI_11_11', 'Was there harassment or intimidation of other schismatic Christian sects (Mormons or Jehovah Witnesses) by any level of government?', '', '', ''
UNION ALL SELECT 41 , 'GRI_11_12', 'GRI_11_12', 'Was there harassment or intimidation of other schismatic Muslim sects (Ahmadiyya or Druze) by any level of government?', '', '', ''
UNION ALL SELECT 42 , 'GRI_11_13', 'GRI_11_13', 'Was there harassment or intimidation of other ethnic or tribal religions (Voodoo or Witchcraft) by any level of government?', '', '', ''
UNION ALL SELECT 43 , 'GRI_11_14', 'GRI_11_14', 'Was there harassment or intimidation of other ancient religions (Zoroastrianism or Sikhs) by any level of government?', '', '', ''
UNION ALL SELECT 44 , 'GRI_11_15', 'GRI_11_15', 'Was there harassment or intimidation of Sikhs by any level of government?', '', '', ''
UNION ALL SELECT 45 , 'GRI_11_16', 'GRI_11_16', 'Was there harassment or intimidation of other ancient religions (Zoroastrianism) by any level of government?', '', '', ''
UNION ALL SELECT 46 , 'GRI_11_17', 'GRI_11_17', 'Was there harassment or intimidation of atheists by any level of government?', '', '', ''
UNION ALL SELECT 47 , 'GRI_11_xG1', 'GRI_11_xG1', 'Was there harassment or intimidation of Christianity by any level of government?', '', '', ''
UNION ALL SELECT 48 , 'GRI_11_xG2', 'GRI_11_xG2', 'Was there harassment or intimidation of Islam by any level of government?', '', '', ''
UNION ALL SELECT 49 , 'GRI_11_xG3', 'GRI_11_xG3', 'Was there harassment or intimidation of Buddhism by any level of government?', '', '', ''
UNION ALL SELECT 50 , 'GRI_11_xG4', 'GRI_11_xG4', 'Was there harassment or intimidation of Hinduism by any level of government?', '', '', ''
UNION ALL SELECT 51 , 'GRI_11_xG5', 'GRI_11_xG5', 'Was there harassment or intimidation of Judaism by any level of government?', '', '', ''
UNION ALL SELECT 52 , 'GRI_11_xG6', 'GRI_11_xG6', 'Was there harassment or intimidation of other religions by any level of government?', '', '', ''
UNION ALL SELECT 53 , 'GRI_11_xG7', 'GRI_11_xG7', 'Was there harassment or intimidation of ethnic or tribal religions by any level of government?', '', '', ''
UNION ALL SELECT 54 , 'GRI_12', 'GRI.Q.12', 'Did the national government display hostility involving physical violence toward minority or nonapproved religious groups?', ' ', '', ''
UNION ALL SELECT 55 , 'GRI_13', 'GRI.Q.13', 'Where there instances when the national government did not intervene in cases of discrimination or abuses against religious groups?', ' ', '', ''
UNION ALL SELECT 56 , 'GRI_14', 'GRI.Q.14', 'Does the national government have an established organization to regulate or manage religious affairs?', ' ', '', ''
UNION ALL SELECT 57 , 'GRI_15', 'GRI.Q.15', 'Did the national government denounce one or more religious groups by characterizing them as dangerous “cults” or “sects”?', ' ', '', ''
UNION ALL SELECT 58 , 'GRI_16', 'GRI_16', 'Does any level of government formally ban any religious group?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 59 , 'GRI_16_ny', 'GRI.Q.16', 'Does any level of government formally ban any religious group?', ' ', '', ''
UNION ALL SELECT 60 , 'GRI_16_01', 'GRI_16_01', 'List group(s) banned by  any level of government.', '', '', ''
UNION ALL SELECT 61 , 'GRI_17', 'GRI.Q.17', 'Were there instances when the national government attempted to eliminate an entire religious group’s presence in the country?', ' ', '', ''
UNION ALL SELECT 62 , 'GRI_18', 'GRI.Q.18', 'Did any level of government ask religious groups to register for any reason, including to be eligible for benefits such as tax exemption?', ' ', '', ''
UNION ALL SELECT 63 , 'GRI_19', 'GRI_19', 'Did any level of government use force toward religious groups that resulted in individuals being killed, physically abused, imprisoned, detained or displaced from their homes, or having their personal or religious properties damaged or destroyed?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 64 , 'GRI_19_filter', 'GRI_19_filter', 'Did any level of government use force toward religious groups that resulted in individuals being killed, physically abused, imprisoned, detained or displaced from their homes, or having their personal or religious properties damaged or destroyed?', '', '', ''
UNION ALL SELECT 65 , 'GRI_19_ny', 'GRI.Q.19', 'Did any level of government use force toward religious groups that resulted in individuals being killed, physically abused, imprisoned, detained or displaced from their homes, or having their personal or religious properties damaged or destroyed?', ' ', '', ''
UNION ALL SELECT 66 , 'GRI_19_summ_ny', 'GRI.Q.19b', 'Did any level of government use force toward religious groups that resulted in individuals being killed, physically abused, imprisoned, detained or displaced from their homes, or having their personal or religious properties damaged or destroyed?', 'Percentages add to more than 100 because countries can have multiple types of cases of government force.
^ This line represents the number or percentage of countries in which at least one of the following types of government force occurred.', '', ''
UNION ALL SELECT 67 , 'GRI_19_x', 'GRI_19_x', 'Did any level of government use force toward religious groups that resulted in individuals being killed, physically abused, imprisoned, detained or displaced from their homes, or having their personal or religious properties damaged or destroyed?', '', '', ''
UNION ALL SELECT 68 , 'GRI_19_b', 'GRI_19_b', 'Was property damaged, due to religion, as a result of any level of government action or policy?', '', '', ''
UNION ALL SELECT 69 , 'GRI_19_c', 'GRI_19_c', 'Were there detentions or abductions, due to religion, as a result of any level of government action or policy?', '', '', ''
UNION ALL SELECT 70 , 'GRI_19_d', 'GRI_19_d', 'Were individuals displaced from their homes, due to religion, by any level of government action or policy?', '', '', ''
UNION ALL SELECT 71 , 'GRI_19_e', 'GRI_19_e', 'Were there physical assaults, due to religion, motivated by any level of government action or policy in this country?', '', '', ''
UNION ALL SELECT 72 , 'GRI_19_f', 'GRI_19_f', 'Were there deaths, due to religion, motivated by any level of government action or policy in this country?', '', '', ''
UNION ALL SELECT 73 , 'GRI_19_da', 'GRI_19_da', 'Were individuals internally displaced, due to religion, by any level of government action or policy?', '', '', ''
UNION ALL SELECT 74 , 'GRI_19_db', 'GRI_19_db', 'Were individuals displaced to another country, due to religion, by any level of government action or policy?', '', '', ''
UNION ALL SELECT 75 , 'GRI_20', 'GRI_20', 'Do some religious groups receive government support or favors, such as funding, official recognition or special access?', '', '', ''
UNION ALL SELECT 76 , 'GRI_20_top', 'GRI.Q.20', 'Do some religious groups receive government support or favors, such as funding, official recognition or special access?', 'This is a summary table that puts the restrictions identified in Questions 20.1, 20.2, 20.3a-c, 20.4, and 20.5 into a single measure indicating the level to which a government supports religious groups in the country.
Government support of a religion or religions is considered restrictive only when preferential treatment of one or more religious groups puts other religious groups at a disadvantage. ', '', ''
UNION ALL SELECT 77 , 'GRI_20_01', 'GRI.Q.20.1', 'Does the country''s constitution or basic law recognize a favored religion or religions?', 'This question is a component of GRI.Q.20.
For GRI.Q.20.1, the differences between the coding periods may not be as significant as they appear due to minor changes in coding procedures.', '', ''
UNION ALL SELECT 78 , 'GRI_20_01x_01a', 'GRI_20_01x_01a', 'Is Orthodox Christianity recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 79 , 'GRI_20_01x_01b', 'GRI_20_01x_01b', 'Is Catholic Christianity recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 80 , 'GRI_20_01x_02', 'GRI_20_01x_02', 'Is Protestant/Anglican Christianity recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 81 , 'GRI_20_01x_03', 'GRI_20_01x_03', 'Is Christianity (unspecified) recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 82 , 'GRI_20_01x_04', 'GRI_20_01x_04', 'Is Sunni Islam recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 83 , 'GRI_20_01x_05', 'GRI_20_01x_05', 'Is Shia Islam recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 84 , 'GRI_20_01x_06', 'GRI_20_01x_06', 'Is Islam (unspecified) recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 85 , 'GRI_20_01x_07', 'GRI_20_01x_07', 'Is Buddhism recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 86 , 'GRI_20_01x_08', 'GRI_20_01x_08', 'Is Hinduism recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 87 , 'GRI_20_01x_09', 'GRI_20_01x_09', 'Is Judaism recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 88 , 'GRI_20_01x_10', 'GRI_20_01x_10', 'Are other religions recognized as a favored religion by the constitution or law that functions in the place of constitution?', '', '', ''
UNION ALL SELECT 89 , 'GRI_20_02', 'GRI.Q.20.2', 'Do all religious groups receive the same level of government access and privileges?', 'This question is a component of GRI.Q.20.', '', ''
UNION ALL SELECT 90 , 'GRI_20_03_top', 'GRI.Q.20.3', 'Does any level of government provide funds or other resources to religious groups?', 'This question is a component of GRI.Q.20.
This is a summary table that puts the restrictions identified in Questions 20.3a-c into a single measure indicating the level to which a government supports religious groups in the country.
Government support of a religion or religions is considered restrictive only when preferential treatment of one or more religious groups puts other religious groups at a disadvantage.', '', ''
UNION ALL SELECT 91 , 'GRI_20_03_a', 'GRI.Q.20.3.a', 'Does any level of government provide funds or other resources for religious education programs and/or religious schools?', 'This question is a component of GRI.Q.20.3.', '', ''
UNION ALL SELECT 92 , 'GRI_20_03_b', 'GRI.Q.20.3.b', 'Does any level of government provide funds or other resources for religious property (e.g., buildings, upkeep, repair or land)?', 'This question is a component of GRI.Q.20.3.', '', ''
UNION ALL SELECT 93 , 'GRI_20_03_c', 'GRI.Q.20.3.c', 'Does any level of government provide funds or other resources for religious activities other than education or property?', 'This question is a component of GRI.Q.20.3.', '', ''
UNION ALL SELECT 94 , 'GRI_20_04', 'GRI.Q.20.4', 'Is religious education required in public schools?', 'This question is a component of GRI.Q.20.', '', ''
UNION ALL SELECT 95 , 'GRI_20_04_x', 'GRI_20_04_x', 'Is religious education offered in public schools?', '', '', ''
UNION ALL SELECT 96 , 'GRI_20_05', 'GRI.Q.20.5', 'Does the national government defer in some way to religious authorities, texts or doctrines on legal issues?', 'This question is a component of GRI.Q.20.', '', ''
UNION ALL SELECT 97 , 'GRI_20_05_x', 'GRI_20_05_x', 'Have provisions of sharia law been adopted in the country?', '', '', ''
UNION ALL SELECT 98 , 'GRI_20_05_x1', 'GRI_20_05_x1', 'Have provisions of sharia law been adopted in the province?', '', '', ''
UNION ALL SELECT 99 , 'SHI_01', 'SHI.Q.1', 'Were there crimes, malicious acts or violence motivated by religious hatred or bias?', 'This is a summary table that captures the hostilities identified in questions 1.a-f into a single measure indicating the severity of religious hatred or bias in each country.
If one type of hostility occurred the country received 1/6 point for that year. Countries can have multiple types of hostilities. The scores on this question are cumulative; a country with three types of malicious acts would score 0.50 for that period and a country with all six types in any of both years would score 1.00.', '', ''
UNION ALL SELECT 100 , 'SHI_01_summary_a_ny', 'SHI.Q.1a', 'Were there crimes, malicious acts or violence motivated by religious hatred or bias?', 'This is a summary table that captures the hostilities identified in questions 1.a-f indicating the types of religious hatred or bias.
Percentages add to more than 100 because countries can have multiple types of hostilities.
^ This line represents the number or percentage of countries in which at least one of the following hostilities occurred.', '', ''
UNION ALL SELECT 101 , 'SHI_01_summary_a', 'SHI_01_summary_a', 'Were there crimes, malicious acts or violence motivated by religious hatred or bias?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 102 , 'SHI_01_summary_b', 'SHI.Q.1b', 'How many different types of crimes, malicious acts or violence motivated by religious hatred or bias occured? The six different types considered include: harassment/intimidation, property damage, detentions/abductions, displacement from homes, physcal assaults and killings.', 'This is a summary table that captures the different types of hostilities into a single measure indicating the severity of religious hatred or bias.', '', ''
UNION ALL SELECT 103 , 'SHI_01_x', 'SHI_01_x', 'Did individuals face harassment or intimidation motivated by religious hatred or bias?', '', '', ''
UNION ALL SELECT 104 , 'SHI_01_a_dummy', 'SHI.Q.1a', 'Did individuals face harassment or intimidation motivated by religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 105 , 'SHI_01_b_dummy', 'SHI.Q.1b', 'Was property damaged as a result of religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 106 , 'SHI_01_c_dummy', 'SHI.Q.1c', 'Were there detentions or abductions motivated by religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 107 , 'SHI_01_d_dummy', 'SHI.Q.1d', 'Were individuals displaced from their homes because of religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 108 , 'SHI_01_e_dummy', 'SHI.Q.1e', 'Were there physical assaults motivated by religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 109 , 'SHI_01_f_dummy', 'SHI.Q.1f', 'Were there deaths motivated by religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 110 , 'SHI_01_a', 'SHI.Q.1a', 'Did individuals face harassment or intimidation motivated by religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 111 , 'SHI_01_x_01a', 'SHI_01_x_01a', 'Has there been any alleged harassment of Orthodox Christianity by social groups?', '', '', ''
UNION ALL SELECT 112 , 'SHI_01_x_01b', 'SHI_01_x_01b', 'Has there been any alleged harassment of Catholic Christianity by social groups?', '', '', ''
UNION ALL SELECT 113 , 'SHI_01_x_02', 'SHI_01_x_02', 'Has there been any alleged harassment of Protestant/Anglican Christianity by social groups?', '', '', ''
UNION ALL SELECT 114 , 'SHI_01_x_03', 'SHI_01_x_03', 'Has there been any alleged harassment of Christianity (unspecified) by social groups?', '', '', ''
UNION ALL SELECT 115 , 'SHI_01_x_04', 'SHI_01_x_04', 'Has there been any alleged harassment of Sunni Islam by social groups?', '', '', ''
UNION ALL SELECT 116 , 'SHI_01_x_05', 'SHI_01_x_05', 'Has there been any alleged harassment of Shia Islam by social groups?', '', '', ''
UNION ALL SELECT 117 , 'SHI_01_x_06', 'SHI_01_x_06', 'Has there been any alleged harassment of Islam (unspecified) by social groups?', '', '', ''
UNION ALL SELECT 118 , 'SHI_01_x_07', 'SHI_01_x_07', 'Has there been any alleged harassment of Buddhism by social groups?', '', '', ''
UNION ALL SELECT 119 , 'SHI_01_x_08', 'SHI_01_x_08', 'Has there been any alleged harassment of Hinduism by social groups?', '', '', ''
UNION ALL SELECT 120 , 'SHI_01_x_09', 'SHI_01_x_09', 'Has there been any alleged harassment of Judaism by social groups?', '', '', ''
UNION ALL SELECT 121 , 'SHI_01_x_10', 'SHI_01_x_10', 'Has there been any alleged harassment of other "new" religions (Scientology or Bahai) by social groups?', '', '', ''
UNION ALL SELECT 122 , 'SHI_01_x_11', 'SHI_01_x_11', 'Has there been any alleged harassment of other schismatic Christian sects (Mormons or Jehovah Witnesses) by social groups?', '', '', ''
UNION ALL SELECT 123 , 'SHI_01_x_12', 'SHI_01_x_12', 'Has there been any alleged harassment of other schismatic Muslim sects (Ahmadiyya or Druze) by social groups?', '', '', ''
UNION ALL SELECT 124 , 'SHI_01_x_13', 'SHI_01_x_13', 'Has there been any alleged harassment of other ethnic or tribal religions (Voodoo or Witchcraft) by social groups?', '', '', ''
UNION ALL SELECT 125 , 'SHI_01_x_14', 'SHI_01_x_14', 'Has there been any alleged harassment of other ancient religions (Zoroastrianism or Sikhs) by social groups?', '', '', ''
UNION ALL SELECT 126 , 'SHI_01_x_15', 'SHI_01_x_15', 'Has there been any alleged harassment of Sikhs by social groups?', '', '', ''
UNION ALL SELECT 127 , 'SHI_01_x_16', 'SHI_01_x_16', 'Has there been any alleged harassment of other ancient religions (Zoroastrianism) by social groups?', '', '', ''
UNION ALL SELECT 128 , 'SHI_01_x_17', 'SHI_01_x_17', 'Has there been any alleged harassment of atheists by social groups?', '', '', ''
UNION ALL SELECT 129 , 'SHI_01_xG1', 'SHI_01_xG1', 'Has there been any alleged harassment of Christianity by social groups?', '', '', ''
UNION ALL SELECT 130 , 'SHI_01_xG2', 'SHI_01_xG2', 'Has there been any alleged harassment of Islam by social groups?', '', '', ''
UNION ALL SELECT 131 , 'SHI_01_xG3', 'SHI_01_xG3', 'Has there been any alleged harassment of Buddhism by social groups?', '', '', ''
UNION ALL SELECT 132 , 'SHI_01_xG4', 'SHI_01_xG4', 'Has there been any alleged harassment of Hinduism by social groups?', '', '', ''
UNION ALL SELECT 133 , 'SHI_01_xG5', 'SHI_01_xG5', 'Has there been any alleged harassment of Judaism by social groups?', '', '', ''
UNION ALL SELECT 134 , 'SHI_01_xG6', 'SHI_01_xG6', 'Has there been any alleged harassment of other religions by social groups?', '', '', ''
UNION ALL SELECT 135 , 'SHI_01_xG7', 'SHI_01_xG7', 'Has there been any alleged harassment of ethnic or tribal religions by social groups?', '', '', ''
UNION ALL SELECT 136 , 'SHI_01_b', 'SHI.Q.1b', 'Was property damaged as a result of religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 137 , 'SHI_01_c', 'SHI.Q.1c', 'Were there detentions or abductions motivated by religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 138 , 'SHI_01_d', 'SHI.Q.1d', 'Were individuals displaced from their homes because of religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 139 , 'SHI_01_e', 'SHI.Q.1e', 'Were there physical assaults motivated by religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 140 , 'SHI_01_f', 'SHI.Q.1f', 'Were there deaths motivated by religious hatred or bias?', ' This question is a component of SHI.Q.1', '', ''
UNION ALL SELECT 141 , 'SHI_01_da', 'SHI_01_da', 'Were individuals internally displaced because of religious hatred or bias?', '', '', ''
UNION ALL SELECT 142 , 'SHI_01_db', 'SHI_01_db', 'Were individuals displaced to another country because of religious hatred or bias?', '', '', ''
UNION ALL SELECT 143 , 'SHI_02', 'SHI.Q.2', 'Was there mob violence related to religion?', ' ', '', ''
UNION ALL SELECT 144 , 'SHI_02_01', 'SHI_02_01', 'Was there "ethnic cleansing" or "genocide" related to religion?', '', '', ''
UNION ALL SELECT 145 , 'SHI_03', 'SHI.Q.3', 'Were there acts of sectarian or communal violence between religious groups?', ' Sectarian or communal violence involves two or more religious groups facing off in repeated clashes.', '', ''
UNION ALL SELECT 146 , 'SHI_04', 'SHI_04', 'Were religion-related terrorist groups active in the country?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 147 , 'SHI_04_filter', 'SHI_04_filter', 'Were religion-related terrorist groups active in the country?', '', '', ''
UNION ALL SELECT 148 , 'SHI_04_ny', 'SHI.Q.4', 'Were religion-related terrorist groups active in the country?', 'Religion-related terrorism is defined as politically motivated violence agaisnt noncombatants by subnational groups or clandestine agents with a religious justification or intent. 
Some of the increase in religion-related terrorism between the year ending in mid-2007 and the year ending in mid-2009 could reflect the use of new source material providing greater detail on terrorist activities than was provided by sources used in the baseline report.', '', ''
UNION ALL SELECT 149 , 'SHI_04_x', 'SHI_04_x', 'How many religion-related terrorist crimes, malicious acts or events of violence were found in the country?', '', '', ''
UNION ALL SELECT 150 , 'SHI_04_b', 'SHI_04_b', 'Was property damaged due to religion-related terrorism?', '', '', ''
UNION ALL SELECT 151 , 'SHI_04_c', 'SHI_04_c', 'Were there detentions or abductions due to religion-related terrorism?', '', '', ''
UNION ALL SELECT 152 , 'SHI_04_d', 'SHI_04_d', 'Were individuals displaced from their homes due to religion-related terrorism?', '', '', ''
UNION ALL SELECT 153 , 'SHI_04_e', 'SHI_04_e', 'Were there physical assaults due to religion-related terrorism?', '', '', ''
UNION ALL SELECT 154 , 'SHI_04_f', 'SHI_04_f', 'Were there deaths due to religion-related terrorism?', '', '', ''
UNION ALL SELECT 155 , 'SHI_04_da', 'SHI_04_da', 'Were individuals internally displaced due to religion-related terrorism?', '', '', ''
UNION ALL SELECT 156 , 'SHI_04_db', 'SHI_04_db', 'Were individuals displaced to another country due to religion-related terrorism?', '', '', ''
UNION ALL SELECT 157 , 'SHI_04_x01', 'SHI_04_x01', 'List the religion-related terrorist groups active in the country.', '', '', ''
UNION ALL SELECT 158 , 'SHI_05', 'SHI_05', 'Was there a religion-related war or armed conflict in the country (including ongoing displacements from previous wars)?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 159 , 'SHI_05_filter', 'SHI_05_filter', 'Was there a religion-related war or armed conflict in the country (including ongoing displacements from previous wars)?', '', '', ''
UNION ALL SELECT 160 , 'SHI_05_ny', 'SHI.Q.5', 'Was there a religion-related war or armed conflict in the country?', 'Religion-related war is defined as armed conflict (involving sustained casualties over time or more than 1,000 battle deaths) in which religious rhetoric is commonly employed to justify the use of force, or in which one or more of the combatants primarily identifies itself or the opposings side by religion. 
Some of the increase shown above for 2011 reflects ongoing displacements that were not coded in previous years, including the religion-related conflicts in such places as Cyprus.', '', ''
UNION ALL SELECT 161 , 'SHI_05_x', 'SHI_05_x', 'How many religion-related war  crimes, malicious acts or events of violence were found in the country?', '', '', ''
UNION ALL SELECT 162 , 'SHI_05_b', 'SHI_05_b', 'By province, count the number of people who, due to religion, had property damaged/defaced or destroyed during a religiously-related war/revolution/armed conflict', '', '', ''
UNION ALL SELECT 163 , 'SHI_05_c', 'SHI_05_c', 'Were there detentions or abductions due to religion-related war or armed conflict?', '', '', ''
UNION ALL SELECT 164 , 'SHI_05_d', 'SHI_05_d', 'Were individuals displaced from their homes due to religion-related war or armed conflict (including ongoing displacements from previous wars)?', '', '', ''
UNION ALL SELECT 165 , 'SHI_05_e', 'SHI_05_e', 'Were there physical assaults due to religion-related war or armed conflict?', '', '', ''
UNION ALL SELECT 166 , 'SHI_05_f', 'SHI_05_f', 'Were there deaths due to religion-related war or armed conflict?', '', '', ''
UNION ALL SELECT 167 , 'SHI_05_da', 'SHI_05_da', 'Were individuals internally displaced due to religion-related war or armed conflict (including ongoing displacements from previous wars)?', '', '', ''
UNION ALL SELECT 168 , 'SHI_05_db', 'SHI_05_db', 'Were individuals displaced to another country due to religion-related war or armed conflict (including ongoing displacements from previous wars)?', '', '', ''
UNION ALL SELECT 169 , 'SHI_06', 'SHI.Q.6', 'Did violence result from tensions between religious groups?', 'The data for each year also takes into account information from the two previous years.', '', ''
UNION ALL SELECT 170 , 'SHI_07', 'SHI_07', 'Did organized groups use force or coercion in an attempt to dominate public life with their perspective on religion, including preventing some religious groups from operating in the country?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 171 , 'SHI_07_ny', 'SHI.Q.7', 'Did organized groups use force or coercion in an attempt to dominate public life with their perspective on religion, including preventing some religious groups from operating in the country?', 'The data for each year also takes into account information from the two previous years.', '', ''
UNION ALL SELECT 172 , 'SHI_08', 'SHI.Q.8', 'Did religious groups themselves attempt to prevent other religious groups from being able to operate?', 'The data for each year also takes into account information from the two previous years.', '', ''
UNION ALL SELECT 173 , 'SHI_09', 'SHI.Q.9', 'Did individuals or groups use violence or the threat of violence, including so-called honor killings, to try to enforce religious norms?', 'The data for each year also takes into account information from the two previous years.', '', ''
UNION ALL SELECT 174 , 'SHI_10', 'SHI.Q.10', 'Were individuals assaulted or displaced from their homes in retaliation for religious activities, including preaching and other forms of religious expression, considered offensive or threatening to the majority faith?', 'The data for each year also takes into account information from the two previous years.', '', ''
UNION ALL SELECT 175 , 'SHI_11_for_index', 'SHI.Q.11', 'Were women harassed for violating religious dress codes?', 'The data for each year also takes into account information from the two previous years. ', '', ''
UNION ALL SELECT 176 , 'SHI_11', 'SHI_11', 'Were women harassed for violating religious dress codes?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 177 , 'SHI_11_x', 'SHI_11_x', 'Are women socially discriminated against or harassed due to violating religious norms or precepts, including being harassed for violating religious dress codes?', '', '', ''
UNION ALL SELECT 178 , 'SHI_12', 'SHI.Q.12', 'Were there incidents of hostility over proselytizing?', 'The data for each year also takes into account information from the two previous years. ', '', ''
UNION ALL SELECT 179 , 'SHI_13', 'SHI.Q.13', 'Were there incidents of hostility over conversions from one religion to another?', 'The data for each year also takes into account information from the two previous years. ', '', ''
UNION ALL SELECT 180 , 'GRX_21_01', 'GRX_21_01', 'Did religious issues trigger the use of force toward religious individuals or groups by government actors?', '', '', ''
UNION ALL SELECT 181 , 'GRX_21_02', 'GRX_21_02', 'Did political issues trigger the use of force toward religious individuals or groups by government actors?', '', '', ''
UNION ALL SELECT 182 , 'GRX_21_03', 'GRX_21_03', 'Did other socio-economic isues trigger the use of force toward religious individuals or groups by government actors?', '', '', ''
UNION ALL SELECT 183 , 'GRX_22_filter', 'GRX_22_filter', 'Does any level of government penalize the defamation of religion, including penalizing such things as blasphemy, apostasy, and criticism or critiques of a religion or religions?', '', '', ''
UNION ALL SELECT 184 , 'GRX_22_ny', 'Additional Question 1', 'Does any level of government penalize the defamation of religion, including penalizing such things as blasphemy, apostasy, and criticism or critiques of a religion or religions?', 'Additional Question 1 was only coded beginning with the year ending in mid-2009.', '', ''
UNION ALL SELECT 185 , 'GRX_22', 'GRX_22', 'Does any level of government penalize the defamation of religion, including penalizing such things as blasphemy, apostasy, and criticism or critiques of a religion or religions?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 186 , 'GRX_22_01', 'GRX_22_01', 'Does any level of government penalize blasphemy?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 187 , 'GRX_22_01_ny', 'Additional Question 1a', 'Does any level of government penalize blasphemy?', 'This question is a component of the Additional Question 1.
Additional Question 1a is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 188 , 'GRX_22_02', 'GRX_22_02', 'Does any level of government penalize apostasy?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 189 , 'GRX_22_02_ny', 'Additional Question 1b', 'Does any level of government penalize apostasy?', 'This question is a component of the Additional Question 1.
Additional Question 1b is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 190 , 'GRX_22_03', 'GRX_22_03', 'Does any level of government penalize hate speech about a religion or religions?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 191 , 'GRX_22_04_ny', 'Additional Question 1c', 'Does any level of government penalize criticism or critiques of a religion or religions?', 'This question is a component of the Additional Question 1.
Additional Question 1c is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 192 , 'GRX_22_03_ny', 'Additional Question 2', 'Does any level of government penalize hate speech about a religion or religions?', 'Additional Question 2 is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 193 , 'GRX_22_04', 'GRX_22_04', 'Does any level of government penalize criticism or critiques of a religion or religions?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 194 , 'XSG_25n27_ny', 'Additional Question 3', 'Did events, groups or individuals from outside the country contribute to government restrictions on religion or social hostilities involving religion in the country?', 'Additional Question 3 is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 195 , 'GRX_23', 'GRX_23', 'Are public expressions of faith or religiously based socio-political arguments restricted by any level of government?', '', '', ''
UNION ALL SELECT 196 , 'GRX_25_ny', 'Additional Question 3a', 'Did events, groups or individuals from outside the country contribute to government restrictions on religion in the country?', 'This question is a component of the Additional Question 3.
Additional Question 3a is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 197 , 'GRX_25_01', 'GRX_25_01', 'Did events, groups or individuals from outside the country contribute to government restrictions on religion in the country?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 198 , 'GRX_25_02', 'GRX_25_02', 'Did events, groups or individuals from outside the country, which were entirely outside the country, contribute to government restrictions on religion in the country?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 199 , 'GRX_25_03', 'GRX_25_03', 'Did events, groups or individuals from outside the country, which were in the country, contribute to government restrictions on religion in the country?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 200 , 'SHX_27_ny', 'Additional Question 3b', 'Did events, groups or individuals from outside the country contribute to social hostilities involving religion in the country?', 'This question is a component of the Additional Question 3.
Additional Question 3b is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 201 , 'SHX_27_01', 'SHX_27_01', 'Did events, groups or individuals from outside the country contribute to social hostilities involving religion in the country?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 202 , 'SHX_27_02', 'SHX_27_02', 'Did events, groups or individuals from outside the country, which were entirely outside the country, contribute to social hostilities involving religion in the country?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 203 , 'SHX_27_03', 'SHX_27_03', 'Did events, groups or individuals from outside the country, which were in the country, contribute to social hostilities involving religion in the country?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 204 , 'XSG_242526_ny', 'Additional Question 4', 'Was there discrimination, harassment or violence in the country related to immigrants, in whole or part because of religion?', 'Additional Question 4 is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 205 , 'GRX_24_ny', 'Additional Question 4a', 'Did any level of government discriminate against, harass or use physical force toward immigrants or those seeking to immigrate in whole or part because of the immigrants'' religion?', 'This question is a component of the Additional Question 4.
Additional Question 4a is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 206 , 'GRX_24', 'GRX_24', 'Did any level of government discriminate against, harass or use physical force toward immigrants or those seeking to immigrate in whole or part because of the immigrants'' religion?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 207 , 'SHX_25_ny', 'Additional Question 4b', 'Did individuals or groups in society discriminate against, harass or commit acts of violence toward immigrants or those seeking to immigrate in whole or part because of the immigrants’ religion?', 'This question is a component of the Additional Question 4.
Additional Question 4b is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 208 , 'SHX_25', 'SHX_25', 'Did individuals or groups in society discriminate against, harass or commit acts of violence toward immigrants or those seeking to immigrate in whole or part because of the immigrants’ religion?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 209 , 'SHX_26_ny', 'Additional Question 4c', 'Did immigrants in the country engage in religion-related acts of violence?', 'This question is a component of the Additional Question 4.
Additional Question 4c is a new question, so data are only available for the year ending in mid-2010.', '', ''
UNION ALL SELECT 210 , 'SHX_26', 'SHX_26', 'Did immigrants in the country engage in religion-related acts of discrimination, harassment or violence?', '*** Included in other question: exact variable not currently used in toplines or results by country', '', ''
UNION ALL SELECT 211 , 'GRX_26_01', 'GRX_26_01', 'Did religion-related armed conflict that crosses a border contribute to government restrictions on religion in the country?', '', '', ''
UNION ALL SELECT 212 , 'GRX_26_02', 'GRX_26_02', 'Did religion-related terrorism with cross-border ties or acts contribute to government restrictions on religion in the country?', '', '', ''
UNION ALL SELECT 213 , 'GRX_26_03', 'GRX_26_03', 'Did the influence of foreign governments contribute to government restrictions on religion in the country?', '', '', ''
UNION ALL SELECT 214 , 'GRX_26_04', 'GRX_26_04', 'Did problems involving international immigrants contribute to government restrictions on religion in the country?', '', '', ''
UNION ALL SELECT 215 , 'GRX_26_05', 'GRX_26_05', 'Did extremist influences (alleged or real) contribute to government restrictions on religion in the country?', '', '', ''
UNION ALL SELECT 216 , 'GRX_26_06', 'GRX_26_06', 'Did hostile reactions to foreign (non-citizen) preachers contribute to government restrictions on religion in the country?', '', '', ''
UNION ALL SELECT 217 , 'GRX_26_07', 'GRX_26_07', 'Did hostile reactions to incidents that occurred in other countries contribute to government restrictions on religion in the country?', '', '', ''
UNION ALL SELECT 218 , 'GRX_26_08', 'GRX_26_08', 'Did other events, groups or individuals from outside the country contribute to government restrictions on religion in the country?', '', '', ''
UNION ALL SELECT 219 , 'GRX_27_01', 'GRX_27_01', 'There is no reported initiative that aimed to help improve respect for religious freedom in the country.', '', '', ''
UNION ALL SELECT 220 , 'GRX_27_02', 'GRX_27_02', 'Were initiatives reported at the local level that aimed to help improve respect for religious freedom in the country?', '', '', ''
UNION ALL SELECT 221 , 'GRX_27_03', 'GRX_27_03', 'Were initiatives reported at the national level that aimed to help improve respect for religious freedom in the country?', '', '', ''
UNION ALL SELECT 222 , 'GRX_28_01', 'GRX_28_01', 'There is no reported improvement in the respect for religious freedom by any level of the government.', '', '', ''
UNION ALL SELECT 223 , 'GRX_28_02', 'GRX_28_02', 'Was there an improvement reported at the local level in the respect for religious freedom by any level of the government?', '', '', ''
UNION ALL SELECT 224 , 'GRX_28_03', 'GRX_28_03', 'Was there an improvement reported at the national level in the respect for religious freedom by any level of the government?', '', '', ''
UNION ALL SELECT 225 , 'GRX_29_01', 'GRX_29_01', 'Were initiatives or actions reported that aimed to reduce religious restrictions or hostilities in the country?', '', '', ''
UNION ALL SELECT 226 , 'GRX_29_02', 'GRX_29_02', 'Were interfaith dialogues reported that aimed to reduce religious restrictions or hostilities in the country?', '', '', ''
UNION ALL SELECT 227 , 'GRX_29_03', 'GRX_29_03', 'Were antidiscrimination policies of actions reported that aimed to reduce religious restrictions or hostilities in the country?', '', '', ''
UNION ALL SELECT 228 , 'GRX_29_04', 'GRX_29_04', 'Were educational and training initiatives reported that aimed to reduce religious restrictions or hostilities in the country?', '', '', ''
UNION ALL SELECT 229 , 'GRX_29_05', 'GRX_29_05', 'Were land and property initiatives reported that aimed to reduce religious restrictions or hostilities in the country?', '', '', ''
UNION ALL SELECT 230 , 'SHX_14_01', 'SHX_14_01', 'Did a reaction to religious issues trigger the nongovernmental violence related to religion?', '', '', ''
UNION ALL SELECT 231 , 'SHX_14_02', 'SHX_14_02', 'Did a reaction to political issues trigger the nongovernmental violence related to religion?', '', '', ''
UNION ALL SELECT 232 , 'SHX_14_03', 'SHX_14_03', 'Did a reaction to other socio-economic issues trigger the nongovernmental violence related to religion?', '', '', ''
UNION ALL SELECT 233 , 'SHX_14_04', 'SHX_14_04', 'Sources do not specify the immediate triggering situation that led to the nongovernmental violence related to religion.', '', '', ''
UNION ALL SELECT 234 , 'SHX_15_01', 'SHX_15_01', 'Did Christians harass Christians?', '', '', ''
UNION ALL SELECT 235 , 'SHX_15_02', 'SHX_15_02', 'Did Christians harass Muslims?', '', '', ''
UNION ALL SELECT 236 , 'SHX_15_03', 'SHX_15_03', 'Did Christians harass followers of religion(s) other than Christianity or Islam?', '', '', ''
UNION ALL SELECT 237 , 'SHX_15_04', 'SHX_15_04', 'Did Muslims harass Muslims?', '', '', ''
UNION ALL SELECT 238 , 'SHX_15_05', 'SHX_15_05', 'Did Muslims harass Christians?', '', '', ''
UNION ALL SELECT 239 , 'SHX_15_06', 'SHX_15_06', 'Did Muslims harass followers of religion(s) other than Christianity or Islam?', '', '', ''
UNION ALL SELECT 240 , 'SHX_15_07', 'SHX_15_07', 'Did non-specifically identified group(s) harass Christians?', '', '', ''
UNION ALL SELECT 241 , 'SHX_15_08', 'SHX_15_08', 'Did non-specifically identified group(s) harass Muslims?', '', '', ''
UNION ALL SELECT 242 , 'SHX_15_09', 'SHX_15_09', 'Did non-specifically identified group(s) harass followers of religion(s) other than Christianity or Islam?', '', '', ''
UNION ALL SELECT 243 , 'SHX_15_10', 'SHX_15_10', 'Did followers of religion(s) other than Christianity or Islam harass followers of religion(s) other than Christianity or Islam?', '', '', ''
UNION ALL SELECT 244 , 'SHX_28_01', 'SHX_28_01', 'Did religion-related armed conflict that crosses a border contribute to social hostilities involving religion in the country?', '', '', ''
UNION ALL SELECT 245 , 'SHX_28_02', 'SHX_28_02', 'Did religion-related terrorism with cross-border ties or acts contribute to social hostilities involving religion in the country?', '', '', ''
UNION ALL SELECT 246 , 'SHX_28_03', 'SHX_28_03', 'Did the influence of foreign governments contribute to social hostilities involving religion in the country?', '', '', ''
UNION ALL SELECT 247 , 'SHX_28_04', 'SHX_28_04', 'Did problems involving international immigrants contribute to social hostilities involving religion in the country?', '', '', ''
UNION ALL SELECT 248 , 'SHX_28_05', 'SHX_28_05', 'Did extremist influences (alleged or real) contribute to social hostilities involving religion in the country?', '', '', ''
UNION ALL SELECT 249 , 'SHX_28_06', 'SHX_28_06', 'Did hostile reactions to foreign (non-citizen) preachers contribute to social hostilities involving religion in the country?', '', '', ''
UNION ALL SELECT 250 , 'SHX_28_07', 'SHX_28_07', 'Did hostile reactions to incidents that occurred in other countries contribute to social hostilities involving religion in the country?', '', '', ''
UNION ALL SELECT 251 , 'SHX_28_08', 'SHX_28_08', 'Did other events, groups or individuals from outside the country contribute to social hostilities involving religion in the country?', '', '', ''
UNION ALL SELECT 252 , 'XSG_01_xG1', 'XSG_01_xG1', 'Has there been any alleged harassment of Christianity by any level of government or by social groups?', '', '', ''
UNION ALL SELECT 253 , 'XSG_01_xG2', 'XSG_01_xG2', 'Has there been any alleged harassment of Islam by any level of government or by social groups?', '', '', ''
UNION ALL SELECT 254 , 'XSG_01_xG3', 'XSG_01_xG3', 'Has there been any alleged harassment of Buddhism by any level of government or by social groups?', '', '', ''
UNION ALL SELECT 255 , 'XSG_01_xG4', 'XSG_01_xG4', 'Has there been any alleged harassment of Hinduism by any level of government or by social groups?', '', '', ''
UNION ALL SELECT 256 , 'XSG_01_xG5', 'XSG_01_xG5', 'Has there been any alleged harassment of Judaism by any level of government or by social groups?', '', '', ''
UNION ALL SELECT 257 , 'XSG_01_xG6', 'XSG_01_xG6', 'Has there been any alleged harassment of other religions by any level of government or by social groups?', '', '', ''
UNION ALL SELECT 258 , 'XSG_01_xG7', 'XSG_01_xG7', 'Has there been any alleged harassment of ethnic or tribal religions by any level of government or by social groups?', '', '', ''
UNION ALL SELECT 259 , 'XSG_24', 'XSG_24', 'Is there a police force that enforces religious norms?', '', '', ''
UNION ALL SELECT 260 , 'XSG_S_01', 'XSG_S_01', 'Was the country Constitution used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 261 , 'XSG_S_02', 'XSG_S_02', 'Was the  U.S. State Department annual report on International Religious Freedom [current version] used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 262 , 'XSG_S_03', 'XSG_S_03', 'Was the  U.S. State Department annual report on International Religious Freedom [current version minus 1] used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 263 , 'XSG_S_04', 'XSG_S_04', 'Was the  U.S. State Department annual report on International Religious Freedom [current version minus 2] used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 264 , 'XSG_S_05', 'XSG_S_05', 'Was the  U.S. State Department annual report on International Religious Freedom [current version minus 3] used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 265 , 'XSG_S_06', 'XSG_S_06', 'Was the U.S. Commission on International Religious Freedom annual report used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 266 , 'XSG_S_07', 'XSG_S_07', 'Was the U.N. Special Rapporteur on Freedom of Religion or Belief report used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 267 , 'XSG_S_08', 'XSG_S_08', 'Was the Freedom House report used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 268 , 'XSG_S_09', 'XSG_S_09', 'Was the Human Rights Watch topical report used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 269 , 'XSG_S_10', 'XSG_S_10', 'Was the International Crisis Group country report used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 270 , 'XSG_S_11', 'XSG_S_11', 'Was the International Crisis Group CrisisWatch bulletin used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 271 , 'XSG_S_12', 'XSG_S_12', 'Was the United Kingdom Foreign & Commonwealth Office annual report on human rights used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 272 , 'XSG_S_13', 'XSG_S_13', 'Was the Council of the European Union annual report on human rights used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 273 , 'XSG_S_14', 'XSG_S_14', 'Was the Amnesty International report used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 274 , 'XSG_S_15', 'XSG_S_15', 'Was the European Network Against Racism Shadow Report used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 275 , 'XSG_S_16', 'XSG_S_16', 'Was the United Nations High Commissioner for Refugees report used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 276 , 'XSG_S_17', 'XSG_S_17', 'Was the U.S. State Department annual Country Report on Terrorism used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 277 , 'XSG_S_18', 'XSG_S_18', 'Was the TBC source on terrorism used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 278 , 'XSG_S_19', 'XSG_S_19', 'Was the Anti-Defamation League report used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 279 , 'XSG_S_20', 'XSG_S_20', 'Was the U.S. State Department Country Reports on Human Rights Practices used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 280 , 'XSG_S_21', 'XSG_S_21', 'Was the Uppsala University’s Uppsala Conflict Data Program, Armed Conflict Database used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 281 , 'XSG_S_22', 'XSG_S_22', 'Was the Human Rights Without Frontiers “Freedom of Religion or Belief” newsletters used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 282 , 'XSG_S_23', 'XSG_S_23', 'Was the Hudson Institute publication: “Religious Freedom in the World” (Paul Marshall) used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 283 , 'XSG_S_99_filter', 'XSG_S_99_filter', 'How many other sources were used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 284 , 'XSG_S_99_01', 'XSG_S_99_01', 'Was any other source [1] used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 285 , 'XSG_S_99_02', 'XSG_S_99_02', 'Was any other source [2] used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 286 , 'XSG_S_99_03', 'XSG_S_99_03', 'Was any other source [3] used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 287 , 'XSG_S_99_04', 'XSG_S_99_04', 'Was any other source [4] used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 288 , 'XSG_S_99_05', 'XSG_S_99_05', 'Was any other source [5] used for coding government restrictions and social hostilities on religion?', '', '', ''
UNION ALL SELECT 289 , 'XSG_S_99_06', 'XSG_S_99_06', 'Was any other source [6] used for coding government restrictions and social hostilities on religion?', '', '', ''
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/***************************************************************************************************************************************************************/
