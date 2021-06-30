file_name = 'SimusAnalysis1Type2sim.mat';

load(file_name);

simus4aO = simus_summary.simus4aO;
simus4aP = simus_summary.simus4aP;

h4aO = zeros(1, 6);
h4aP = zeros(1, 6);
p4aO = zeros(1, 6);
p4aP = zeros(1, 6);
ci4aO = zeros(2, 6);
ci4aP = zeros(2, 6);
stattable4aO = table('Size', [6 3], 'VariableTypes', ["single", "single", "single"]);
stattable4aP = table('Size', [6 3], 'VariableTypes', ["single", "single", "single"]);

for i=1:6
[h4aO(1,i), p4aO(1,i), ci4aO(:,i), stats4aO] = ttest(simus4aO(:,i),50);
[h4aP(1,i), p4aP(1,i), ci4aP(:,i), stats4aP] = ttest(simus4aP(:,i),50);
t_stats4aO = struct2table(stats4aO);
stattable4aO(i,:) = t_stats4aO;
t_stats4aP = struct2table(stats4aP);
stattable4aP(i,:) = t_stats4aP;
end

%Save in a table

types = ["Free LR", "Free HR", "Cong LR", "Cong HR", "Incong LR", "Incong HR"];
ttest_summary = table(transpose(types), transpose(h4aO), transpose(p4aO), transpose(h4aP), transpose(p4aP));
save('TtestAnalysis1Type2sim.mat', 'ttest_summary');
