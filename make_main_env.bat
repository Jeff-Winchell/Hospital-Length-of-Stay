call conda deactivate
call conda env remove --name LOS
call conda create --yes --name LOS -c anaconda python=3.7
call conda activate LOS
call conda install --yes -c conda-forge r-c50
call conda env export --name LOS > LOS.yml