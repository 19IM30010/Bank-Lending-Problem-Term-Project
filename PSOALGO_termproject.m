%************************************************%
%OHM IM39003
%Particle Swarm Optimization
%Author: Gyanendra Behura/19IM30010
%************************************************%

clc
clear all
close all 
rng default %control for randome number generator
tic %Stopwatch timer
format long
%%Function Bounds
m=1; % no vars
LB=0;
UB=1024;

n=10;
w=0.55;
wdamp=0.99;
c1=0.3;
c2=0.55;
maxite=250;
maxrun=5;

% %%PSO Parsms
% n=50;
% % pop=10:10:50;      % population size
% w=0.1;
% % inertiaWt= 0.1:0.1:0.9; % inertia weight
% wdamp = 0.99;   % inertia deamping
% c1=0.6;     
% c_1=0:0.2:1;% acceleration factor P_best
% % c2=1;  
% c_2=0:0.2:1;% acceleration factor G_best
% % iteration=10:10:100;   
% maxite=50;% set maximum number of iteration in each run
% maxrun=10;      % set maximum number of runs need to be
% 
%% PSO loop

for run=1:maxrun
%     run
    % pso initialization----------------------------------------------start
    for i=1:n
        x0(i)=round(LB+rand()*(UB-LB));
    end
    x=x0;     % initial population
    v=0.1*x0; % initial velocity
    for i=1:n
        f0(i,1)=ofun(x0(i));
    end
    [fmax0,index0]=max(f0);
    pbest=x0;           % initial pbest
    gbest=x0(index0); % initial gbest
    % pso initialization------------------------------------------------end
    % pso algorithm---------------------------------------------------start
    ite=1;
    while ite<=maxite 
        w=w*wdamp;       %updating inertia weight
        % pso velocity updates
        for i=1:n
            v(i)=w*v(i)+c1*rand()*(pbest(i)-x(i))...
                    +c2*rand()*(gbest(1)-x(i));
        end
        % pso position update
        for i=1:n
            x(i)=round(x(i)+v(i));
        end
        % handling boundary violations
        for i=1:n
            if x(i)<LB
                x(i)=LB;
            elseif x(i)>UB
                x(i)=UB;
            end
        end
        % evaluating fitness
        for i=1:n
            f(i,1)=ofun(x(i));
        end
        % updating pbest and fitness
        for i=1:n
            if f(i,1)>f0(i,1)
                pbest(i)=x(i);
                f0(i,1)=f(i,1);
            end
        end
        [fmax,index]=max(f0); % finding out the best particle
        ffmax(ite,run)=fmax;  % storing best fitness
        ffite(run)=ite;       % storing iteration count
        
        % updating gbest and best fitness
        if fmax>fmax0
            gbest=pbest(index);
            fmax0=fmax;
%         else
%             disp(sprintf('--------------------------------------'));
%             ite
        end
        
        %displaying iterative results
        if ite==1
            fprintf('Iteration Best particle Objective fun\n');
        end
        fprintf('%8g %8g %8.4f\n',ite,index,fmax0);
        ite=ite+1;
        
    end
    % pso algorithm-----------------------------------------------------end
    gbest;
    fvalue=ofun(gbest);
    %fvalue=10*(gbest(1)-1)^2+20*(gbest(2)-2)^2+30*(gbest(3)-3)^2;
    fff(run)=fvalue;
    rgbest(run,:)=gbest;
    fprintf('--------------------------------------\n');
end



% pso main program------------------------------------------------------end
disp(newline);
fprintf('*********************************************************\n');
fprintf('Final Results-----------------------------\n');
[bestfun,bestrun]=max(fff);
best_variables=rgbest(bestrun,:);
fprintf('*********************************************************\n');
toc
% PSO convergence characteristic
plot(ffmax(1:ffite(bestrun),bestrun),'-r');
xlabel('Iteration');
ylabel('Fitness function value');
title('PSO convergence characteristic')

figure(2);
plot(x0,f0, 'bd');
xlabel('x');
ylabel('F(x)');
title('Data for last generation');