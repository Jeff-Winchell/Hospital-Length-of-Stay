with open('data.csv') as Input:
    with open('Predictors.txt','w') as Output:
        Output.writelines([column+'\n' for column in Input.readline().split(',')])
