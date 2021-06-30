file_name = 'SimusAnalysis1Type2meanQ.mat';

load(file_name);

mean_qvals4aO = qmeans_summary.mean_qvals4aO;
mean_qvals4aP = qmeans_summary.mean_qvals4aP;

% plot Q-vals

titles = {'free LR', 'free HR', 'cong LR', 'cong HR', 'incong LR', 'incong HR'};

for i=1:3
    
    j = 2*i - 1;
    k = 2*i;
    
    figure 
    errorbar(mean_qvals4aO(1,(j-1)*40+1:j*40), mean_qvals4aO(1,(5+j)*40+1:(6+j)*40))
    hold on
    errorbar(mean_qvals4aO(2,(j-1)*40+1:j*40), mean_qvals4aO(2,(5+j)*40+1:(6+j)*40))
    hold off
    legend('Q1', 'Q2')
    title(['Evolution of Q-values across free trials (4-Alpha-O Model) ' titles(j)])
    xlabel('Trial index')
    ylabel('Q')
    ylim([-1 1])
    grid
    saveas(gcf,['0506_A1T2_Qvals4aO' num2str(j) '.png'])
    
    figure 
    errorbar(mean_qvals4aO(1,(k-1)*40+1:k*40), mean_qvals4aO(1,(5+k)*40+1:(6+k)*40))
    hold on
    errorbar(mean_qvals4aO(2,(k-1)*40+1:k*40), mean_qvals4aO(2,(5+k)*40+1:(6+k)*40))
    hold off
    legend('Q1', 'Q2', 'Location', 'southeast')
    title(['Evolution of Q-values across free trials (4-Alpha-O Model) ' titles(k)])
    xlabel('Trial index')
    ylabel('Q')
    ylim([-1 1])
    grid
    saveas(gcf,['0506_A1T2_Qvals4aO' num2str(k) '.png'])
    
    figure 
    errorbar(mean_qvals4aP(1,(j-1)*40+1:j*40), mean_qvals4aP(1,(5+j)*40+1:(6+j)*40))
    hold on
    errorbar(mean_qvals4aP(2,(j-1)*40+1:j*40), mean_qvals4aP(2,(5+j)*40+1:(6+j)*40))
    hold off
    legend('Q1', 'Q2')
    title(['Evolution of Q-values across free trials (4-Alpha-P Model) ' titles(j)])
    xlabel('Trial index')
    ylabel('Q')
    ylim([-1 1])
    grid
    saveas(gcf,['0506_A1T2_Qvals4aP' num2str(j) '.png'])
    
    figure 
    errorbar(mean_qvals4aP(1,(k-1)*40+1:k*40), mean_qvals4aP(1,(5+k)*40+1:(6+k)*40))
    hold on
    errorbar(mean_qvals4aP(2,(k-1)*40+1:k*40), mean_qvals4aP(2,(5+k)*40+1:(6+k)*40))
    hold off
    legend('Q1', 'Q2', 'Location', 'southeast')
    title(['Evolution of Q-values across free trials (4-Alpha-P Model) ' titles(k)])
    xlabel('Trial index')
    ylabel('Q')
    ylim([-1 1])
    grid
    saveas(gcf,['0506_A1T2_Qvals4aP' num2str(k) '.png'])

end