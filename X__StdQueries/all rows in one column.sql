select U =
  stuff((select ',  '
  + quotename (V.name)
         from sys.columns as C
         where C.object_id = object_id('NVW') and
               ( C.name like 'CSR%' OR 
                 C.name like 'ERI%' OR 
                 C.name like 'IEI%' OR 
                 C.name like 'PPR%' OR 
                 C.name like 'RIR%'     )
                 and
                C.name not like '%DSCPTN'
                 and
                C.name not like '%DESCPTN'
         for xml path('')), 1, 1, '')