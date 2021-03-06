changeCobraSolver('glpk','all');
global CBTDIR

modelFileName = 'Recon2.0model.mat';

modelDirectory = getDistributedModelFolder(modelFileName); %Look up the folder for the distributed Models.

modelFileName= [modelDirectory filesep modelFileName]; % Get the full path. Necessary to be sure, that the right model is loaded

model = readCbModel(modelFileName);
modelurea = model;

printRxnFormula(model, 'ARGNm');
modelurea.c = 0*modelurea.c; % remove any objective function
modelurea = changeObjective (modelurea, 'ARGNm');
modelurea = changeRxnBounds(modelurea, 'ASNNm', 10, 'u'); %aspartate biogenesis
modelurea = changeRxnBounds(modelurea, 'ARGSS', 0, 'l'); %v1
modelurea = changeRxnBounds(modelurea, 'ARGSS', 7.24, 'u');
modelurea = changeRxnBounds(modelurea, 'ARGSL', 0, 'l');%v2
modelurea = changeRxnBounds(modelurea, 'ARGSL', 1.24, 'u');
modelurea = changeRxnBounds(modelurea, 'ARGNm', 0, 'l');%v3
modelurea = changeRxnBounds(modelurea, 'ARGNm', 10, 'u');
modelurea = changeRxnBounds(modelurea, 'OCBTm', 0, 'l');%v4
modelurea = changeRxnBounds(modelurea, 'OCBTm', 2.34, 'u');
modelurea = changeRxnBounds(modelurea, 'NOS2', -0.486, 'l');%v5
modelurea = changeRxnBounds(modelurea, 'NOS2', 0.486, 'u');
modelurea = changeRxnBounds(modelurea, 'FRD7', 0, 'l'); %fumurate comsumption
modelurea = changeRxnBounds(modelurea, 'FRD7', 10, 'u');
modelurea = changeRxnBounds(modelurea, 'CBPSam', 0, 'l'); %cbp input
modelurea = changeRxnBounds(modelurea, 'CBPSam', 10, 'u');
modelurea = changeRxnBounds(modelurea, 'PPCKr', -10, 'l'); %ATP synthesis
modelurea = changeRxnBounds(modelurea, 'PPCKr', 10, 'u');
FBAurea = optimizeCbModel (modelurea, 'max'); % generate the max level of urea production
