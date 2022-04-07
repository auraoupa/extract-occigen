#This script aims at reconstruct the forcing fields of eNATL60 simulations from the drowned ERAinterim files and the weights associated
# For this we need to compile the NEMO tools WEIGHTS that were used to produce the weights in the first place
# In /scratch/cnt0024/ige2071/aalbert/git/DCM_4.0.7/DCMTOOLS/NEMOREF/NEMO4/tools we do a ./maketools -m X64_OCCIGEN -n WEIGHTS (link to /scratch/cnt0024/ige2071/aalbert/git/DCM_4.0.7/DCMTOOLS/DRAKKAR/NEMO4/arch/CNRS/arch-X64_OCCIGEN.fcm in arch maybe necessary

EXE_PATH=/scratch/cnt0024/ige2071/aalbert/git/DCM_4.0.7/DCMTOOLS/NEMOREF/NEMO4/tools/WEIGHTS
cd /scratch/cnt0024/ige2071/aalbert/eNATL60/eNATL60-I/FATM

#cp /scratch/cnt0024/ige2071/aalbert/git/DCM_4.0.7/DCMTOOLS/NEMOREF/NEMO4/tools/WEIGHTS/namelist_bicub .

cp /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/FATM/drowned_u10_DFS5.2_y2009.nc .
cp /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/FATM/drowned_v10_DFS5.2_y2009.nc .
cp /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/FATM/weight_bicubic_512x256-eNATL60.nc .

${EXE_PATH}/scripinterp.exe <nbc

