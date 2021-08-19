with open('Domain_Sample.csv') as Input:
    with open('Prelim_DDL.SQL','w') as Output:
        Columns=Input.readline().split(',')
        Data=Input.readline().split(',')
        DDL='Create Table Patient_Summary (\n'
        for Column_Number,Column_Name in enumerate(Columns):
            if Data[Column_Number] is None or Data[Column_Number]=='':
                DDL+='\t'+Column_Name+' UNK,\n'
            elif Data[Column_Number] in ['True','False']:
                DDL+='\t'+Column_Name+' Bit,\n'
            elif Data[Column_Number].isalpha():
                DDL+='\t'+Column_Name+' VarChar(100),\n'
            elif Data[Column_Number].isnumeric():
                DDL+='\t'+Column_Name+' Int,\n'
            else:
                try:
                    foo=float(Data[Column_Number])
                    DDL+='\t'+Column_Name+' Float,\n'
                except:
                    DDL+='\t'+Column_Name+' ??'+Data[Column_Number]+',\n'
        Output.write(DDL[:-2]+'\n)')
