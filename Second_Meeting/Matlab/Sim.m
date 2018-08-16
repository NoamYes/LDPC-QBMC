clear;

%% as for now, simulating two codes with certain noises decoding

H =  [1, 1, 0, 1, 1, 0, 0; 
1, 0, 1, 1, 0, 1, 0; 
0, 1, 1, 1, 0, 0, 1]; 

QM =-1;
noised = [ 0 QM QM 1 0 QM 0];
decoded1 = Iter_Method(H, noised, QM);


H =  [1, 0, 1, 1, 0, 0; 
1, 1, 0, 0, 1, 0; 
0, 1, 1, 0, 0, 1]; 

noised = [ QM 0 1 QM 1 QM];
decoded2 = Iter_Method(H, noised, QM);


%%
% below will be a code generating graph for erasure rate versus dv/dc as
% requested

    n = 600; %n
    k = round(n/2); %k
    QM = -1; %the question mark value > 0
    inc = 0.05;
    tryNum = 1; %how many matrixes to generate for a given epsilon

    eps_vec = 0:inc:1;
    total_e_rate = zeros(1,length(eps_vec));
    count = 1;
    dv = 3; 
    dc = 6;
    
    for eps = eps_vec %run on epsilon values from 0 to 1 in increments of inc
        totalNoise = zeros(1, tryNum);
        H_e_rate = 0;
        eps_e_rate = 0;
        for i = 1:tryNum
            [ H ] = Generate_LDCP_H( dv, dc, k, n ); %generate a random H matrix
            for j = 1:20
                vec = BECnoise(n, eps, QM); %generate a 0 vec with random noise
                tic
                decoded_word = Iter_Method(H, vec, QM);
                dbstop if error
                toc;
                itr_e_rate = mean(abs(decoded_word));
                H_e_rate = H_e_rate + itr_e_rate;
            end
            
        eps_e_rate = eps_e_rate + H_e_rate;
        end
        
        total_e_rate(i) = eps_e_rate;

     end

    figure(1)
    plot(eps_vec,total_e_rate); hold on
    plot(eps_vec,eps_vec);
    title('ratio of erasures after decoding with random noise VS erasure probablity, dc=6,dv=3');
    legend('Erasure','y=x')
    xlabel('Probablity Of Erasure [{\epsilon}]');
    ylabel('Erasure Rate');
    
    
    
    
    
    %% check
    
    H = rand(1000,1000);
    vec = rand(1000,1);
    tic
    k = H*vec;
    toc;
    tic
    for i = 1:10
        x=6;
    end
    toc
    