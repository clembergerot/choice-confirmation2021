file_name = 'SimusAnalysis3.mat';

load(file_name);

final_mean3a = means_summary.final_mean3a;
final_mean6a = means_summary.final_mean6a;
final_mean4aO = means_summary.final_mean4aO;
final_mean4aP = means_summary.final_mean4aP;

% plot percent correct
labs = 0.05:0.05:0.95;
labs = string(labs);

figure 
errorbar(final_mean6a(1,:), final_mean6a(2,:), 'Marker', '.', 'markersize', 12)
hold on
errorbar(final_mean6a(3,:), final_mean6a(4,:), 'Marker', '.', 'markersize', 12)
hold off
title('Mean performance across congruency levels (Model 6-Alpha)')
legend('LR', 'HR')
xlabel('Congruency level')
ylabel('% correct trials')
xticks(1:19)
xticklabels(labs)
xtickangle(45)
xlim([0 20])
ylim([60 90])
grid
saveas(gcf,'0506_A3_model6a.png')

figure 
errorbar(final_mean3a(1,:), final_mean3a(2,:), 'Marker', '.', 'markersize', 12)
hold on
errorbar(final_mean3a(3,:), final_mean3a(4,:), 'Marker', '.', 'markersize', 12)
hold off
title('Mean performance across congruency levels (Model 3-Alpha)')
legend('LR', 'HR')
xlabel('Congruency level')
ylabel('% correct trials')
xticks(1:19)
xticklabels(labs)
xtickangle(45)
xlim([0 20])
ylim([60 90])
grid
saveas(gcf,'0506_A3_model3a.png')

figure 
errorbar(final_mean4aO(1,:), final_mean4aO(2,:), 'Marker', '.', 'markersize', 12)
hold on
errorbar(final_mean4aO(3,:), final_mean4aO(4,:), 'Marker', '.', 'markersize', 12)
hold off
title('Mean performance across congruency levels (Model 4-Alpha Optimistic)')
legend('LR', 'HR')
xlabel('Congruency level')
ylabel('% correct trials')
xticks(1:19)
xticklabels(labs)
xtickangle(45)
xlim([0 20])
ylim([60 90])
grid
saveas(gcf,'0506_A3_model4aO.png')

figure 
errorbar(final_mean4aP(1,:), final_mean4aP(2,:), 'Marker', '.', 'markersize', 12)
hold on
errorbar(final_mean4aP(3,:), final_mean4aP(4,:), 'Marker', '.', 'markersize', 12)
hold off
title('Mean performance across congruency levels (Model 4-Alpha Pessimistic)')
legend('LR', 'HR')
xlabel('Congruency level')
ylabel('% correct trials')
xticks(1:19)
xticklabels(labs)
xtickangle(45)
xlim([0 20])
ylim([60 90])
grid
saveas(gcf,'0506_A3_model4aP.png')
