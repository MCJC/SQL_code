/**************************************************************************************************************************/
/***                  *****************************************************************************************************/
/***   MOVE   FLAGS   *****************************************************************************************************/
/***                  *****************************************************************************************************/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
USE
       [forum_ResAnal]
GO
/**************************************************************************************************************************/
/*****                                               Create NEW Table                                                 *****/
/**************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
/*------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Pew_Flag](
	[Flag_pk]             [int]            NOT NULL,
	[Nation_fk]           [int]                NULL,
	[SubRegion6_code]     [int]                NULL,
	[Ctry_EditorialName]  [varchar](50)        NULL,
	[SubRegion6]          [varchar](50)        NULL,
	[Flag_name]           [varchar](50)        NULL,
	[Flag_image]          [varbinary](max)     NULL,
CONSTRAINT 
    [PK_Pew_Flag] PRIMARY KEY CLUSTERED 
                  (
	               [Flag_pk] ASC
                  )WITH (PAD_INDEX         = OFF,
                   STATISTICS_NORECOMPUTE  = OFF,
                   IGNORE_DUP_KEY          = OFF,
                   ALLOW_ROW_LOCKS         = ON ,
                   ALLOW_PAGE_LOCKS        = ON  ) ON [PRIMARY]
                                                                ) ON [PRIMARY]
/*------------------------------------------------------------------------------------------------------------------------*/
GO
SET ANSI_PADDING OFF
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/
INSERT
INTO
       [Pew_Flag]
                (  [Flag_pk]
                 , [Nation_fk]
                 , [SubRegion6_code]
                 , [Ctry_EditorialName]
                 , [SubRegion6]
                 , [Flag_name]
                 , [Flag_image]   )
SELECT
                   [Flag_pk]   = [Nation_fk]
                 , [Nation_fk]
                 , [SubRegion6_code]
                                     = CASE 
                                            WHEN [SubRegion6] = 'North America'             THEN 1001
                                            WHEN [SubRegion6] = 'Latin America-Caribbean'   THEN 1002
                                            WHEN [SubRegion6] = 'Europe'                    THEN 1003
                                            WHEN [SubRegion6] = 'Middle East-North Africa'  THEN 1004
                                            WHEN [SubRegion6] = 'Sub-Saharan Africa'        THEN 1005
                                            WHEN [SubRegion6] = 'Asia-Pacific'              THEN 1006
                                        END
                 , [Ctry_EditorialName]
                 , [SubRegion6]
                 , [Flag_name] = CASE
                                      WHEN Nation_fk = 1     THEN 'flag_of_n_1_.gif'
                                      WHEN Nation_fk = 2     THEN 'flag_of_n_2_.gif'
                                      WHEN Nation_fk = 3     THEN 'flag_of_n_3_.gif'
                                      WHEN Nation_fk = 4     THEN 'flag_of_n_4_.gif'
                                      WHEN Nation_fk = 5     THEN 'flag_of_n_5_.gif'
                                      WHEN Nation_fk = 6     THEN 'flag_of_n_6_.gif'
                                      WHEN Nation_fk = 7     THEN 'flag_of_n_7_.gif'
                                      WHEN Nation_fk = 8     THEN 'flag_of_n_8_.gif'
                                      WHEN Nation_fk = 9     THEN 'flag_of_n_9_.gif'
                                      WHEN Nation_fk = 10     THEN 'flag_of_n_10_.gif'
                                      WHEN Nation_fk = 11     THEN 'flag_of_n_11_.gif'
                                      WHEN Nation_fk = 12     THEN 'flag_of_n_12_.gif'
                                      WHEN Nation_fk = 13     THEN 'flag_of_n_13_.gif'
                                      WHEN Nation_fk = 14     THEN 'flag_of_n_14_.gif'
                                      WHEN Nation_fk = 15     THEN 'flag_of_n_15_.gif'
                                      WHEN Nation_fk = 16     THEN 'flag_of_n_16_.gif'
                                      WHEN Nation_fk = 17     THEN 'flag_of_n_17_.gif'
                                      WHEN Nation_fk = 18     THEN 'flag_of_n_18_.gif'
                                      WHEN Nation_fk = 19     THEN 'flag_of_n_19_.gif'
                                      WHEN Nation_fk = 20     THEN 'flag_of_n_20_.gif'
                                      WHEN Nation_fk = 21     THEN 'flag_of_n_21_.gif'
                                      WHEN Nation_fk = 22     THEN 'flag_of_n_22_.gif'
                                      WHEN Nation_fk = 23     THEN 'flag_of_n_23_.gif'
                                      WHEN Nation_fk = 24     THEN 'flag_of_n_24_.gif'
                                      WHEN Nation_fk = 25     THEN 'flag_of_n_25_.gif'
                                      WHEN Nation_fk = 26     THEN 'flag_of_n_26_.gif'
                                      WHEN Nation_fk = 27     THEN 'flag_of_n_27_.gif'
                                      WHEN Nation_fk = 28     THEN 'flag_of_n_28_.gif'
                                      WHEN Nation_fk = 29     THEN 'flag_of_n_29_.gif'
                                      WHEN Nation_fk = 30     THEN 'flag_of_n_30_.gif'
                                      WHEN Nation_fk = 31     THEN 'flag_of_n_31_.gif'
                                      WHEN Nation_fk = 32     THEN 'flag_of_n_32_.gif'
                                      WHEN Nation_fk = 33     THEN 'flag_of_n_33_.gif'
                                      WHEN Nation_fk = 34     THEN 'flag_of_n_34_.gif'
                                      WHEN Nation_fk = 35     THEN 'flag_of_n_35_.gif'
                                      WHEN Nation_fk = 36     THEN 'flag_of_n_36_.gif'
                                      WHEN Nation_fk = 37     THEN 'flag_of_n_37_.gif'
                                      WHEN Nation_fk = 38     THEN 'flag_of_n_38_.gif'
                                      WHEN Nation_fk = 39     THEN 'flag_of_n_39_.gif'
                                      WHEN Nation_fk = 40     THEN 'flag_of_n_40_.gif'
                                      WHEN Nation_fk = 41     THEN 'flag_of_n_41_.gif'
                                      WHEN Nation_fk = 42     THEN 'flag_of_n_42_.gif'
                                      WHEN Nation_fk = 43     THEN 'flag_of_n_43_.gif'
                                      WHEN Nation_fk = 44     THEN 'flag_of_n_44_.gif'
                                      WHEN Nation_fk = 45     THEN 'flag_of_n_45_.gif'
                                      WHEN Nation_fk = 46     THEN 'flag_of_n_46_.gif'
                                      WHEN Nation_fk = 47     THEN 'flag_of_n_47_.gif'
                                      WHEN Nation_fk = 48     THEN 'flag_of_n_48_.gif'
                                      WHEN Nation_fk = 49     THEN 'flag_of_n_49_.gif'
                                      WHEN Nation_fk = 50     THEN 'flag_of_n_50_.gif'
                                      WHEN Nation_fk = 51     THEN 'flag_of_n_51_.gif'
                                      WHEN Nation_fk = 52     THEN 'flag_of_n_52_.gif'
                                      WHEN Nation_fk = 53     THEN 'flag_of_n_53_.gif'
                                      WHEN Nation_fk = 54     THEN 'flag_of_n_54_.gif'
                                      WHEN Nation_fk = 55     THEN 'flag_of_n_55_.gif'
                                      WHEN Nation_fk = 56     THEN 'flag_of_n_56_.gif'
                                      WHEN Nation_fk = 57     THEN 'flag_of_n_57_.gif'
                                      WHEN Nation_fk = 58     THEN 'flag_of_n_58_.gif'
                                      WHEN Nation_fk = 59     THEN 'flag_of_n_59_.gif'
                                      WHEN Nation_fk = 60     THEN 'flag_of_n_60_.gif'
                                      WHEN Nation_fk = 61     THEN 'flag_of_n_61_.gif'
                                      WHEN Nation_fk = 62     THEN 'flag_of_n_62_.gif'
                                      WHEN Nation_fk = 63     THEN 'flag_of_n_63_.gif'
                                      WHEN Nation_fk = 64     THEN 'flag_of_n_64_.gif'
                                      WHEN Nation_fk = 65     THEN 'flag_of_n_65_.gif'
                                      WHEN Nation_fk = 66     THEN 'flag_of_n_66_.gif'
                                      WHEN Nation_fk = 67     THEN 'flag_of_n_67_.gif'
                                      WHEN Nation_fk = 68     THEN 'flag_of_n_68_.gif'
                                      WHEN Nation_fk = 69     THEN 'flag_of_n_69_.gif'
                                      WHEN Nation_fk = 70     THEN 'flag_of_n_70_.gif'
                                      WHEN Nation_fk = 71     THEN 'flag_of_n_71_.gif'
                                      WHEN Nation_fk = 72     THEN 'flag_of_n_72_.gif'
                                      WHEN Nation_fk = 73     THEN 'flag_of_n_73_.gif'
                                      WHEN Nation_fk = 74     THEN 'flag_of_n_74_.gif'
                                      WHEN Nation_fk = 75     THEN 'flag_of_n_75_.gif'
                                      WHEN Nation_fk = 76     THEN 'flag_of_n_76_.gif'
                                      WHEN Nation_fk = 77     THEN 'flag_of_n_77_.gif'
                                      WHEN Nation_fk = 78     THEN 'flag_of_n_78_.gif'
                                      WHEN Nation_fk = 79     THEN 'flag_of_n_79_.gif'
                                      WHEN Nation_fk = 80     THEN 'flag_of_n_80_.gif'
                                      WHEN Nation_fk = 81     THEN 'flag_of_n_81_.gif'
                                      WHEN Nation_fk = 82     THEN 'flag_of_n_82_.gif'
                                      WHEN Nation_fk = 83     THEN 'flag_of_n_83_.gif'
                                      WHEN Nation_fk = 84     THEN 'flag_of_n_84_.gif'
                                      WHEN Nation_fk = 85     THEN 'flag_of_n_85_.gif'
                                      WHEN Nation_fk = 86     THEN 'flag_of_n_86_.gif'
                                      WHEN Nation_fk = 87     THEN 'flag_of_n_87_.gif'
                                      WHEN Nation_fk = 88     THEN 'flag_of_n_88_.gif'
                                      WHEN Nation_fk = 89     THEN 'flag_of_n_89_.gif'
                                      WHEN Nation_fk = 90     THEN 'flag_of_n_90_.gif'
                                      WHEN Nation_fk = 91     THEN 'flag_of_n_91_.gif'
                                      WHEN Nation_fk = 92     THEN 'flag_of_n_92_.gif'
                                      WHEN Nation_fk = 93     THEN 'flag_of_n_93_.gif'
                                      WHEN Nation_fk = 94     THEN 'flag_of_n_94_.gif'
                                      WHEN Nation_fk = 95     THEN 'flag_of_n_95_.gif'
                                      WHEN Nation_fk = 96     THEN 'flag_of_n_96_.gif'
                                      WHEN Nation_fk = 97     THEN 'flag_of_n_97_.gif'
                                      WHEN Nation_fk = 98     THEN 'flag_of_n_98_.gif'
                                      WHEN Nation_fk = 99     THEN 'flag_of_n_99_.gif'
                                      WHEN Nation_fk = 100     THEN 'flag_of_n_100_.gif'
                                      WHEN Nation_fk = 101     THEN 'flag_of_n_101_.gif'
                                      WHEN Nation_fk = 102     THEN 'flag_of_n_102_.gif'
                                      WHEN Nation_fk = 103     THEN 'flag_of_n_103_.gif'
                                      WHEN Nation_fk = 104     THEN 'flag_of_n_104_.gif'
                                      WHEN Nation_fk = 105     THEN 'flag_of_n_105_.gif'
                                      WHEN Nation_fk = 106     THEN 'flag_of_n_106_.gif'
                                      WHEN Nation_fk = 107     THEN 'flag_of_n_107_.gif'
                                      WHEN Nation_fk = 108     THEN 'flag_of_n_108_.gif'
                                      WHEN Nation_fk = 109     THEN 'flag_of_n_109_.gif'
                                      WHEN Nation_fk = 110     THEN 'flag_of_n_110_.gif'
                                      WHEN Nation_fk = 111     THEN 'flag_of_n_111_.gif'
                                      WHEN Nation_fk = 112     THEN 'flag_of_n_112_.gif'
                                      WHEN Nation_fk = 113     THEN 'flag_of_n_113_.gif'
                                      WHEN Nation_fk = 114     THEN 'flag_of_n_114_.gif'
                                      WHEN Nation_fk = 115     THEN 'flag_of_n_115_.gif'
                                      WHEN Nation_fk = 116     THEN 'flag_of_n_116_.gif'
                                      WHEN Nation_fk = 117     THEN 'flag_of_n_117_.gif'
                                      WHEN Nation_fk = 118     THEN 'flag_of_n_118_.gif'
                                      WHEN Nation_fk = 119     THEN 'flag_of_n_119_.gif'
                                      WHEN Nation_fk = 120     THEN 'flag_of_n_120_.gif'
                                      WHEN Nation_fk = 121     THEN 'flag_of_n_121_.gif'
                                      WHEN Nation_fk = 122     THEN 'flag_of_n_122_.gif'
                                      WHEN Nation_fk = 123     THEN 'flag_of_n_123_.gif'
                                      WHEN Nation_fk = 124     THEN 'flag_of_n_124_.gif'
                                      WHEN Nation_fk = 125     THEN 'flag_of_n_125_.gif'
                                      WHEN Nation_fk = 126     THEN 'flag_of_n_126_.gif'
                                      WHEN Nation_fk = 127     THEN 'flag_of_n_127_.gif'
                                      WHEN Nation_fk = 128     THEN 'flag_of_n_128_.gif'
                                      WHEN Nation_fk = 129     THEN 'flag_of_n_129_.gif'
                                      WHEN Nation_fk = 130     THEN 'flag_of_n_130_.gif'
                                      WHEN Nation_fk = 131     THEN 'flag_of_n_131_.gif'
                                      WHEN Nation_fk = 132     THEN 'flag_of_n_132_.gif'
                                      WHEN Nation_fk = 133     THEN 'flag_of_n_133_.gif'
                                      WHEN Nation_fk = 134     THEN 'flag_of_n_134_.gif'
                                      WHEN Nation_fk = 135     THEN 'flag_of_n_135_.gif'
                                      WHEN Nation_fk = 136     THEN 'flag_of_n_136_.gif'
                                      WHEN Nation_fk = 137     THEN 'flag_of_n_137_.gif'
                                      WHEN Nation_fk = 138     THEN 'flag_of_n_138_.gif'
                                      WHEN Nation_fk = 139     THEN 'flag_of_n_139_.gif'
                                      WHEN Nation_fk = 140     THEN 'flag_of_n_140_.gif'
                                      WHEN Nation_fk = 141     THEN 'flag_of_n_141_.gif'
                                      WHEN Nation_fk = 142     THEN 'flag_of_n_142_.gif'
                                      WHEN Nation_fk = 143     THEN 'flag_of_n_143_.gif'
                                      WHEN Nation_fk = 144     THEN 'flag_of_n_144_.gif'
                                      WHEN Nation_fk = 145     THEN 'flag_of_n_145_.gif'
                                      WHEN Nation_fk = 146     THEN 'flag_of_n_146_.gif'
                                      WHEN Nation_fk = 148     THEN 'flag_of_n_148_.gif'
                                      WHEN Nation_fk = 149     THEN 'flag_of_n_149_.gif'
                                      WHEN Nation_fk = 150     THEN 'flag_of_n_150_.gif'
                                      WHEN Nation_fk = 151     THEN 'flag_of_n_151_.gif'
                                      WHEN Nation_fk = 152     THEN 'flag_of_n_152_.gif'
                                      WHEN Nation_fk = 153     THEN 'flag_of_n_153_.gif'
                                      WHEN Nation_fk = 154     THEN 'flag_of_n_154_.gif'
                                      WHEN Nation_fk = 155     THEN 'flag_of_n_155_.gif'
                                      WHEN Nation_fk = 156     THEN 'flag_of_n_156_.gif'
                                      WHEN Nation_fk = 157     THEN 'flag_of_n_157_.gif'
                                      WHEN Nation_fk = 158     THEN 'flag_of_n_158_.gif'
                                      WHEN Nation_fk = 159     THEN 'flag_of_n_159_.gif'
                                      WHEN Nation_fk = 160     THEN 'flag_of_n_160_.gif'
                                      WHEN Nation_fk = 161     THEN 'flag_of_n_161_.gif'
                                      WHEN Nation_fk = 162     THEN 'flag_of_n_162_.gif'
                                      WHEN Nation_fk = 163     THEN 'flag_of_n_163_.gif'
                                      WHEN Nation_fk = 164     THEN 'flag_of_n_164_.gif'
                                      WHEN Nation_fk = 165     THEN 'flag_of_n_165_.gif'
                                      WHEN Nation_fk = 167     THEN 'flag_of_n_167_.gif'
                                      WHEN Nation_fk = 168     THEN 'flag_of_n_168_.gif'
                                      WHEN Nation_fk = 169     THEN 'flag_of_n_169_.gif'
                                      WHEN Nation_fk = 170     THEN 'flag_of_n_170_.gif'
                                      WHEN Nation_fk = 171     THEN 'flag_of_n_171_.gif'
                                      WHEN Nation_fk = 172     THEN 'flag_of_n_172_.gif'
                                      WHEN Nation_fk = 173     THEN 'flag_of_n_173_.gif'
                                      WHEN Nation_fk = 174     THEN 'flag_of_n_174_.gif'
                                      WHEN Nation_fk = 175     THEN 'flag_of_n_175_.gif'
                                      WHEN Nation_fk = 176     THEN 'flag_of_n_176_.gif'
                                      WHEN Nation_fk = 177     THEN 'flag_of_n_177_.gif'
                                      WHEN Nation_fk = 178     THEN 'flag_of_n_178_.gif'
                                      WHEN Nation_fk = 179     THEN 'flag_of_n_179_.gif'
                                      WHEN Nation_fk = 180     THEN 'flag_of_n_180_.gif'
                                      WHEN Nation_fk = 181     THEN 'flag_of_n_181_.gif'
                                      WHEN Nation_fk = 182     THEN 'flag_of_n_182_.gif'
                                      WHEN Nation_fk = 183     THEN 'flag_of_n_183_.gif'
                                      WHEN Nation_fk = 184     THEN 'flag_of_n_184_.gif'
                                      WHEN Nation_fk = 185     THEN 'flag_of_n_185_.gif'
                                      WHEN Nation_fk = 186     THEN 'flag_of_n_186_.gif'
                                      WHEN Nation_fk = 187     THEN 'flag_of_n_187_.gif'
                                      WHEN Nation_fk = 188     THEN 'flag_of_n_188_.gif'
                                      WHEN Nation_fk = 189     THEN 'flag_of_n_189_.gif'
                                      WHEN Nation_fk = 190     THEN 'flag_of_n_190_.gif'
                                      WHEN Nation_fk = 191     THEN 'flag_of_n_191_.gif'
                                      WHEN Nation_fk = 192     THEN 'flag_of_n_192_.gif'
                                      WHEN Nation_fk = 193     THEN 'flag_of_n_193_.gif'
                                      WHEN Nation_fk = 194     THEN 'flag_of_n_194_.gif'
                                      WHEN Nation_fk = 195     THEN 'flag_of_n_195_.gif'
                                      WHEN Nation_fk = 196     THEN 'flag_of_n_196_.gif'
                                      WHEN Nation_fk = 197     THEN 'flag_of_n_197_.gif'
                                      WHEN Nation_fk = 198     THEN 'flag_of_n_198_.gif'
                                      WHEN Nation_fk = 199     THEN 'flag_of_n_199_.gif'
                                      WHEN Nation_fk = 200     THEN 'flag_of_n_200_.gif'
                                      WHEN Nation_fk = 201     THEN 'flag_of_n_201_.gif'
                                      WHEN Nation_fk = 202     THEN 'flag_of_n_202_.gif'
                                      WHEN Nation_fk = 203     THEN 'flag_of_n_203_.gif'
                                      WHEN Nation_fk = 204     THEN 'flag_of_n_204_.gif'
                                      WHEN Nation_fk = 205     THEN 'flag_of_n_205_.gif'
                                      WHEN Nation_fk = 206     THEN 'flag_of_n_206_.gif'
                                      WHEN Nation_fk = 207     THEN 'flag_of_n_207_.gif'
                                      WHEN Nation_fk = 208     THEN 'flag_of_n_208_.gif'
                                      WHEN Nation_fk = 209     THEN 'flag_of_n_209_.gif'
                                      WHEN Nation_fk = 210     THEN 'flag_of_n_210_.gif'
                                      WHEN Nation_fk = 211     THEN 'flag_of_n_211_.gif'
                                      WHEN Nation_fk = 212     THEN 'flag_of_n_212_.gif'
                                      WHEN Nation_fk = 213     THEN 'flag_of_n_213_.gif'
                                      WHEN Nation_fk = 214     THEN 'flag_of_n_214_.gif'
                                      WHEN Nation_fk = 215     THEN 'flag_of_n_215_.gif'
                                      WHEN Nation_fk = 216     THEN 'flag_of_n_216_.gif'
                                      WHEN Nation_fk = 217     THEN 'flag_of_n_217_.gif'
                                      WHEN Nation_fk = 218     THEN 'flag_of_n_218_.gif'
                                      WHEN Nation_fk = 219     THEN 'flag_of_n_219_.gif'
                                      WHEN Nation_fk = 220     THEN 'flag_of_n_220_.gif'
                                      WHEN Nation_fk = 221     THEN 'flag_of_n_221_.gif'
                                      WHEN Nation_fk = 222     THEN 'flag_of_n_222_.gif'
                                      WHEN Nation_fk = 223     THEN 'flag_of_n_223_.gif'
                                      WHEN Nation_fk = 224     THEN 'flag_of_n_224_.gif'
                                      WHEN Nation_fk = 225     THEN 'flag_of_n_225_.gif'
                                      WHEN Nation_fk = 226     THEN 'flag_of_n_226_.gif'
                                      WHEN Nation_fk = 227     THEN 'flag_of_n_227_.gif'
                                      WHEN Nation_fk = 228     THEN 'flag_of_n_228_.gif'
                                      WHEN Nation_fk = 229     THEN 'flag_of_n_229_.gif'
                                      WHEN Nation_fk = 230     THEN 'flag_of_n_230_.gif'
                                      WHEN Nation_fk = 231     THEN 'flag_of_n_231_.gif'
                                      WHEN Nation_fk = 232     THEN 'flag_of_n_232_.gif'
                                      WHEN Nation_fk = 237     THEN 'flag_of_n_237_.gif'
                                      WHEN Nation_fk = 238     THEN 'flag_of_n_238_.gif'
                                      WHEN Nation_fk = 239     THEN 'flag_of_n_239_.gif'
                                      WHEN Nation_fk = 240     THEN 'flag_of_n_240_.gif'
                                END                 
                 , [Flag_image]
FROM
       [forumBlob].[dbo].[Pew_Flag]
     , [for_d]    .[dbo].[Pew_Nation]
WHERE
                   [Nation_fk]
                 = [Nation_pk]
/**************************************************************************************************************************/
-- check results by exporting image
-- Keep the command on ONE LINE - SINGLE LINE!!!
DECLARE  @sql NVARCHAR(4000)
set @sql = 'BCP "SELECT Flag_image FROM forum_ResAnal.dbo.Pew_Flag WHERE Nation_fk = 238" QUERYOUT F:\JC\test\exp_238.jpg -T -f F:\JC\test\testblob.fmt -S ' + @@SERVERNAME
EXEC master.dbo.xp_CmdShell @sql 
set @sql = 'BCP "SELECT Flag_image FROM forum_ResAnal.dbo.Pew_Flag WHERE Nation_fk =   1" QUERYOUT F:\JC\test\exp_001.jpg -T -f F:\JC\test\testblob.fmt -S ' + @@SERVERNAME
EXEC master.dbo.xp_CmdShell @sql 
/********************************************************************************************************************************************************************/
