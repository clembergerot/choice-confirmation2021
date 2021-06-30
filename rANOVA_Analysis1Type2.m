file_name = 'SimusAnalysis1Type2sim.mat';

load(file_name);

simus4aO = simus_summary.simus4aO;
simus4aP = simus_summary.simus4aP;

Pattern = repelem(["OptOpt", "OptPes"], [1000 1000]);

Pattern = transpose(categorical(Pattern));

%24 measurements
measures = [simus4aO ; simus4aP];

%rANOVA
datatable = table(string(Pattern), measures(:,3), measures(:,4), measures(:,5), measures(:,6));
datatable.Properties.VariableNames = {'Pattern','Cong_LR','Cong_HR','Incong_LR','Incong_HR',};
% When you have more than one repeated-measures factor, you must set up a table
% to indicate the levels on each factor for each of your different variables.
% Here is the command you need for this case:
WithinStructure = table([1 1 2 2 ]',[1 2 1 2]','VariableNames',{'Congruency','Resources'});
% The 4 different rows of the WithinStructure table correspond to the 4 different
% columns, 'pre_A','pre_B','post_A','post_B', respectively, in your data table.
% Each 'pre_A','pre_B','post_A','post_B' column is coded as 1/2 on the PrePost factor
% and as 1/2 on the TreatAB factor.
% (Added based on later comments:)
% Indicate that the 1's and 2's of WithinStructure are category labels
% rather than regression-type numerical covariates:
WithinStructure.Congruency = categorical(WithinStructure.Congruency);
WithinStructure.Resources = categorical(WithinStructure.Resources);
% Now pass the WithinStructure table to fitrm so that it knows how the different
% columns correspond to the different levels of the repeated-measures factors.
rm = fitrm(datatable, 'Cong_LR,Cong_HR,Incong_LR,Incong_HR~Pattern','WithinDesign',WithinStructure);
% Finally, you need to specify the repeated-measures factors again when you call ranova, like this:
ranovatbl = ranova(rm,'WithinModel','Congruency*Resources');
ranovatbl = ranovatbl(:,1:end);
