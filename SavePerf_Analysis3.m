file_name = 'ParamSumAnalysis2.mat';

load(file_name);

Alpha_list3a = Param_summary.Alpha_list3a;
Alpha_list6a = Param_summary.Alpha_list6a;
Alpha_list4aO = Param_summary.Alpha_list4aO;
Alpha_list4aP = Param_summary.Alpha_list4aP;
beta_list3a = Param_summary.beta_list4aO;
beta_list6a = Param_summary.beta_list4aP;
beta_list4aO = Param_summary.beta_list4aO;
beta_list4aP = Param_summary.beta_list4aP;

%Simulations will be performed across different congruency levels, from 5%
%to 95% with increment 5%
congr_list = 0.5:0.05:0.95;

simus6a = zeros(1000, 6);
mean_simus6a = zeros(10, 12);
final_mean6a = zeros(4, 19);

simus3a = zeros(1000, 6);
mean_simus3a = zeros(10, 12);
final_mean3a = zeros(4, 19);

simus4aO = zeros(1000, 6);
mean_simus4aO = zeros(10, 12);
final_mean4aO = zeros(4, 19);

simus4aP = zeros(1000, 6);
mean_simus4aP = zeros(10, 12);
final_mean4aP = zeros(4, 19);

for c = 1:10
    for i = 1:1000
        simus6a(i, :) = Simu_Expe(congr_list(c), Alpha_list6a(i,:), beta_list6a(i), 2, 35);
        simus3a(i, :) = Simu_Expe(congr_list(c), Alpha_list3a(i,:), beta_list3a(i), 2, 35);
        simus4aO(i, :) = Simu_Expe(congr_list(c), Alpha_list4aO(i,:), beta_list4aO(i), 2, 35);
        simus4aP(i, :) = Simu_Expe(congr_list(c), Alpha_list4aP(i,:), beta_list4aP(i), 2, 35);
    end
    mean_simus6a(c, 1:6) = mean(simus6a);
    mean_simus6a(c, 7:12) = 1.96*std(simus6a)/sqrt(1000);
    
    mean_simus3a(c, 1:6) = mean(simus3a);
    mean_simus3a(c, 7:12) = 1.96*std(simus3a)/sqrt(1000);
    
    mean_simus4aO(c, 1:6) = mean(simus4aO);
    mean_simus4aO(c, 7:12) = 1.96*std(simus4aO)/sqrt(1000);
    
    mean_simus4aP(c, 1:6) = mean(simus4aP);
    mean_simus4aP(c, 7:12) = 1.96*std(simus4aP)/sqrt(1000);
    
    final_mean6a(1,9+c) = mean_simus6a(c, 3);
    final_mean6a(1,11-c) = mean_simus6a(c, 5);
    final_mean6a(2,9+c) = mean_simus6a(c, 9);
    final_mean6a(2,11-c) = mean_simus6a(c, 11);
    final_mean6a(3,9+c) = mean_simus6a(c, 4);
    final_mean6a(3,11-c) = mean_simus6a(c, 6);
    final_mean6a(4,9+c) = mean_simus6a(c, 10);
    final_mean6a(4,11-c) = mean_simus6a(c, 12);
    
    final_mean3a(1,9+c) = mean_simus3a(c, 3);
    final_mean3a(1,11-c) = mean_simus3a(c, 5);
    final_mean3a(2,9+c) = mean_simus3a(c, 9);
    final_mean3a(2,11-c) = mean_simus3a(c, 11);
    final_mean3a(3,9+c) = mean_simus3a(c, 4);
    final_mean3a(3,11-c) = mean_simus3a(c, 6);
    final_mean3a(4,9+c) = mean_simus3a(c, 10);
    final_mean3a(4,11-c) = mean_simus3a(c, 12);
    
    final_mean4aO(1,9+c) = mean_simus4aO(c, 3);
    final_mean4aO(1,11-c) = mean_simus4aO(c, 5);
    final_mean4aO(2,9+c) = mean_simus4aO(c, 9);
    final_mean4aO(2,11-c) = mean_simus4aO(c, 11);
    final_mean4aO(3,9+c) = mean_simus4aO(c, 4);
    final_mean4aO(3,11-c) = mean_simus4aO(c, 6);
    final_mean4aO(4,9+c) = mean_simus4aO(c, 10);
    final_mean4aO(4,11-c) = mean_simus4aO(c, 12);
    
    final_mean4aP(1,9+c) = mean_simus4aP(c, 3);
    final_mean4aP(1,11-c) = mean_simus4aP(c, 5);
    final_mean4aP(2,9+c) = mean_simus4aP(c, 9);
    final_mean4aP(2,11-c) = mean_simus4aP(c, 11);
    final_mean4aP(3,9+c) = mean_simus4aP(c, 4);
    final_mean4aP(3,11-c) = mean_simus4aP(c, 6);
    final_mean4aP(4,9+c) = mean_simus4aP(c, 10);
    final_mean4aP(4,11-c) = mean_simus4aP(c, 12);
end

%Save in a table
simus_summary = table(simus3a, simus6a, simus4aO, simus4aP);
means_summary = table(final_mean3a, final_mean6a, final_mean4aO, final_mean4aP);
save('SimusAnalysis3.mat', 'simus_summary');
save('SimusAnalysis3.mat', 'means_summary');