%% rANOVA to assess effects of Congruency, Resources and Pattern on performance for Random agents, Design A

file_name = 'SimusAnalysis1Type2sim.mat'; %performance summary of Random agents on Design A

load(file_name);

simus4aO = simus_summary.simus4aO; %4aO: 4-alpha with Optimistic bias in forced-choice trials
simus4aP = simus_summary.simus4aP; %4aP: 4-alpha with Pessimistic bias in forced-choice trials

Pattern = repelem(["OptOpt", "OptPes"], [1000 1000]);

Pattern = transpose(categorical(Pattern));

%2000 measurements
measures = [simus4aO ; simus4aP];

%rANOVA with mixed design
datatable = table(string(Pattern), measures(:,3), measures(:,4), measures(:,5), measures(:,6));
datatable.Properties.VariableNames = {'Pattern','Cong_LR','Cong_HR','Incong_LR','Incong_HR',};
WithinStructure = table([1 1 2 2 ]',[1 2 1 2]','VariableNames',{'Congruency','Resources'});
WithinStructure.Congruency = categorical(WithinStructure.Congruency);
WithinStructure.Resources = categorical(WithinStructure.Resources);
rm = fitrm(datatable, 'Cong_LR,Cong_HR,Incong_LR,Incong_HR~Pattern','WithinDesign',WithinStructure);
ranovatbl = ranova(rm,'WithinModel','Congruency*Resources');
ranovatbl = ranovatbl(:,1:end);
