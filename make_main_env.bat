call conda deactivate
call conda env remove --name LOS
call conda create --yes --name LOS -c anaconda python=3.7 scikit-learn notebook
call conda activate LOS
call conda env export --name LOS > LOS.yml