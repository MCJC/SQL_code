/*****************************************************************************************************************************************/
USE [forum]
GO

/*****************************************************************************************************************************************/
/*****                                                   Load changes - Temp Table                                                   *****/
/*****************************************************************************************************************************************/
--UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Albania' , [E] = 'GRI_11_xG1' , [F] = 1 , [G] = '[text does not need to change]'
--UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Bangladesh' , [E] = 'GRI_11_xG1' , [F] = 1 , [G] = '[text does not need to change]'
--UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Equatorial Guinea' , [E] = 'GRI_11_xG1' , [F] = 1 , [G] = 'Some non-Catholic clergy, who also worked for the government as civil service employees, continued to report their supervisors strongly encouraged participation in religious activities related to their government positions, including attending Catholic masses. (IRF 2014)'
--UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Equatorial Guinea' , [E] = 'GRI_11_xG1' , [F] = 1 , [G] = '[text does not need to change]'
--UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Fiji' , [E] = 'GRI_11_xG1' , [F] = 1 , [G] = '[text does not need to change]'
--UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Moldova' , [E] = 'GRI_11_xG1' , [F] = 1 , [G] = '[text does not need to change]'
--UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Pakistan' , [E] = 'GRI_11_xG1' , [F] = 1 , [G] = '[text does not need to change]'
--UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Tanzania' , [E] = 'GRI_11_xG1' , [F] = 1 , [G] = '[text does not need to change]'
/***************************************************************************************************************************************************************/
  IF OBJECT_ID('tempdb..[#MYTEMPTABLE]') IS NOT NULL
  DROP TABLE            [#MYTEMPTABLE]
  SELECT * INTO         [#MYTEMPTABLE] FROM
(
          SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'afghanistan' , [E] = 'GRI_09' , [F] = 0.5 , [G] = 'The media law prohibits the production, reproduction, printing, and publishing of works and materials contrary to the principles of Islam or offensive to other religions and denominations. It also prohibits publicizing and promoting religions other than Islam, and articles and topics that harm the physical, spiritual, and moral well-being of persons, especially children and adolescents. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'afghanistan' , [E] = 'GRI_17' , [F] = 1 , [G] = 'According to the General Directorate of Fatwas and Accounts under the Supreme Court, the Bahai Faith is distinct from Islam and a form of blasphemy. Furthermore, all Muslims who convert to it are considered apostates, and Bahai practitioners are labeled as infidels. The Bahai community has stated there is legal discrimination against it, particularly on the question of marriages between Bahai women and Muslim men. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Australia' , [E] = 'GRI_05' , [F] = 1 , [G] = 'Antiterrorism laws bar mosques and Islamic schools from spreading anti-Australian messages. FH 2014'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'brunei' , [E] = 'SHI_07' , [F] = 1 , [G] = 'The constitution states that while the official religion is the Shafi‰Ûªi school of Islam, all other religions may be practiced in peace and harmony. The government permitted Shafi‰Ûªi Muslims and members of longstanding religious minorities to practice their faiths. The government began to implement the first of three phases of the Sharia Penal Code (SPC) in parallel with the existing common law-based criminal justice system, which remains in place. Phase one of the SPC primarily involves offenses punished by fines or imprisonment. It expands existing restrictions on drinking alcohol, eating in public during the fasting hours of Ramadan, cross-dressing, and propagating religions other than Islam, and it prohibits "indecent behavior." (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'brunei' , [E] = 'SHI_11' , [F] = 1 , [G] = 'There was no legal requirement for women to wear head coverings in public; however, religious authorities reinforced social customs to encourage Muslim women to wear the tudong, a traditional head covering, and many women did so. Women employed by the government were expected to wear a tudong to work. In government schools and institutions of higher learning, Muslim female students were required to wear a uniform which included a head covering. Male students were expected to wear the songkok (hat), although this was not required in all schools. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Bulgaria' , [E] = 'SHI_06' , [F] = 0.67 , [G] = 'In January Jehovah''s Witnesses reported that the neighbors of a member of the Jehovah''s Witnesses living in Kazanluk threw stones at his home at the instigation of a local pastor. (IRF 2013)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Burma (Myanmar)' , [E] = 'GRI_16' , [F] = 0.67 , [G] = 'The government bans any organization of Buddhist monks other than nine state-recognized monastic orders. Violations of this ban are punishable by immediate public defrocking and criminal penalties. The nine recognized orders submit to the authority of the State Sangha Monk Coordination Committee (SSMNC), the members of which are elected by monks.'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'chad' , [E] = 'GRI_03' , [F] = 0.33 , [G] = 'The independent High Council for Islamic Affairs (HCIA) oversaw Islamic religious activities, including some Arabic language schools and institutions of higher learning, and represented the country at international Islamic forums. In coordination with the president, the HCIA appointed the grand imam, who was confirmed by the president. The grand imam oversaw each region‰Ûªs high imam and served as head of the council. He had the authority to restrict Muslim groups from proselytizing, regulate the content of mosque sermons, and control activities of Muslim charities, although he did not exercise it. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'chad' , [E] = 'GRI_20_02' , [F] = 0.5 , [G] = 'The independent High Council for Islamic Affairs (HCIA) oversaw Islamic religious activities, including some Arabic language schools and institutions of higher learning, and represented the country at international Islamic forums. In coordination with the president, the HCIA appointed the grand imam, who was confirmed by the president. The grand imam oversaw each region‰Ûªs high imam and served as head of the council. He had the authority to restrict Muslim groups from proselytizing, regulate the content of mosque sermons, and control activities of Muslim charities, although he did not exercise it. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Germany' , [E] = 'GRI_05' , [F] = 1 , [G] = 'The federal and state OPCs in Baden-Wuerttemberg, Bavaria, Berlin, Bremen, Hamburg, Lower Saxony, NRW, and Thuringia monitored the activities of the COS, reportedly focusing on evaluating Scientology publications and public activities to determine whether they violated the constitution. The COS reported OPC representatives regularly contacted Scientologists to question them about the organization. The COS also reported the OPC collected names of members from church publications and archived the information to use in citizenship and employment proceedings'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Germany' , [E] = 'GRI_08' , [F] = 1 , [G] = 'The federal and state OPCs in Baden-Wuerttemberg, Bavaria, Berlin, Bremen, Hamburg, Lower Saxony, NRW, and Thuringia monitored the activities of the COS, reportedly focusing on evaluating Scientology publications and public activities to determine whether they violated the constitution. The COS reported OPC representatives regularly contacted Scientologists to question them about the organization. The COS also reported the OPC collected names of members from church publications and archived the information to use in citizenship and employment proceedings'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Germany' , [E] = 'GRI_18 ' , [F] = 1 , [G] = 'The Basic Law provides for freedom of faith and conscience and the freedom to profess a religious creed and practice one''s religion. The Basic Law also prohibits a state church. As provided in the Basic Law, religious groups are not required to register with the state, and groups may organize themselves for private religious purposes without constraint. Religious groups wishing to qualify as nonprofit associations with tax exempt status must register. State-level authorities review registration submissions and routinely grant tax-exempt status; if challenged, their decisions are subject to judicial review. Groups applying for tax-exempt status must provide evidence through their statutes, history, and activities that they are a religious group. A special partnership exists between the state and religious groups with "public law corporation" (PLC) status, as outlined in the Basic Law. Any religious group may request PLC status, which entitles the group to appoint prison, hospital, and military chaplains and to levy tithes (averaging 9 percent of income tax), which the state collects on its behalf. PLCs pay fees to the government for the tithing service, but not all groups use it. PLC status also allows for tax exemptions and representation on supervisory boards of public television and radio stations.'
UNION ALL SELECT [A] = 0.33 , [B] = 'yes' , [C] = '[TEXTSHOULDBEEDITED]' , [D] = 'Germany' , [E] = 'SHI_07' , [F] = 1 , [G] = 'The authorities and nongovernmental organizations (NGOs) attributed most anti-Semitic acts to neo-Nazi or other right-wing groups or individuals, some of whom claimed Jews were the cause of negative modern social and economic trends. NGOs monitoring and working to counter anti-Semitism reported a rising anti-Semitic trend among Muslim youth, who were increasingly involved in attacks on and harassment of Jews. Federal authorities generally took action against anti-Semitic offenses ... In November perpetrators left five bloody pig heads at the site where the Ahmadiyya Muslim Community planned to build Leipzig‰Ûªs first mosque. The major political parties and Leipzig''s mayor quickly condemned the attack. In October local residents and the right-wing extremist National Democratic Party protested the city''s approval of plans to build the mosque. (IRF 2013)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Greece' , [E] = 'SHI_08' , [F] = 1 , [G] = 'he Greek Orthodox Church exercised significant social, political, and economic influence. Some non-Orthodox citizens complained they had been treated with suspicion or had been told they were not truly Greek when they had revealed their religious affiliations. Members of non-Orthodox religious groups, particularly missionary-based groups, reported incidents of societal discrimination, including warnings by some Orthodox bishops and priests to their parishioners not to visit the leaders or members of religious groups such as Jehovah''s Witnesses, Mormons, evangelical Christians, and other Protestants. However, leaders of many non-Orthodox religious groups reported cordial private contacts between Orthodox Church officials and members of minority religious groups. Orthodox leaders also attended ceremonies hosted by members of other religious groups. (IRF 2013)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Greece' , [E] = 'SHI_11' , [F] = 1 , [G] = 'The Racist Violence Recording Network documented attacks against 190 victims from October 2011 to December 2012, but the total number was believed to be higher because migrants without legal status often feared reporting such incidents. Two cases involved women wearing the hijab. In some cases the victims or witnesses reported that they recognized Golden Dawn insignia on the attackers'' clothing. (IRF 2012).'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'iceland' , [E] = 'GRI_06' , [F] = 1 , [G] = 'The Reykjavik City Council prohibits religious and secular humanist groups from conducting any activities, including the distribution of proselytizing material, in municipal preschools and compulsory schools (grades one through 10) during school hours. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'iceland' , [E] = 'GRI_07' , [F] = 1 , [G] = 'y law, parents control the affiliation of their children to religious or secular humanist groups until the age of 16. Change in affiliation of children under age 16 requires the consent of both parents if both have custody; if only one parent has custody, the consent of the noncustodial parent is not required. The law requires parents to consult their children about any changes in the child''s affiliation after the age of 12. (irf 2014)'
UNION ALL SELECT [A] = 0.33 , [B] = 'yes' , [C] = '[TEXTSHOULDBEEDITED]' , [D] = 'Iceland' , [E] = 'GRI_18 ' , [F] = 1 , [G] = 'Religious groups and secular humanist organizations apply to the MOI for recognition and registration. By law, a four-member panel reviews the applications. The chairman of the panel is nominated by a university law faculty, and the other three members are nominated by the University of Iceland‰Ûªs Department of Social and Human Sciences, Department of Theology and Religious Studies, and Department of History and Philosophy, respectively. To register, a religious group must ''practice a creed or religion'' and a secular philosophical organization must operate in accordance with certain ethical values, and ''deal with ethics or epistemology in a prescribed manner.'' Religious groups and secular organizations must also be well established; be active and stable; not have a purpose that "violates the law or is prejudicial to good morals or public order"; and have a core group of members who participate in its operations, support the values of the organization in compliance with its teachings, and pay church taxes in accordance with the law'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'iceland' , [E] = 'GRI_20_03_A' , [F] = 1 , [G] = 'By law, school grades one through 10 (ages 6-15) in public and private schools must include instruction in social studies, which includes subjects such as Christianity, ethics, and theology. The law also mandates the teaching of "the Christian heritage of Icelandic culture, equality, democratic cooperation, responsibility, concern, forgiveness, and respect for human values." (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'iceland' , [E] = 'GRI_20_04' , [F] = 1 , [G] = 'By law, school authorities may exempt pupils from instruction in compulsory subjects such as Christianity, ethics, and theology. To exempt students, parents must submit a written application to the school principal. The principal may request additional information if necessary. For both approved and denied cases, the principal then registers the application as a "special case" and writes an official response to the parents. School authorities are not required to offer other religious or secular instruction in place of these classes. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'iceland' , [E] = 'GRI_20_05' , [F] = 1 , [G] = 'The official state religion is Lutheranism. The constitution establishes the ELC as the national church and grants it state support and protection. The state operates a network of Lutheran parish churches throughout the country, and the Lutheran bishop appoints ELC ministers to these parishes. The state directly pays the salaries of the 130 ministers in the national church, who are considered public servants under the MOI. State radio broadcasts Lutheran worship services every Sunday morning as well as daily morning and evening devotions. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Iran' , [E] = 'GRI_09 ' , [F] = 0.5 , [G] = 'Non-Muslims may not engage in public religious expression, persuasion, or conversion of Muslims. Such activities are considered proselytizing and are punishable by death. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Iran' , [E] = 'GRI_13 ' , [F] = 1 , [G] = 'The law authorizes collection of blood money as restitution to families for the death of Muslims and protected minorities. According to law, Bahai blood can be spilled with impunity, and Bahai families are not entitled to restitution. (irf 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Iran' , [E] = 'GRI_14' , [F] = 1 , [G] = 'The Ministry of Culture and Islamic Guidance (Ershad) and the Ministry of Intelligence and Security (MOIS) closely monitor religious activity, while churches fall under the oversight of the Islamic Revolutionary Guard Corps (IRGC). The government closely monitors and regulates Christian religious practice. All churchgoers must register with the authorities, who prevent Muslim converts to Christianity from entering Armenian or Assyrian churches, according to UN Special Rapporteur for Human Rights in Iran Ahmed Shaheed. The government also requires Bahais to register with the police. - See more at: http://www.state.gov/j/drl/rls/irf/religiousfreedom/index.htm#wrapper'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Iran' , [E] = 'GRI_18 ' , [F] = 1 , [G] = 'The Ministry of Culture and Islamic Guidance (Ershad) and the Ministry of Intelligence and Security closely monitor religious activity. The government does not require members of some recognized religious minorities to register as a precondition for effective operation or lawful existence, but the authorities closely monitor their communal, religious, and cultural events and organizations, including schools. The government requires evangelical Christian congregations to compile and submit membership lists. The government requires Bahais to register with the police. (IRF 2013)'
UNION ALL SELECT [A] = 0.33 , [B] = 'yes' , [C] = '[TEXTSHOULDBEEDITED]' , [D] = 'Iran' , [E] = 'SHI_06' , [F] = 1 , [G] = 'Unknown actors desecrated Bahai graveyards, according to Bahai organizations. The government did not seek to identify or punish the perpetrators. There were reported problems for Bahais at different levels of society around the country. Bahais experienced continued personal harassment, and there were reported cases of Bahai children being harassed in school and subjected to Islamic indoctrination. Non-Bahai were often pressured to refuse employment to Bahais and to dismiss Bahais from their employment in the private sector.There were reports of Shia clerics and prayer leaders denouncing Sufism and the activities of Sufis in the country in both sermons and public statements. Many Jews reportedly sought to limit their contact with or support for the state of Israel due to fear of reprisal. In early January news outlets reported that the Jewish community was fearful following the December 2012 murder of Daniel Mahgerefteh, an Iranian Jewish man reportedly in a romantic relationship with the daughter of a member of the IRGC. Although authorities maintained that Mahgerefteh was killed in a robbery, some members of the Jewish community stated there were inconsistencies in the official account and suspected the daughter was complicit in the killing[...]he family of Ataollah Rezvani, a Bahai killed on August 24 in Bandar Abbas, reported that the investigating judge had discounted religiously motivated murder as the cause of death and was pursuing either suicide or murder without religious motivation as the cause, although no progress on the investigation had been reported at year''s end. Rezvani was reportedly shot in the back of the head. A relative discounted robbery and revenge as motives due to several circumstances of the crime and stated that Rezvani was targeted because he was Bahai. A local imam had reportedly spoken against the Bahai community in his sermons on several occasions, including several days before Rezvani‰Ûªs death. The investigation was pending at year''s end.(IRF 2013)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Nepal' , [E] = 'SHI_02' , [F] = 1 , [G] = 'On February 7, clashes occurred between Hindus and Muslims in the Rautahat district in the southern part of the country, leading to some minor injuries and the damage or destruction of 48 houses and other personal property belonging to members of the Muslim community. The clashes were triggered by the reported refusal of Muslims to allow Hindus to conduct a ritual procession in a predominantly Muslim area (in previous years, Hindu devotees followed a different route for the procession). After the incident, the local district administration mediated between leaders of the two communities and arranged for compensation for those whose homes were damaged or destroyed. There were no other incidents reported during the year. - See more at: http://www.state.gov/j/drl/rls/irf/religiousfreedom/index.htm#wrapper'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Nepal' , [E] = 'SHI_07' , [F] = 1 , [G] = 'In September activists from the World Hindu Federation reportedly threatened an artist in Kathmandu for ‰ÛÏoutrageous portrayals‰Û of Hindu gods at an exhibition of his works at a local art gallery. A case was filed at the district administration office accusing the artist of blasphemy and the police responded by padlocking the gallery. The charges were dropped after the gallery removed the exhibition. | Christian groups reported that "Hindu extremism" continued. In July police arrested two individuals from a criminal organization who threatened to bomb churches and kidnap church leaders if the churches did not meet their extortion demands. In August a Catholic church reported threatening phone calls from an alleged radical Hindu group demanding money. Church leaders said authorities were very responsive to their reports of the threat. (IRF 2012)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Pakistan' , [E] = 'GRI_12' , [F] = 1 , [G] = 'According to Ahmadiyya community members, between 1984 (when the "anti-Ahmadi laws" were promulgated) and 2014, authorities sealed 33 Ahmadiyya mosques and barred construction of 52 mosques, while assailants demolished or damaged 31 Ahmadiyya mosques, set 14 mosques on fire, and forcibly occupied 19 mosques. - See more at: http://www.state.gov/j/drl/rls/irf/religiousfreedom/index.htm#wrapper'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Pakistan' , [E] = 'GRI_17 ' , [F] = 1 , [G] = 'According to the constitution and penal code, Ahmadis are not Muslims and are prohibited from calling themselves Muslims or their belief Islam, as well as from preaching or propagating their religious beliefs, proselytizing, or insulting the religious feelings of Muslims. The punishment for violation of these provisions is imprisonment for up to three years and a fine'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Pakistan' , [E] = 'GRI_19_D' , [F] = 714548 , [G] = 'In August 2014, there were 714,548 registered internally displaced people (IDPs) in need of humanitarian assistance due to the ongoing security operations in the Federally Administered Tribal Areas (FATA) and Khyber Pakhtunkhwa. The North Waziristan emergency has further displaced approximately 500,000 people. - http://www.unhcr.org/pages/49e487016.html'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Romania' , [E] = 'SHI_12' , [F] = 1 , [G] = 'There were reports of societal discrimination based on religious affiliation, belief, or practice. There were cases in which some Orthodox clergy showed hostility toward non-Orthodox church religious groups, criticized their proselytizing activities, and denied them access to cemeteries.(IRF 2012)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Russia' , [E] = 'SHI_05_F' , [F] = 167 , [G] = 'UCDP, Forces of Caucusus Emirate'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Rwanda' , [E] = 'GRI_05' , [F] = 1 , [G] = 'The government limited the types of locations where religious groups could assemble, at times citing municipal zoning regulations as the reason."'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Rwanda' , [E] = 'GRX_22_04' , [F] = 1 , [G] = 'The law establishes fines of 20,000 to one million Rwandan francs ($29 to $1,450) and imprisonment from eight days to five years for anyone who hinders the free practice of religion; publicly humiliates rites, symbols, or objects of religion; or insults, threatens, or physically assaults a religious leader'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Saudi Arabia' , [E] = 'SHI_07' , [F] = 1 , [G] = 'Religious vigilantes and/or volunteers unaffiliated with the CPVPV also exist but often act alone, sometimes even harassing and assaulting citizens and foreigners. For example, in early March at the annual Riyadh Book Fair a group of conservative preachers circulated among the booths instructing foreign women to cover their hair. Some loudly confronted the minister of culture and information for selling books they claimed were destructive to Islam and for allowing female journalists to attend the event. The CPVPV issued a press statement denying any affiliation with these individuals and clarified that members of the organization all carry badges and are escorted by police officers. (IRF 2011)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Saudi Arabia' , [E] = 'SHI_11' , [F] = 1 , [G] = 'Religious vigilantes and/or ''volunteers'' unaffiliated with the CPVPV sometimes harassed and assaulted citizens and foreigners. In Najran, a group of young men, known as religious vigilantes, used social media sites to warn women to wear veils and travel with a male guardian or risk being lashed with a stick. On May 12, the CPVPV branch in Najran denied any affiliation with the group. - See more at: http://www.state.gov/j/drl/rls/irf/religiousfreedom/index.htm#wrapper'
UNION ALL SELECT [A] = 0.33 , [B] = 'yes ' , [C] = '[TEXTSHOULDBEEDITED]' , [D] = 'Vietnam' , [E] = 'SHI_06' , [F] = 0.67 , [G] = 'On September 16, the managing council of the sanctioned Cao Dai along with hired thugs assaulted followers of the unsanctioned Cao Dai religion in Phu My Oratory, which is under the Chon Truyen Conservative Religious Society in Binh Dinh Province. A total of six followers suffered injuries. (IRF 2012)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Albania' , [E] = 'GRI_11' , [F] = 1 , [G] = 'During the year, negotiations continued to resolve a 2013 case in which private bailiffs hired by the city of Permet forcibly removed several Orthodox clergy members and religious artifacts from a disputed property (IRF 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Albania' , [E] = 'GRI_11_01a' , [F] = 1 , [G] = '[text does not need to change]'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Bangladesh' , [E] = 'GRI_11_02' , [F] = 1 , [G] = 'Asia News (25.11.2014) - Two Protestant clergymen are awaiting trial in Bangladesh on charges of inducing Muslims to convert. The incident occurred in mid-November when some 200 Muslims attacked the Christian religious leaders - anonymous for security reasons. The two clergymen, who belong to Faith Bible Church of God, were celebrating baptisms in the northern district of Lalmonirhat, 341 kilometres from Dhaka. (HRWF 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Equatorial Guinea' , [E] = 'GRI_11_03' , [F] = 1 , [G] = '[text does not need to change]'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Fiji' , [E] = 'GRI_11' , [F] = 1 , [G] = 'In August the government lifted all remaining restrictions on the Methodist Church’s annual conference, fundraising bazaar, and choir competition. In September, however, the prime minister accused the church of conducting political activities in opposition to his government (IRF 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Fiji' , [E] = 'GRI_11_02' , [F] = 1 , [G] = '[text does not need to change]'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Moldova' , [E] = 'GRI_11_11' , [F] = 1 , [G] = '[text does not need to change]'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Pakistan' , [E] = 'GRI_11_02' , [F] = 1 , [G] = '[text does not need to change]'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[TEXTSHOULDBEADDED]' , [D] = 'Tanzania' , [E] = 'GRI_11' , [F] = 1 , [G] = 'Some inmates were reportedly forced to worship in denominations chosen for them by prison wardens. Seventh-day Adventists reported they had to work on Saturday. (IRF 2014)'
UNION ALL SELECT [A] = 0 , [B] = 'None' , [C] = '[text does not need to change]' , [D] = 'Tanzania' , [E] = 'GRI_11_11' , [F] = 1 , [G] = '[text does not need to change]'
) MYUPDATES
/***************************************************************************************************************************************************************/
  IF OBJECT_ID('tempdb..[#CURRTDBVALS]') IS NOT NULL
  DROP TABLE            [#CURRTDBVALS]
  SELECT * INTO         [#CURRTDBVALS] FROM
       ( SELECT  *  FROM [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
                   WHERE [Question_Year] = 2014                                 ) y
/***************************************************************************************************************************************************************/
IF OBJECT_ID (N'[GRSHRResults]..[LINKEDTABLE]', N'U') IS NOT NULL
DROP TABLE      [GRSHRResults]..[LINKEDTABLE]
SELECT * INTO   [GRSHRResults]..[LINKEDTABLE]
FROM  (
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
       [r]                     = ROW_NUMBER()OVER(ORDER BY [sort], [F]  )
	  ,[class]                 = xy.[sort]
	  ,[QA_std]                = xy.[QA_std]              --  x.[E]
      ,[Ctry]                  = xy.[Ctry_EditorialName]  --  x.[D]
      ,[currAns_fk]            = xy.[Answer_fk]
      ,[currAnsVal]            = xy.[Answer_value]
      ,[updtAnsVal]            = xy.[F]
      ,[currAnsWrd]            = xy.[answer_wording]
      ,[updtAnsWrd]            = xy.[G]
      ,[11_NRA_lk]             = CASE WHEN xy.[sort] = 1   THEN xy.[link_fk]        END
      ,[11_updtAns_fk]         = CASE WHEN xy.[sort] = 1   THEN A1.[Answer_pk]      END
      ,[xx_updtAnsWrd]         = CASE WHEN xy.[sort] = 1   THEN A1.[Answer_Wording] END
      ,[21_AnsNSK]             = CASE WHEN xy.[sort] = 2   THEN xy.[Answer_fk]      END
      ,[21_updtAnsVal]         = CASE WHEN xy.[sort] = 2   THEN xy.[F]              END
      ,[21_updtAnsWrd]         = CASE WHEN xy.[sort] = 2   THEN xy.[G]              END
      ,[21_updtAnsStK]         = CASE WHEN xy.[sort] = 2   THEN A3.[Answer_Std_fk]  END
      ,[31_new_AnsNSK]         = CASE WHEN xy.[sort] > 3   THEN xy.[ADDK]           END
      ,[31_new_AnsVal]         = CASE WHEN xy.[sort] > 3   THEN xy.[F]              END
      ,[31_new_AnsWrd]         = CASE WHEN xy.[sort] > 3   THEN xy.[G]              END
      ,[31_new_AnsStK]         = CASE WHEN xy.[sort] > 3   THEN A4.[Answer_Std_fk]  END
      ,[31_new_QueNSK]         = CASE WHEN xy.[sort] > 3   THEN xy.[Question_fk]    END
      ,[41_NA_lk]              = CASE WHEN xy.[sort] = 3.1 THEN xy.[link_fk]        END
      ,[41_updtAns_fk]         = CASE WHEN xy.[sort] = 3.1 THEN xy.[ADDK]           END
      ,[42_NRA_lk]             = CASE WHEN xy.[sort] = 3.2 THEN xy.[link_fk]        END
      ,[42_updtAns_fk]         = CASE WHEN xy.[sort] = 3.2 THEN xy.[ADDK]           END
      ,[43_LA_lk]              = CASE WHEN xy.[sort] = 3.3 THEN xy.[link_fk]        END
      ,[43_updtAns_fk]         = CASE WHEN xy.[sort] = 3.3 THEN xy.[ADDK]           END
      ,[TASK]                  = CASE WHEN xy.[sort] = 1   THEN 'updt Ans_fk-PNRA'
                                      WHEN xy.[sort] = 2   THEN 'updt 3Vals -PANS'
                                      WHEN xy.[sort] = 3.1 THEN '+5V-PANS uK-PNAn'
                                      WHEN xy.[sort] = 3.2 THEN '+5V-PANS uK-PNRA'
                                      WHEN xy.[sort] = 3.3 THEN '+5V-PANS uK-PLAn'  END
  FROM 
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
       ( SELECT        [sort] = CASE
                                WHEN x.[G]             = '[text does not need to change]'
                                 AND y.[Answer_value]  = 0                              THEN 1
                                WHEN x.[G]            != '[text does not need to change]'
                                 AND y.[Answer_value] != 0                              THEN 2
                                WHEN x.[G]            != '[text does not need to change]'
                                 AND y.[Answer_value]  = 0
                                 AND y.[entity]        = 'Ctry'                         THEN 3.1
                                WHEN x.[G]            != '[text does not need to change]'
                                 AND y.[Answer_value]  = 0
                                 AND y.[entity]        = 'RGrp'                         THEN 3.2
                                WHEN x.[G]            != '[text does not need to change]'
                                 AND y.[Answer_value]  = 0
                                 AND y.[entity]        = 'Prov'                         THEN 3.3 END
                      ,[ADDK] = CASE
                                WHEN x.[G]            != '[text does not need to change]'
                                 AND y.[Answer_value]  = 0                            
                                THEN ROW_NUMBER() OVER(ORDER BY [F],[E],[D])
	                               + (SELECT MAX(Answer_pk) FROM [forum]..[Pew_Answer_NoStd])    END
                      ,*
	              FROM [#MYTEMPTABLE] x
            INNER JOIN [#CURRTDBVALS] y
                  ON x.[E] = y.[QA_std]
                 AND x.[D] = y.[Ctry_EditorialName]  )                                              xy
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
       ( SELECT * FROM [forum].[dbo].[Pew_Answer_NoStd]
                 WHERE [Question_fk]
                                     IN ( SELECT DISTINCT [Question_fk]
									                 FROM [#CURRTDBVALS] ) )                         A1
         ON A1.[Question_fk]        = CASE WHEN  xy.[sort] = 1 THEN xy.[Question_fk]
                                                               ELSE 0                END
        AND A1.[Answer_value_NoStd] =                               xy.[F] -- ([updtAnsVal])
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
       ( SELECT * FROM [forum].[dbo].[Pew_Answer_NoStd]
                 WHERE [Question_fk]
                                     IN ( SELECT DISTINCT [Question_fk]
									                 FROM [#CURRTDBVALS] ) )                         A2
         ON A2.[Question_fk]        = CASE WHEN  xy.[sort] = 2 THEN xy.[Question_fk]
                                                               ELSE 0                END
        AND A2.[Answer_value_NoStd] =            xy.[Answer_value]
        AND A2.[Answer_Wording]     =            xy.[answer_wording]
        AND A2.[Answer_pk]          =            xy.[Answer_fk]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
       ( SELECT * FROM [forum].[dbo].[Pew_Q&A_Std]
                 WHERE [Question_Std_fk]
                                     IN ( SELECT DISTINCT [Question_Std_fk]
									                 FROM [#CURRTDBVALS] ) )                         A3
         ON A3.[Question_Std_fk]    = CASE WHEN  xy.[sort] = 2 THEN xy.[Question_Std_fk]
                                                               ELSE 0                END
        AND A3.[Answer_value_std]   =            xy.[F]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
       ( SELECT * FROM [forum].[dbo].[Pew_Q&A_Std]
                 WHERE [Question_Std_fk]
                                     IN ( SELECT DISTINCT [Question_Std_fk]
									                 FROM [#CURRTDBVALS] ) )                         A4
         ON A4.[Question_Std_fk]    = CASE WHEN  xy.[sort] > 3 THEN xy.[Question_Std_fk]
                                                               ELSE 0                END
        AND A4.[Answer_value_std]   = CASE WHEN  xy.[F]    > 1 THEN 1
                                                               ELSE xy.[F]           END
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                                                                                                                  ) MYSOURCEDATA
/***************************************************************************************************************************************************************/
-- 1.     changes on [Pew_Nation_Religion_Answer]
-- 1.1.   ONLY    on [Pew_Nation_Religion_Answer]
---------- [Nation_religion_answer_pk]             same
---------- [Nation_fk]                             same
---------- [Religion_group_fk]                     same
---------- [Answer_fk]                             --->  UPDATE
---------- [display]                               same

-- 2.     changes on [Pew_Answer_NoStd]
-- 2.1.   ONLY    on [Pew_Answer_NoStd]
---------- [Answer_pk]                             same
---------- [Answer_value_NoStd]                    --->  UPDATE
---------- [Answer_Wording]                        --->  UPDATE
---------- [Answer_Std_fk]                         --->  UPDATE
---------- [Question_fk]                           same

-- 3.     additions to [Pew_Answer_NoStd]
-- 3.1.   add to [Pew_Answer_NoStd]
---------- [Answer_pk]                             --->  calculate
---------- [Answer_value_NoStd]                    --->  UPDATE
---------- [Answer_Wording]                        --->  UPDATE
---------- [Answer_Std_fk]                         --->  match
---------- [Question_fk]                           --->  UPDATE

-- 4.     changes on answer tables
-- 4.1.   update  on [Pew_Nation_Answer]
---------- [Nation_answer_pk]                      same
---------- [Nation_fk]                             same
---------- [Answer_fk]                             --->  UPDATE
---------- [display]                               same
-- 4.2.   update  on [Pew_Nation_Religion_Answer]
---------- [Nation_religion_answer_pk]             same
---------- [Nation_fk]                             same
---------- [Religion_group_fk]                     same
---------- [Answer_fk]                             --->  UPDATE
---------- [display]                               same
-- 4.3.   update  on [Pew_Locality_Answer]
---------- [Locality_answer_pk]                    same
---------- [Locality_fk]                           same
---------- [Answer_fk]                             --->  UPDATE
---------- [display]                               same
/*****************************************************************************************************************************************/
--         SELECT * FROM   [GRSHRResults]..[LINKEDTABLE]
/*****************************************************************************************************************************************/
/*****                                                     BackUp current Tables                                                     *****/
/*****************************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  DECLARE                          --  declare variable
          @TofI                    --  variable name
                   varchar(50)     --  data type of the variable
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
   DECLARE                                -- declare the cursor
              MyCursor                    -- cursor name
                             CURSOR FOR   -- as a cursor to take values from
                 SELECT 'Pew_Answer_NoStd'
           UNION SELECT 'Pew_Nation_Answer'
           UNION SELECT 'Pew_Nation_Religion_Answer'
           UNION SELECT 'Pew_Locality_Answer'
/*****************************************************************************************************************************************/
   OPEN                                      -- open
              MyCursor                       -- cursor name
	FETCH NEXT                               -- retrieve the next row
          FROM                               -- from cursor
                 MyCursor                    -- cursor name
          INTO                               -- store it into the variable(s)
                 @TofI                       --  variable name
			 WHILE  @@FETCH_STATUS = 0
					BEGIN
EXEC ( ' SELECT *
                INTO  [_bk_forum].[dbo].[' + @TofI + '_' + @CrDt + ']
                FROM      [forum].[dbo].[' + @TofI               + ']' )
	FETCH NEXT                               -- retrieve the next row
          FROM                               -- from cursor
                 MyCursor                    -- cursor name
          INTO                               -- store it into the variable(s)
                 @TofI                       --  variable name
					END
   CLOSE                                  -- close
              MyCursor                    -- cursor name
DEALLOCATE                                -- remove reference and relase from memory
              MyCursor                    -- cursor name
/*****************************************************************************************************************************************/
/*****************************************************************************************************************************************/
/*****************************************************************************************************************************************/
-- 1.     changes on [Pew_Nation_Religion_Answer]
-- 1.1.   ONLY    on [Pew_Nation_Religion_Answer]
---------- [Nation_religion_answer_pk]             same
---------- [Nation_fk]                             same
---------- [Religion_group_fk]                     same
---------- [Answer_fk]                             --->  UPDATE
---------- [display]                               same
/*****************************************************************************************************************************************/
	UPDATE
           [forum].[dbo].[Pew_Nation_Religion_Answer]
	SET                                               [Answer_fk]       = mynew.[11_updtAns_fk]
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--select *
FROM
           [forum].[dbo].[Pew_Nation_Religion_Answer]               AS mydbt
 JOIN      [GRSHRResults]..[LINKEDTABLE]                            AS mynew
ON
           mydbt.[Nation_religion_answer_pk]
       =   mynew.[11_NRA_lk]
GO
/*****************************************************************************************************************************************/
-- 2.     changes on [Pew_Answer_NoStd]
-- 2.1.   ONLY    on [Pew_Answer_NoStd]
---------- [Answer_pk]                             same
---------- [Answer_value_NoStd]                    --->  UPDATE
---------- [Answer_Wording]                        --->  UPDATE
---------- [Answer_Std_fk]                         --->  UPDATE
---------- [Question_fk]                           same
/*****************************************************************************************************************************************/
	UPDATE
           [forum].[dbo].[Pew_Answer_NoStd]
	SET                                               [Answer_value_NoStd]   = mynew.[21_updtAnsVal]
                                                    , [Answer_Wording]       = mynew.[21_updtAnsWrd]
                                                    , [Answer_Std_fk]        = mynew.[21_updtAnsStK]
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--select *
FROM
           [forum].[dbo].[Pew_Answer_NoStd]                         AS mydbt
 JOIN      [GRSHRResults]..[LINKEDTABLE]                            AS mynew
ON
           mydbt.[Answer_pk]
       =   mynew.[21_AnsNSK]
GO
/*****************************************************************************************************************************************/
-- 3.     additions to [Pew_Answer_NoStd]
-- 3.1.   add to [Pew_Answer_NoStd]
---------- [Answer_pk]                             --->  calculate
---------- [Answer_value_NoStd]                    --->  UPDATE
---------- [Answer_Wording]                        --->  UPDATE
---------- [Answer_Std_fk]                         --->  match
---------- [Question_fk]                           --->  UPDATE
/*****************************************************************************************************************************************/
	INSERT INTO      [forum].[dbo].[Pew_Answer_NoStd]
         SELECT                                       [Answer_pk]            = [31_new_AnsNSK]
                                                     ,[Answer_value_NoStd]   = [31_new_AnsVal]
                                                     ,[Answer_Wording]       = [31_new_AnsWrd]
                                                     ,[Answer_Std_fk]        = [31_new_AnsStK]
                                                     ,[Question_fk]          = [31_new_QueNSK]
               FROM  [GRSHRResults]..[LINKEDTABLE]
                                                                       WHERE   [31_new_AnsNSK] IS NOT NULL
/*****************************************************************************************************************************************/
-- 4.     changes on answer tables
-- 4.1.   update  on [Pew_Nation_Answer]
---------- [Nation_answer_pk]                      same
---------- [Nation_fk]                             same
---------- [Answer_fk]                             --->  UPDATE
---------- [display]                               same
/*****************************************************************************************************************************************/
	UPDATE
           [forum].[dbo].[Pew_Nation_Answer]
	SET                                               [Answer_fk]       = mynew.[41_updtAns_fk]
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--select *
FROM
           [forum].[dbo].[Pew_Nation_Answer]                        AS mydbt
 JOIN      [GRSHRResults]..[LINKEDTABLE]                            AS mynew
ON
           mydbt.[Nation_answer_pk]
       =   mynew.[41_NA_lk]
GO
/*****************************************************************************************************************************************/
-- 4.     changes on answer tables
-- 4.2.   update  on [Pew_Nation_Religion_Answer]
---------- [Nation_religion_answer_pk]             same
---------- [Nation_fk]                             same
---------- [Religion_group_fk]                     same
---------- [Answer_fk]                             --->  UPDATE
---------- [display]                               same
/*****************************************************************************************************************************************/
	UPDATE
           [forum].[dbo].[Pew_Nation_Religion_Answer]
	SET                                               [Answer_fk]       = mynew.[42_updtAns_fk]
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--select *
FROM
           [forum].[dbo].[Pew_Nation_Religion_Answer]               AS mydbt
 JOIN      [GRSHRResults]..[LINKEDTABLE]                            AS mynew
ON
           mydbt.[Nation_religion_answer_pk]
       =   mynew.[42_NRA_lk]
GO
/*****************************************************************************************************************************************/
-- 4.     changes on answer tables
-- 4.3.   update  on [Pew_Locality_Answer]
---------- [Locality_answer_pk]                    same
---------- [Locality_fk]                           same
---------- [Answer_fk]                             --->  UPDATE
---------- [display]                               same
/*****************************************************************************************************************************************/
	UPDATE
           [forum].[dbo].[Pew_Locality_Answer]
	SET                                               [Answer_fk]       = mynew.[43_updtAns_fk]
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--select *
FROM
           [forum].[dbo].[Pew_Locality_Answer]                      AS mydbt
 JOIN      [GRSHRResults]..[LINKEDTABLE]                            AS mynew
ON
           mydbt.[Locality_answer_pk]
       =   mynew.[43_LA_lk]
GO
/*****************************************************************************************************************************************/

