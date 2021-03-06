CREATE TABLE [dbo].[CENSUS] (
          [PK]                                           int IDENTITY(1,1) NOT NULL,
          [Country code]                                 int NULL,
          [Country]                                      nvarchar(255) NULL,
          [Year]                                         int NULL,
          [Sex]                                          int NULL,
          [Type]                                         nvarchar(255) NULL,
          [Cohort]                                       nvarchar(255) NULL,
          [R_Christians_E1_K_EAbyRC]                     decimal(36,16) NULL,
          [R_Christians_E2_K_EAbyRC]                     decimal(36,16) NULL,
          [R_Christians_E3_K_EAbyRC]                     decimal(36,16) NULL,
          [R_Christians_E4_K_EAbyRC]                     decimal(36,16) NULL,
          [R_Muslims_E1_K_EAbyRC]                        decimal(36,16) NULL,
          [R_Muslims_E2_K_EAbyRC]                        decimal(36,16) NULL,
          [R_Muslims_E3_K_EAbyRC]                        decimal(36,16) NULL,
          [R_Muslims_E4_K_EAbyRC]                        decimal(36,16) NULL,
          [R_Unaffiliated_E1_K_EAbyRC]                   decimal(36,16) NULL,
          [R_Unaffiliated_E2_K_EAbyRC]                   decimal(36,16) NULL,
          [R_Unaffiliated_E3_K_EAbyRC]                   decimal(36,16) NULL,
          [R_Unaffiliated_E4_K_EAbyRC]                   decimal(36,16) NULL,
          [R_Buddhists_E1_K_EAbyRC]                      decimal(36,16) NULL,
          [R_Buddhists_E2_K_EAbyRC]                      decimal(36,16) NULL,
          [R_Buddhists_E3_K_EAbyRC]                      decimal(36,16) NULL,
          [R_Buddhists_E4_K_EAbyRC]                      decimal(36,16) NULL,
          [R_Hindus_E1_K_EAbyRC]                         decimal(36,16) NULL,
          [R_Hindus_E2_K_EAbyRC]                         decimal(36,16) NULL,
          [R_Hindus_E3_K_EAbyRC]                         decimal(36,16) NULL,
          [R_Hindus_E4_K_EAbyRC]                         decimal(36,16) NULL,
          [R_Jews_E1_K_EAbyRC]                           decimal(36,16) NULL,
          [R_Jews_E2_K_EAbyRC]                           decimal(36,16) NULL,
          [R_Jews_E3_K_EAbyRC]                           decimal(36,16) NULL,
          [R_Jews_E4_K_EAbyRC]                           decimal(36,16) NULL,
          [R_Others_E1_K_EAbyRC]                         decimal(36,16) NULL,
          [R_Others_E2_K_EAbyRC]                         decimal(36,16) NULL,
          [R_Others_E3_K_EAbyRC]                         decimal(36,16) NULL,
          [R_Others_E4_K_EAbyRC]                         decimal(36,16) NULL,
          [R_Christians_Eall_K_fromSource]               decimal(36,16) NULL,
          [R_Muslims_Eall_K_fromSource]                  decimal(36,16) NULL,
          [R_Unaffiliated_Eall_K_fromSource]             decimal(36,16) NULL,
          [R_Buddhists_Eall_K_fromSource]                decimal(36,16) NULL,
          [R_Hindus_Eall_K_fromSource]                   decimal(36,16) NULL,
          [R_Jews_Eall_K_fromSource]                     decimal(36,16) NULL,
          [R_Others_Eall_K_fromSource]                   decimal(36,16) NULL,
          [R_all_E1_K_fromSource]                        decimal(36,16) NULL,
          [R_all_E2_K_fromSource]                        decimal(36,16) NULL,
          [R_all_E3_K_fromSource]                        decimal(36,16) NULL,
          [R_all_E4_K_fromSource]                        decimal(36,16) NULL,
          [R_NotStated_E1_K_fromSource]                  decimal(36,16) NULL,
          [R_NotStated_E2_K_fromSource]                  decimal(36,16) NULL,
          [R_NotStated_E3_K_fromSource]                  decimal(36,16) NULL,
          [R_NotStated_E4_K_fromSource]                  decimal(36,16) NULL,
          [R_Christians_ENotStated_K_fromSource]         decimal(36,16) NULL,
          [R_Muslims_ENotStated_K_fromSource]            decimal(36,16) NULL,
          [R_Unaffiliated_ENotStated_K_fromSource]       decimal(36,16) NULL,
          [R_Buddhists_ENotStated_K_fromSource]          decimal(36,16) NULL,
          [R_Hindus_ENotStated_K_fromSource]             decimal(36,16) NULL,
          [R_Jews_ENotStated_K_fromSource]               decimal(36,16) NULL,
          [R_Others_ENotStated_K_fromSource]             decimal(36,16) NULL,
          [R_InclNotStated_E1_K_fromSource]              decimal(36,16) NULL,
          [R_InclNotStated_E2_K_fromSource]              decimal(36,16) NULL,
          [R_InclNotStated_E3_K_fromSource]              decimal(36,16) NULL,
          [R_InclNotStated_E4_K_fromSource]              decimal(36,16) NULL,
          [MYE_Christians]                               decimal(36,16) NULL,
          [MYE_Muslims]                                  decimal(36,16) NULL,
          [MYE_Unaffiliated]                             decimal(36,16) NULL,
          [MYE_Buddhists]                                decimal(36,16) NULL,
          [MYE_Hindus]                                   decimal(36,16) NULL,
          [MYE_Jews]                                     decimal(36,16) NULL,
          [MYE_Others]                                   decimal(36,16) NULL,
          [MYE_Total]                                    decimal(36,16) NULL,
          [ComputationMethod_of_MYE]                     nvarchar(MAX) NULL
)

CREATE TABLE [dbo].[CENSUS] (
          [PK]                                           int IDENTITY(1,1) NOT NULL,




select [a] = SUBSTRING('R_Muslim_E2_K_SurveyEAbyRC',3,CHARINDEX('_E','R_Muslim_E2_K_SurveyEAbyRC')-3)

