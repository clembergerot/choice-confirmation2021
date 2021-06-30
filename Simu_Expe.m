function [mean_pc, mean_Q] = Simu_Expe(congr, alphas, beta, n_it, n_trials)

    Alpha = alphas; 
    Beta = beta;
    parameters=[Beta, Alpha];

    percent_correct = zeros(n_it, 6); %stores % of correct choices
    
    Q_values = zeros(2*n_it, 6*n_trials); 

    for iteration = 1:n_it

        %generate blocks
        structure = [0 0 1 1 2 2 ; 0 1 0 1 0 1]; %0=free, 1=cong, 2=incong; 0=LR, 1=HR

        choice  = zeros(1, 10*n_trials) ;
        outcome = zeros(1, 10*n_trials) ;
        Q = zeros(2, 10*n_trials); %initialize Q-values

        trialIdx = 0; %counts trials in the whole experiment
        last_free_choice=1*(rand <= 0.5) + 1; %initialize last free choice


        for block = 1:6
            
            Q_free = zeros(2, n_trials);
            t_free = 1;

            Q(:, trialIdx+1) = 0; %initialize Q-values
            c_correct = 0; %initialize count of correct choices

            if structure(1, block) == 0 %free condition
                trials = zeros(1, n_trials);

            elseif structure(1, block) == 1 %intermixed congruent condition
                trials = assign(zeros(1, 2*n_trials), [repelem(0, n_trials) repelem(1, int32(congr*n_trials)) repelem(2, int32((1-congr)*n_trials))]); %generate trials in intermixed congruent block

            else %intermixed incongruent condition
                trials = assign(zeros(1, 2*n_trials), [repelem(0, n_trials) repelem(1, int32((1-congr)*n_trials)) repelem(2, int32(congr*n_trials))]); %generate trials in intermixed incongruent block

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
                outcome(trialIdx) = (choice(trialIdx) == 2) * ((structure(2, block) == 0) * (-1 + 2*(rand <= 0.4)) + (structure(2, block) == 1)*(-1 + 2*(rand <= 0.9))) + (choice(trialIdx) == 1) * ((structure(2, block) == 0) * (-1 + 2*(rand <= 0.1)) + (structure(2, block) == 1)*(-1 + 2*(rand <= 0.6)));

                %compute prediction error
                deltaI = outcome(trialIdx) - Q(choice(trialIdx), trialIdx) ;

                %update Q-values
                Q(:, trialIdx+1)  =  Q(:, trialIdx);
                if trials(t) == 0 %if trial was free: update Q-values using alpha_free
                    Q(choice(trialIdx), trialIdx+1)   =  Q(choice(trialIdx), trialIdx) + parameters(2) * deltaI * (deltaI>0) + parameters(3) * deltaI * (deltaI<0) ;
                    Q_free(:, t_free+1) = Q_free(:, t_free);
                    Q_free(choice(trialIdx), t_free+1) = Q(choice(trialIdx), trialIdx+1);
                    t_free = t_free + 1;
                else %if trial was forced: update Q-values using alpha_forced
                    if length(parameters) == 4 %Model 3a
                        Q(choice(trialIdx), trialIdx+1)   =  Q(choice(trialIdx), trialIdx) + parameters(4) * deltaI;
                    elseif length(parameters) == 5 %Models 4aO and 4aP
                        Q(choice(trialIdx), trialIdx+1)   =  Q(choice(trialIdx), trialIdx) + parameters(4) * deltaI * (deltaI>0) + parameters(5) * deltaI * (deltaI<0) ;
                    elseif length(parameters) == 7 %Model 6a
                        if trials(t) == 1 %congruent trial
                            Q(choice(trialIdx), trialIdx+1) =  Q(choice(trialIdx), trialIdx) + parameters(4) * deltaI * (deltaI>0) + parameters(5) * deltaI * (deltaI<0) ;
                        else %incongruent trial
                            Q(choice(trialIdx), trialIdx+1) =  Q(choice(trialIdx), trialIdx) + parameters(6) * deltaI * (deltaI>0) + parameters(7) * deltaI * (deltaI<0) ;
                        end
                    end     
                end

            end

            %store percentage of correct trials in the corresponding matrix
            percent_correct(iteration, 2*structure(1, block)+structure(2, block)+1) = 100*(c_correct/n_trials);
            
            %store Q_values in the corresponding matrix
            Q_free = Q_free(:,1:n_trials);
            Q_values([iteration iteration+n_it], (2*structure(1, block)+structure(2, block))*n_trials+1:(2*structure(1, block)+structure(2, block)+1)*n_trials) = Q_free;
            
        end

    end

    mean_pc = mean(percent_correct);
    
    mean_Q1 = mean(Q_values(1:n_it, :));
    mean_Q2 = mean(Q_values(n_it+1:2*n_it, :));
    
    mean_Q = [mean_Q1 ; mean_Q2];

end

function conditions = assign(mat, cond)
    assign_vect = randsample(1:length(mat(1,:)), length(mat(1,:)));
    for i = 1:length(assign_vect)
       mat(:,assign_vect(i)) = cond(:,i); 
    end
    conditions = mat;
end