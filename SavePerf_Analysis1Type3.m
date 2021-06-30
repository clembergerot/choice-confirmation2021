Alpha_list4aO = [0.3 0.15 0.3 0.15];
Alpha_list4aP = [0.3 0.15 0.15 0.3];
beta_list4aO = 5;
beta_list4aP = 5;

%Congruency level
conglevel = 0.75;

simus4aO = zeros(1000, 6);
mean_simus4aO = zeros(1, 12);

simus4aP = zeros(1000, 6);
mean_simus4aP = zeros(1, 12);

qvals4aO = zeros(2, 1000, 6*40);
mean_qvals4aO = zeros(2, 12*40);

qvals4aP = zeros(2, 1000, 6*40);
mean_qvals4aP = zeros(2, 12*40);

for i = 1:1000
    [output1, output2] = Simu_Expe(conglevel, Alpha_list4aO, beta_list4aO, 2, 40);
    simus4aO(i, :) = output1;
    qvals4aO(1, i, :) = output2(1, :);
    qvals4aO(2, i, :) = output2(2, :);
    [output1, output2] = Simu_Expe(conglevel, Alpha_list4aP, beta_list4aP, 2, 40);
    simus4aP(i, :) = output1;
    qvals4aP(1, i, :) = output2(1, :);
    qvals4aP(2, i, :) = output2(2, :);
end
   
    mean_simus4aO(1, 1:6) = mean(simus4aO);
    mean_simus4aO(1, 7:12) = 1.96*std(simus4aO)/sqrt(1000);
    
    mean_simus4aP(1, 1:6) = mean(simus4aP);
    mean_simus4aP(1, 7:12) = 1.96*std(simus4aP)/sqrt(1000);
    
    mean_qvals4aO(1, 1:6*40) = mean(qvals4aO(1,:,:));
    mean_qvals4aO(2, 1:6*40) = mean(qvals4aO(2,:,:));
    mean_qvals4aO(1, 6*40+1:12*40) = 1.96*std(qvals4aO(1,:,:))/sqrt(1000);
    mean_qvals4aO(2, 6*40+1:12*40) = 1.96*std(qvals4aO(2,:,:))/sqrt(1000);
    
    mean_qvals4aP(1, 1:6*40) = mean(qvals4aP(1,:,:));
    mean_qvals4aP(2, 1:6*40) = mean(qvals4aP(2,:,:));
    mean_qvals4aP(1, 6*40+1:12*40) = 1.96*std(qvals4aP(1,:,:))/sqrt(1000);
    mean_qvals4aP(2, 6*40+1:12*40) = 1.96*std(qvals4aP(2,:,:))/sqrt(1000);
    
    
%Save in a table
simus_summary = table(simus4aO, simus4aP);
means_summary = table(mean_simus4aO, mean_simus4aP);
save('SimusAnalysis1Type3sim.mat', 'simus_summary');
save('SimusAnalysis1Type3mean.mat', 'means_summary');

qvals_summary = table(qvals4aO, qvals4aP);
qmeans_summary = table(mean_qvals4aO, mean_qvals4aP);
save('SimusAnalysis1Type3simQ.mat', 'qvals_summary');
save('SimusAnalysis1Type3meanQ.mat', 'qmeans_summary');