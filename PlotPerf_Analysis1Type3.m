file_name = 'SimusAnalysis1Type3mean.mat';

load(file_name);

mean_simus4aO = means_summary.mean_simus4aO;
mean_simus4aP = means_summary.mean_simus4aP;

% plot percent correct
figure 
bar(mean_simus4aO(1:6), 'FaceColor', '#D95319', 'LineStyle', 'none')
hold on
errorbar(mean_simus4aO(1:6), mean_simus4aO(7:12), 'Color', '#000000', 'LineStyle', 'none')
hold off
title('Mean performance across types of blocks (4-Alpha-O Model)')
xlabel('Type of block')
ylabel('% correct trials')
xticks(1:6)
xticklabels({'Free LR', 'Free HR', 'Cong LR', 'Cong HR', 'Incong LR', 'Incong HR'})
xtickangle(45)
xlim([0 7])
ylim([70 95])
grid
saveas(gcf,'0506_A1T3_perf4aO.png')

figure 
bar(mean_simus4aP(1:6), 'FaceColor', '#D95319', 'LineStyle', 'none')
hold on
errorbar(mean_simus4aP(1:6), mean_simus4aP(7:12), 'Color', '#000000', 'LineStyle', 'none')
hold off
title('Mean performance across types of blocks (4-Alpha-P Model)')
xlabel('Type of block')
ylabel('% correct trials')
xticks(1:6)
xticklabels({'Free LR', 'Free HR', 'Cong LR', 'Cong HR', 'Incong LR', 'Incong HR'})
xtickangle(45)
xlim([0 7])
ylim([70 95])
grid
saveas(gcf,'0506_A1T3_perf4aP.png')

figure 
errorbar(mean_simus4aO(1:6), mean_simus4aO(7:12), 'Marker', '.', 'markersize', 12, 'LineStyle', 'none')
hold on
errorbar(mean_simus4aP(1:6), mean_simus4aP(7:12), 'Marker', '.', 'markersize', 12, 'LineStyle', 'none')
hold off
title('Mean performance across types of blocks (both models)')
legend('4-Alpha-O', '4-Alpha-P')
xlabel('Type of block')
ylabel('% correct trials')
xticks(1:6)
xticklabels({'Free LR', 'Free HR', 'Cong LR', 'Cong HR', 'Incong LR', 'Incong HR'})
xtickangle(45)
xlim([0 7])
ylim([70 95])
grid
saveas(gcf,'0506_A1T3_perfBoth.png')