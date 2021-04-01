congr1 = 0.75;
congr2 = 0.85;
congr3 = 0.95;

alphas1 = [0.3 0.15 0.3 0.15];
alphas2 = [0.3 0.15 0.15 0.3];


%First measurement
[means11, means_p11, mean_pc11, ci11, ci_p11, ci_pc11] = SimuQ(congr1, alphas1);
[means12, means_p12, mean_pc12, ci12, ci_p12, ci_pc12] = SimuQ(congr1, alphas2);
[means21, means_p21, mean_pc21, ci21, ci_p21, ci_pc21] = SimuQ(congr2, alphas1);
[means22, means_p22, mean_pc22, ci22, ci_p22, ci_pc22] = SimuQ(congr2, alphas2);
[means31, means_p31, mean_pc31, ci31, ci_p31, ci_pc31] = SimuQ(congr3, alphas1);
[means32, means_p32, mean_pc32, ci32, ci_p32, ci_pc32] = SimuQ(congr3, alphas2);

%Second measurement
[means11_2, means_p11_2, mean_pc11_2, ci11_2, ci_p11_2, ci_pc11_2] = SimuQ(congr1, alphas1);
[means12_2, means_p12_2, mean_pc12_2, ci12_2, ci_p12_2, ci_pc12_2] = SimuQ(congr1, alphas2);
[means21_2, means_p21_2, mean_pc21_2, ci21_2, ci_p21_2, ci_pc21_2] = SimuQ(congr2, alphas1);
[means22_2, means_p22_2, mean_pc22_2, ci22_2, ci_p22_2, ci_pc22_2] = SimuQ(congr2, alphas2);
[means31_2, means_p31_2, mean_pc31_2, ci31_2, ci_p31_2, ci_pc31_2] = SimuQ(congr3, alphas1);
[means32_2, means_p32_2, mean_pc32_2, ci32_2, ci_p32_2, ci_pc32_2] = SimuQ(congr3, alphas2);

responses = zeros(1,48);
responses(1,1) = mean(means_p11(5,:)); %cong HR
responses(1,2) = mean(means_p11(2,:)); %cong LR
responses(1,3) = mean(means_p11(6,:)); %incong HR
responses(1,4) = mean(means_p11(3,:)); %incong LR
responses(1,5) = mean(means_p12(5,:));
responses(1,6) = mean(means_p12(2,:));
responses(1,7) = mean(means_p12(6,:));
responses(1,8) = mean(means_p12(3,:));
responses(1,9) = mean(means_p21(5,:));
responses(1,10) = mean(means_p21(2,:));
responses(1,11) = mean(means_p21(6,:));
responses(1,12) = mean(means_p21(3,:));
responses(1,13) = mean(means_p22(5,:));
responses(1,14) = mean(means_p22(2,:));
responses(1,15) = mean(means_p22(6,:));
responses(1,16) = mean(means_p22(3,:));
responses(1,17) = mean(means_p31(5,:));
responses(1,18) = mean(means_p31(2,:));
responses(1,19) = mean(means_p31(6,:));
responses(1,20) = mean(means_p31(3,:));
responses(1,21) = mean(means_p32(5,:));
responses(1,22) = mean(means_p32(2,:));
responses(1,23) = mean(means_p32(6,:));
responses(1,24) = mean(means_p32(3,:));

responses(1,25) = mean(means_p11_2(5,:));
responses(1,26) = mean(means_p11_2(2,:));
responses(1,27) = mean(means_p11_2(6,:));
responses(1,28) = mean(means_p11_2(3,:));
responses(1,29) = mean(means_p12_2(5,:));
responses(1,30) = mean(means_p12_2(2,:));
responses(1,31) = mean(means_p12_2(6,:));
responses(1,32) = mean(means_p12_2(3,:));
responses(1,33) = mean(means_p21_2(5,:));
responses(1,34) = mean(means_p21_2(2,:));
responses(1,35) = mean(means_p21_2(6,:));
responses(1,36) = mean(means_p21_2(3,:));
responses(1,37) = mean(means_p22_2(5,:));
responses(1,38) = mean(means_p22_2(2,:));
responses(1,39) = mean(means_p22_2(6,:));
responses(1,40) = mean(means_p22_2(3,:));
responses(1,41) = mean(means_p31_2(5,:));
responses(1,42) = mean(means_p31_2(2,:));
responses(1,43) = mean(means_p31_2(6,:));
responses(1,44) = mean(means_p31_2(3,:));
responses(1,45) = mean(means_p32_2(5,:));
responses(1,46) = mean(means_p32_2(2,:));
responses(1,47) = mean(means_p32_2(6,:));
responses(1,48) = mean(means_p32_2(3,:));

responses_ci = zeros(1,24);
responses_ci(1,1) = 1.96*std(means_p11(5,:))/sqrt(40);
responses_ci(1,2) = 1.96*std(means_p11(2,:))/sqrt(40);
responses_ci(1,3) = 1.96*std(means_p11(6,:))/sqrt(40);
responses_ci(1,4) = 1.96*std(means_p11(3,:))/sqrt(40);
responses_ci(1,5) = 1.96*std(means_p12(5,:))/sqrt(40);
responses_ci(1,6) = 1.96*std(means_p12(2,:))/sqrt(40);
responses_ci(1,7) = 1.96*std(means_p12(6,:))/sqrt(40);
responses_ci(1,8) = 1.96*std(means_p12(3,:))/sqrt(40);
responses_ci(1,9) = 1.96*std(means_p21(5,:))/sqrt(40);
responses_ci(1,10) = 1.96*std(means_p21(2,:))/sqrt(40);
responses_ci(1,11) = 1.96*std(means_p21(6,:))/sqrt(40);
responses_ci(1,12) = 1.96*std(means_p21(3,:))/sqrt(40);
responses_ci(1,13) = 1.96*std(means_p22(5,:))/sqrt(40);
responses_ci(1,14) = 1.96*std(means_p22(2,:))/sqrt(40);
responses_ci(1,15) = 1.96*std(means_p22(6,:))/sqrt(40);
responses_ci(1,16) = 1.96*std(means_p22(3,:))/sqrt(40);
responses_ci(1,17) = 1.96*std(means_p31(5,:))/sqrt(40);
responses_ci(1,18) = 1.96*std(means_p31(2,:))/sqrt(40);
responses_ci(1,19) = 1.96*std(means_p31(6,:))/sqrt(40);
responses_ci(1,20) = 1.96*std(means_p31(3,:))/sqrt(40);
responses_ci(1,21) = 1.96*std(means_p32(5,:))/sqrt(40);
responses_ci(1,22) = 1.96*std(means_p32(2,:))/sqrt(40);
responses_ci(1,23) = 1.96*std(means_p32(6,:))/sqrt(40);
responses_ci(1,24) = 1.96*std(means_p32(3,:))/sqrt(40);

%Perform 4-way ANOVA
y = responses;
g1 = {'hr';'lr';'hr';'lr';'hr';'lr';'hr';'lr';'hr';'lr';'hr';'lr';'hr';'lr';'hr';'lr';'hr';'lr';'hr';'lr';'hr';'lr';'hr';'lr'}; %HR/LR
g2 = {'cong';'cong';'incong';'incong';'cong';'cong';'incong';'incong';'cong';'cong';'incong';'incong';'cong';'cong';'incong';'incong';'cong';'cong';'incong';'incong';'cong';'cong';'incong';'incong'}; %cong/incong
g3 = {'par';'par';'par';'par';'sym';'sym';'sym';'sym';'par';'par';'par';'par';'sym';'sym';'sym';'sym';'par';'par';'par';'par';'sym';'sym';'sym';'sym'}; %par/sym
g4 = transpose([75 75 75 75 75 75 75 75 85 85 85 85 85 85 85 85 95 95 95 95 95 95 95 95]); %congruency

varnames={'Res','Cong','Pattern','Ratio'};
[~,~,stats2] = anovan(y,{[g1;g1] [g2;g2] [g3;g3] [g4;g4]},'model', 'full', 'varnames', varnames);

%results = multcompare(stats2,'Dimension',[1 2 3]);
%results2 = multcompare(stats2,'Dimension',[2 3]);




titles = ["free LR", "cong LR", "incong LR", "free HR", "cong HR", "incong HR", "free HR+LR", "cong HR+LR", "incong HR+LR"];

%plot percent correct
figure 
errorbar(responses(1, [1 3 5 7]), responses_ci(1, [1 3 5 7]), 'Marker', '.', 'markersize', 12, 'LineStyle', 'none')
hold on
errorbar(responses(1, [2 4 6 8]), responses_ci(1, [1 3 5 7]), 'Marker', '.', 'markersize', 12, 'LineStyle', 'none') 
hold off
legend('HR', 'LR')
title('Mean p(correct)')
xticks(1:4)
xticklabels({'par-cong', 'par-incong', 'sym-cong', 'sym-incong'})
xtickangle(45)
xlim([0 5])
ylim([0.7 1])
grid
saveas(gcf,'meanpcorrect_HRLR.png')


%plot percent correct
% figure 
% errorbar(eight_factors, eight_factors_ci, 'Marker', '.', 'markersize', 12, 'LineStyle', 'none') 
% hold off
% legend('Mean p(correct)')
% title('Mean p(correct) in 8 types of block')
% xticks(1:8)
% xticklabels({'par-cong-HR', 'par-cong-LR', 'par-incong-HR', 'par-incong-LR', 'sym-cong-HR', 'sym-cong-LR', 'sym-incong-HR', 'sym-incong-LR'})
% xtickangle(45)
% xlim([0 9])
% ylim([0.5 1])
% grid
% saveas(gcf,'anova_plot_8factors.png')

% for i = 1:9
%     figure 
%     errorbar(means_p11(i, :), ci_p11(i, :)) 
%     hold on
%     errorbar(means_p21(i, :), ci_p21(i, :)) 
%     hold on
%     errorbar(means_p31(i, :), ci_p31(i, :)) 
%     hold off
%     legend('75-25','85-15','95-5','Location','southeast')
%     title(["p(correct), parallel, " titles(i)])
%     grid
%     saveas(gcf,['simu3_pcorrect_par' num2str(i) '.png'])
%     
%     figure 
%     errorbar(means_p12(i, :), ci_p12(i, :)) 
%     hold on
%     errorbar(means_p22(i, :), ci_p22(i, :)) 
%     hold on
%     errorbar(means_p32(i, :), ci_p32(i, :)) 
%     hold off
%     legend('75-25','85-15','95-5','Location','southeast')
%     title(["p(correct), symmetrical, " titles(i)])
%     grid
%     saveas(gcf,['simu3_pcorrect_sym' num2str(i) '.png'])
%     
%     figure 
%     errorbar(means_p11(i, :), ci_p11(i, :)) 
%     hold on
%     errorbar(means_p12(i, :), ci_p12(i, :)) 
%     hold off
%     legend('parallel', 'symmetrical', 'Location', 'southeast')
%     title(["p(correct), 75-25, " titles(i)])
%     grid
%     saveas(gcf,['simu3_pcorrect_7525_' num2str(i) '.png'])
%     
%     figure 
%     errorbar(means11(2*i, :), ci11(2*i, :), 'Color', '#fa3208') 
%     hold on
%     errorbar(means21(2*i, :), ci21(2*i, :), 'Color', '#061dfe') 
%     hold on
%     errorbar(means31(2*i, :), ci31(2*i, :), 'Color', '#048c12') 
%     hold on
%     errorbar(means11(2*i-1, :), ci11(2*i-1, :), 'Color', '#f9a08d') 
%     hold on
%     errorbar(means21(2*i-1, :), ci21(2*i-1, :), 'Color', '#98a1fa') 
%     hold on
%     errorbar(means31(2*i-1, :), ci31(2*i-1, :), 'Color', '#61f570') 
%     hold off
%     legend('Q(2) 75-25', 'Q(2) 85-15', 'Q(2) 95-5', 'Q(1) 75-25', 'Q(1) 85-15', 'Q(1) 95-5', 'Location','eastoutside')
%     title(["Q-values, parallel, " titles(i)])
%     grid
%     saveas(gcf,['simu3_Qvalues_par' num2str(i) '.png'])
%     
%     figure 
%     errorbar(means12(2*i, :), ci12(2*i, :), 'Color', '#fa3208') 
%     hold on  
%     errorbar(means22(2*i, :), ci22(2*i, :), 'Color', '#061dfe') 
%     hold on
%     errorbar(means32(2*i, :), ci32(2*i, :), 'Color', '#048c12') 
%     hold on
%     errorbar(means12(2*i-1, :), ci12(2*i-1, :), 'Color', '#f9a08d') 
%     hold on
%     errorbar(means22(2*i-1, :), ci22(2*i-1, :), 'Color', '#98a1fa') 
%     hold on
%     errorbar(means32(2*i-1, :), ci32(2*i-1, :), 'Color', '#61f570') 
%     hold off
%     legend('Q(2) 75-25', 'Q(2) 85-15', 'Q(2) 95-5', 'Q(1) 75-25', 'Q(1) 85-15', 'Q(1) 95-5', 'Location','eastoutside')
%     title(["Q-values, symmetrical, " titles(i)])
%     grid
%     saveas(gcf,['simu3_Qvalues_sym' num2str(i) '.png'])
%     
%     figure 
%     errorbar(means12(2*i, :), ci12(2*i, :), 'Color', '#061dfe') 
%     hold on
%     errorbar(means11(2*i, :), ci11(2*i, :), 'Color', '#fa3208') 
%     hold on
%     errorbar(means11(2*i-1, :), ci11(2*i-1, :), 'Color', '#f9a08d') 
%     hold on
%     errorbar(means12(2*i-1, :), ci12(2*i-1, :), 'Color', '#98a1fa') 
%     hold off
%     legend('Q(2) symmetrical', 'Q(2) parallel', 'Q(1) parallel', 'Q(1) symmetrical', 'Location', 'eastoutside')
%     title(["Q-values, 75-25, " titles(i)])
%     grid
%     saveas(gcf,['simu3_Qvalues_7525_' num2str(i) '.png'])
% end

% figure 
% errorbar(means31(14, :), ci31(14, :), 'Color', '#fa3208') 
% hold on  
% errorbar(means31(16, :), ci31(16, :), 'Color', '#061dfe') 
% hold on
% errorbar(means31(18, :), ci31(18, :), 'Color', '#048c12') 
% hold on
% errorbar(means31(13, :), ci31(13, :), 'Color', '#f9a08d') 
% hold on
% errorbar(means31(15, :), ci31(15, :), 'Color', '#98a1fa') 
% hold on
% errorbar(means31(17, :), ci31(17, :), 'Color', '#61f570') 
% hold off
% legend('Q(2) free', 'Q(2) cong', 'Q(2) incong', 'Q(1) free', 'Q(1) cong', 'Q(1) incong', 'Location','eastoutside')
% title("Q-values, parallel, 95-5")
% grid
% saveas(gcf,'simu3_Qvalues_par955.png')
% 
% figure 
% errorbar(means32(14, :), ci32(14, :), 'Color', '#fa3208') 
% hold on  
% errorbar(means32(16, :), ci32(16, :), 'Color', '#061dfe') 
% hold on
% errorbar(means32(18, :), ci32(18, :), 'Color', '#048c12') 
% hold on
% errorbar(means32(13, :), ci32(13, :), 'Color', '#f9a08d') 
% hold on
% errorbar(means32(15, :), ci32(15, :), 'Color', '#98a1fa') 
% hold on
% errorbar(means32(17, :), ci32(17, :), 'Color', '#61f570') 
% hold off
% legend('Q(2) free', 'Q(2) cong', 'Q(2) incong', 'Q(1) free', 'Q(1) cong', 'Q(1) incong', 'Location','eastoutside')
% title("Q-values, symmetrical, 95-5")
% grid
% saveas(gcf,'simu3_Qvalues_sym955.png')