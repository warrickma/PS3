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
modelurea = changeRxnBounds(modelurea, 'ARGSL', 0.62, 'u');
modelurea = changeRxnBounds(modelurea, 'ARGNm', 0, 'l');%v3
modelurea = changeRxnBounds(modelurea, 'ARGNm', 10, 'u');
modelurea = changeRxnBounds(modelurea, 'OCBTm', 0, 'l');%v4
modelurea = changeRxnBounds(modelurea, 'OCBTm', 2.34, 'u');
FBAurea = optimizeCbModel (modelurea, 'max');
