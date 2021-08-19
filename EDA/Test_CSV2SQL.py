import os
os.system('sqlcmd -E -i "Test_DDL.SQL"')
with open(os.path.dirname(os.getcwd())+'\data.csv') as Input:
    with open('converted_data.csv','w') as Output:
        Output.write(Input.read().replace('True','1').replace('False','0'))
os.system('sqlcmd -E -Q "Bulk Insert Hospital.dbo.Patient_Summary From \''+os.getcwd()+'\\'+'converted_data.csv\' With (MaxErrors=1,DataFileType=\'char\',FirstRow=2,RowTerminator=\'0x0a\',FieldTerminator=\',\')"')
os.system('sqlcmd -E -Q "Alter Table Hospital.dbo.Patient_Summary Alter Column proceduresCount TinyInt Not Null"')
os.remove('converted_data.csv')