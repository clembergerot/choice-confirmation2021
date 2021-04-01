function [means, means_p, mean_pc, ci, ci_p, ci_pc] = SimuQ(congr, alphas) 

    Alpha = alphas; %alpha-pattern: freePos, freeNeg, forcedPos, forcedNeg
    beta = 5;
    parameters=[beta, Alpha];

    Q_free_hr = zeros(2000, 80); %stores Q-values from free trials of free HR blocks 
    Q_cong_hr = zeros(2000, 80); %stores Q-values from free trials of intermixed congruent HR blocks 
    Q_incong_hr = zeros(2000, 80); %stores Q-values from free trials of intermixed incongruent HR blocks 
    Q_free_lr = zeros(2000, 80); %stores Q-values from free trials of free LR blocks
    Q_cong_lr = zeros(2000, 80); %stores Q-values from free trials of intermixed congruent LR blocks
    Q_incong_lr = zeros(2000, 80); %stores Q-values from free trials of intermixed incongruent LR blocks

    p_free_hr = zeros(1000, 80); %stores correct choices from free trials of free HR blocks 
    p_cong_hr = zeros(1000, 80); %stores correct choices from free trials of intermixed congruent HR blocks 
    p_incong_hr = zeros(1000, 80); %stores correct choices from free trials of intermixed incongruent HR blocks 
    p_free_lr = zeros(1000, 80); %stores correct choices from free trials of free LR blocks
    p_cong_lr = zeros(1000, 80); %stores correct choices from free trials of intermixed congruent LR blocks
    p_incong_lr = zeros(1000, 80); %stores correct choices from free trials of intermixed incongruent LR blocks

    percent_correct = zeros(2000, 6); %stores % of correct choices



    for iteration = 1:1000

        %generate blocks
        config = assign(zeros(2, 12), [0 0 0 0 1 1 1 1 2 2 2 2 ; 0 0 1 1 0 0 1 1 0 0 1 1]); %0=free, 1=cong, 2=incong; 0=LR, 1=HR
        ffci = config(1,:) ; %free, forced congruent and forced incongruent conditions
        hrlr = config(2,:) ; %High-reward/Low-reward conditions

        cfl=0; %counts free trials across free blocks, LR
        ciil=0; %counts free trials across incong blocks, LR
        cicl=0; %counts free trials across cong blocks, LR
        cfh=0; %counts free trials across free blocks, HR
        ciih=0; %counts free trials across incong blocks, HR
        cich=0; %counts free trials across cong blocks, HR

        choice  = zeros(1, 800) ;
        outcome = zeros(1, 800) ;
        Q = zeros(2, 800); %initialize Q-values

        trialIdx = 0; %counts trials in the whole experiment
        last_free_choice=1*(rand <= 0.5) + 1; %initialize last free choice


        for block = 1:12

            Q(:, trialIdx+1) = 0; %initialize Q-values
            c_correct = 0; %initialize count of correct choices

            if ffci(block) == 0 %free condition
                trials = zeros(1, 40);

            elseif ffci(block) == 1 %intermixed congruent condition
                trials = assign(zeros(1, 80), [repelem(0, 40) repelem(1, int32(congr*40)) repelem(2, int32((1-congr)*40))]); %generate trials in intermixed congruent block

            else %intermixed incongruent condition
                trials = assign(zeros(1, 80), [repelem(0, 40) repelem(1, int32((1-congr)*40)) repelem(2, int32(congr*40))]); %generate trials in intermixed incongruent block

            end   

            for t = 1:length(trials)

                trialIdx = trialIdx + 1;

                if trials(t) == 0 % free trials
                    proba_action_1 = 1/(1 + exp( parameters(1) * (Q(2, trialIdx) - Q(1, trialIdx)) )) ; %softmax
                    choice(trialIdx) = 1*(proba_action_1 < rand) + 1 ;
                    last_free_choice = choice(trialIdx);
                    c_correct = c_correct + 1*(choice(trialIdx) == 2);

                elseif trials(t) == 1 %congruent trials
                    choice(trialIdx) = last_free_choice; %congruent choice

                else %incongruent trials
                    choice(trialIdx) = 2 * (last_free_choice == 1) + 1 * (last_free_choice == 2); %incongruent choice

                end

                %compute outcome
                outcome(trialIdx) = (choice(trialIdx) == 2) * ((hrlr(block) == 0) * (-1 + 2*(rand <= 0.4)) + (hrlr(block) == 1)*(-1 + 2*(rand <= 0.9))) + (choice(trialIdx) == 1) * ((hrlr(block) == 0) * (-1 + 2*(rand <= 0.1)) + (hrlr(block) == 1)*(-1 + 2*(rand <= 0.6)));

                %compute prediction error
                deltaI = outcome(trialIdx) - Q(choice(trialIdx), trialIdx) ;

                %update Q-values
                if trials(t) == 0 %if trial was free: update Q-values using alpha_free
                    Q(:, trialIdx+1)  =  Q(:, trialIdx);
                    Q(choice(trialIdx), trialIdx+1)   =  Q(choice(trialIdx), trialIdx) + parameters(2) * deltaI * (deltaI>0) + parameters(3) * deltaI * (deltaI<0) ;
                else %if trial was forced: update Q-values using alpha_forced
                    Q(:, trialIdx+1)  =  Q(:, trialIdx);
                    Q(choice(trialIdx), trialIdx+1)   =  Q(choice(trialIdx), trialIdx) + parameters(4) * deltaI * (deltaI>0) + parameters(5) * deltaI * (deltaI<0) ;
                end

                %store Q-values in the corresponding matrix
                if trials(t) == 0 %if trial was free
                    if ffci(block) == 0 %free blocks
                        if hrlr(block) == 0 %LR condition
                            cfl=cfl+1;
                            Q_free_lr(iteration, cfl) = Q(1, trialIdx); %Q(1)
                            Q_free_lr(iteration+1000, cfl) = Q(2, trialIdx); %Q(2)
                            p_free_lr(iteration, cfl) = 1*(choice(trialIdx)==2); 
                        else %HR condition
                            cfh=cfh+1;
                            Q_free_hr(iteration, cfh) = Q(1, trialIdx); %Q(1)
                            Q_free_hr(iteration+1000, cfh) = Q(2, trialIdx); %Q(2)
                            p_free_hr(iteration, cfh) = 1*(choice(trialIdx)==2);
                        end

                    elseif ffci(block) == 1 %cong blocks
                        if hrlr(block) == 0 %LR condition
                            cicl=cicl+1;
                            Q_cong_lr(iteration, cicl) = Q(1, trialIdx);
                            Q_cong_lr(iteration+1000, cicl) = Q(2, trialIdx);
                            p_cong_lr(iteration, cicl) = 1*(choice(trialIdx)==2);
                        else %HR condition
                            cich=cich+1;
                            Q_cong_hr(iteration, cich) = Q(1, trialIdx);
                            Q_cong_hr(iteration+1000, cich) = Q(2, trialIdx);
                            p_cong_hr(iteration, cich) = 1*(choice(trialIdx)==2);
                        end

                    else %incong blocks  
                        if hrlr(block) == 0 %LR condition
                            ciil=ciil+1;
                            Q_incong_lr(iteration, ciil) = Q(1, trialIdx);
                            Q_incong_lr(iteration+1000, ciil) = Q(2, trialIdx);
                            p_incong_lr(iteration, ciil) = 1*(choice(trialIdx)==2);
                        else %HR condition
                            ciih=ciih+1;
                            Q_incong_hr(iteration, ciih) = Q(1, trialIdx);
                            Q_incong_hr(iteration+1000, ciih) = Q(2, trialIdx);
                            p_incong_hr(iteration, ciih) = 1*(choice(trialIdx)==2);
                        end

                    end 

                end

            end

            %store percentage of correct trials in the corresponding matrix
            if percent_correct(iteration, 2*ffci(block)+hrlr(block)+1)==0
                percent_correct(iteration, 2*ffci(block)+hrlr(block)+1) = 100*(c_correct/40);
            else
                percent_correct(iteration+1000, 2*ffci(block)+hrlr(block)+1) = 100*(c_correct/40);
            end

        end

    end

    means = zeros(18, 40); %means
    means_p = zeros(9, 40);
    ci = zeros(18, 40); %confidence intervals
    ci_p = zeros(9, 40);

    for i = 1:40
        means(1, i) = mean(reshape(Q_free_lr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) free LR blocks
        means(2, i) = mean(reshape(Q_free_lr(1001:2000, [i 40+i]), [1,2000])); %mean of Q(2) free LR blocks
        means(3, i) = mean(reshape(Q_cong_lr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) cong LR blocks
        means(4, i) = mean(reshape(Q_cong_lr(1001:2000, [i 40+i]), [1,2000])); %mean of Q(2) cong LR blocks
        means(5, i) = mean(reshape(Q_incong_lr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) incong LR blocks
        means(6, i) = mean(reshape(Q_incong_lr(1001:2000, [i 40+i]), [1,2000])); %mean of Q(2) incong LR blocks
        means(7, i) = mean(reshape(Q_free_hr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) free HR blocks
        means(8, i) = mean(reshape(Q_free_hr(1001:2000, [i 40+i]), [1,2000])); %mean of Q(2) free HR blocks
        means(9, i) = mean(reshape(Q_cong_hr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) cong HR blocks
        means(10, i) = mean(reshape(Q_cong_hr(1001:2000, [i 40+i]), [1,2000])); %mean of Q(2) cong HR blocks
        means(11, i) = mean(reshape(Q_incong_hr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) incong HR blocks
        means(12, i) = mean(reshape(Q_incong_hr(1001:2000, [i 40+i]), [1,2000])); %mean of Q(2) incong HR blocks
        means(13, i) = mean(reshape([Q_free_hr(1:1000, [i 40+i]) Q_free_lr(1:1000, [i 40+i])], [1,4000])); %mean of Q(1) free blocks
        means(14, i) = mean(reshape([Q_free_hr(1001:2000, [i 40+i]) Q_free_lr(1001:2000, [i 40+i])], [1,4000])); %mean of Q(2) free blocks
        means(15, i) = mean(reshape([Q_cong_hr(1:1000, [i 40+i]) Q_cong_lr(1:1000, [i 40+i])], [1,4000])); %mean of Q(1) cong blocks
        means(16, i) = mean(reshape([Q_cong_hr(1001:2000, [i 40+i]) Q_cong_lr(1001:2000, [i 40+i])], [1,4000])); %mean of Q(2) cong blocks
        means(17, i) = mean(reshape([Q_incong_hr(1:1000, [i 40+i]) Q_incong_lr(1:1000, [i 40+i])], [1,4000])); %mean of Q(1) incong blocks
        means(18, i) = mean(reshape([Q_incong_hr(1001:2000, [i 40+i]) Q_incong_lr(1001:2000, [i 40+i])], [1,4000])); %mean of Q(2) incong blocks

        means_p(1, i) = mean(reshape(p_free_lr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) free LR blocks
        means_p(2, i) = mean(reshape(p_cong_lr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) cong LR blocks
        means_p(3, i) = mean(reshape(p_incong_lr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) incong LR blocks
        means_p(4, i) = mean(reshape(p_free_hr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) free HR blocks
        means_p(5, i) = mean(reshape(p_cong_hr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) cong HR blocks
        means_p(6, i) = mean(reshape(p_incong_hr(1:1000, [i 40+i]), [1,2000])); %mean of Q(1) incong HR blocks
        means_p(7, i) = mean(reshape([p_free_hr(1:1000, [i 40+i]) p_free_lr(1:1000, [i 40+i])], [1,4000])); %mean of Q(1) free blocks
        means_p(8, i) = mean(reshape([p_cong_hr(1:1000, [i 40+i]) p_cong_lr(1:1000, [i 40+i])], [1,4000])); %mean of Q(1) cong blocks
        means_p(9, i) = mean(reshape([p_incong_hr(1:1000, [i 40+i]) p_incong_lr(1:1000, [i 40+i])], [1,4000])); %mean of Q(1) incong blocks

        ci(1, i) = 1.96*(std(reshape(Q_free_lr(1:1000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(2, i) = 1.96*(std(reshape(Q_free_lr(1001:2000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(3, i) = 1.96*(std(reshape(Q_cong_lr(1:1000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(4, i) = 1.96*(std(reshape(Q_cong_lr(1001:2000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(5, i) = 1.96*(std(reshape(Q_incong_lr(1:1000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(6, i) = 1.96*(std(reshape(Q_incong_lr(1001:2000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(7, i) = 1.96*(std(reshape(Q_free_hr(1:1000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(8, i) = 1.96*(std(reshape(Q_free_hr(1001:2000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(9, i) = 1.96*(std(reshape(Q_cong_hr(1:1000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(10, i) = 1.96*(std(reshape(Q_cong_hr(1001:2000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(11, i) = 1.96*(std(reshape(Q_incong_hr(1:1000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(12, i) = 1.96*(std(reshape(Q_incong_hr(1001:2000, [i 40+i]), [1,2000])))/sqrt(2000);
        ci(13, i) = 1.96*(std(reshape([Q_free_hr(1:1000, [i 40+i]) Q_free_lr(1:1000, [i 40+i])], [1,4000])))/sqrt(4000); %mean of Q(2) incong blocks
        ci(14, i) = 1.96*(std(reshape([Q_free_hr(1001:2000, [i 40+i]) Q_free_lr(1001:2000, [i 40+i])], [1,4000])))/sqrt(4000); %mean of Q(1) free blocks
        ci(15, i) = 1.96*(std(reshape([Q_cong_hr(1:1000, [i 40+i]) Q_cong_lr(1:1000, [i 40+i])], [1,4000])))/sqrt(4000); %mean of Q(2) free blocks
        ci(16, i) = 1.96*(std(reshape([Q_cong_hr(1001:2000, [i 40+i]) Q_cong_lr(1001:2000, [i 40+i])], [1,4000])))/sqrt(4000); %mean of Q(1) cong blocks
        ci(17, i) = 1.96*(std(reshape([Q_incong_hr(1:1000, [i 40+i]) Q_incong_lr(1:1000, [i 40+i])], [1,4000])))/sqrt(4000); %mean of Q(2) cong blocks
        ci(18, i) = 1.96*(std(reshape([Q_incong_hr(1001:2000, [i 40+i]) Q_incong_lr(1001:2000, [i 40+i])], [1,4000])))/sqrt(4000); %mean of Q(1) incong blocks

        ci_p(1, i) = 1.96*(std(reshape(p_free_lr(1:1000, [i 40+i]), [1,2000])))/sqrt(1000);
        ci_p(2, i) = 1.96*(std(reshape(p_cong_lr(1:1000, [i 40+i]), [1,2000])))/sqrt(1000);
        ci_p(3, i) = 1.96*(std(reshape(p_incong_lr(1:1000, [i 40+i]), [1,2000])))/sqrt(1000);
        ci_p(4, i) = 1.96*(std(reshape(p_free_hr(1:1000, [i 40+i]), [1,2000])))/sqrt(1000);
        ci_p(5, i) = 1.96*(std(reshape(p_cong_hr(1:1000, [i 40+i]), [1,2000])))/sqrt(1000);
        ci_p(6, i) = 1.96*(std(reshape(p_incong_hr(1:1000, [i 40+i]), [1,2000])))/sqrt(1000);
        ci_p(7, i) = 1.96*(std(reshape([p_free_hr(1:1000, [i 40+i]) p_free_lr(1:1000, [i 40+i])], [1,4000])))/sqrt(4000); %mean of Q(2) incong blocks
        ci_p(8, i) = 1.96*(std(reshape([p_cong_hr(1:1000, [i 40+i]) p_cong_lr(1:1000, [i 40+i])], [1,4000])))/sqrt(4000); %mean of Q(2) free blocks
        ci_p(9, i) = 1.96*(std(reshape([p_incong_hr(1:1000, [i 40+i]) p_incong_lr(1:1000, [i 40+i])], [1,4000])))/sqrt(4000); %mean of Q(2) cong blocks

    end


    mean_pc = mean(percent_correct);
    ci_pc = 1.96*std(percent_correct)/sqrt(2000);

end

function conditions = assign(mat, cond)
    assign_vect = randsample(1:length(mat(1,:)), length(mat(1,:)));
    for i = 1:length(assign_vect)
       mat(:,assign_vect(i)) = cond(:,i); 
    end
    conditions = mat;
end