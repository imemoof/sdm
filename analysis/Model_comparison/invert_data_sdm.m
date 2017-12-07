% function param = invert_simulations(model_n, dispo, 2)
model_n = 2; 
sub = 2;
%% Specify how to load informations needed
[~, hostname] = system('hostname'); % try to identify which computer am I using
if strcmp(hostname(1:5),'MBB31')
    root = 'C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\';
else
    load(['/Users/chen/Dropbox/PHD/SDM_behavior/simulation/data/beta',num2str(beta*100),'_simudata.mat']);
end

%% Load input data
INDX_category = 2;
INDX_repeat = 3;
INDX_itemnumber = 6;
% INDX_values = 15:20;
INDX_itemid = 21:26;
INDX_choice = 39;
N_sub = length(sub);
N_items_percate = 86;
N_categories = 5;
N_items = N_items_percate * N_categories;


for s = 1:N_sub
    subj = sub(s);
    mydatafile = load([root,'sub',num2str(subj),filesep,'choice_subject_',num2str(subj),'cate_15.mat']);
    myratingfile = load([root,'sub',num2str(subj),filesep,'pleasantRating_subject_',num2str(subj),'_cate_15.mat']);
    Ntrials = length(mydatafile.choice_data);
    [choice_position, itemnum,repeat, which_category] = deal(NaN(Ntrials,1));
    [values,itemid,choice] = deal(NaN(Ntrials,6));
    
    for i = 1: Ntrials
        which_category(i) =  mydatafile.choice_data(i,INDX_category);
        repeat(i) = mydatafile.choice_data(i,INDX_repeat);
        itemnum(i) = mydatafile.choice_data(i,INDX_itemnumber);
        itemid(i, :)=  mydatafile.choice_data(i,INDX_itemid)* which_category(i);
        
        %       values(i, :)= mydatafile.choice_data(i,INDX_values);  % 6 values, sometimes le last fews can be empty
        choice_position(i) = mydatafile.choice_data(i,INDX_choice);
        temp = zeros(1, itemnum(i));
        if choice_position(i) < 7
            temp(choice_position(i)) = 1;
        end
            choice(i, 1:itemnum(i)) = temp;
    end
    
    y = choice';
    u_r = [which_category, itemnum, itemid]';  % 360* 8, 3- 8, itemid
    
    
    
    %% Modeles ? tester :
    models_set = {'m_hzero','m_hone'};
    model_name = models_set{model_n};
    
    switch model_name
        case 'm_hzero'   % linear model- one parameter, which is the beta
            model_obs = @sm_000;
            model_evo = [];
            prior = [0.046]; %#ok<NBRAK>
        case 'm_hone'
            model_obs = @sm_000;
            model_evo = @sm_010;
            prior = [0.046];
    end
    
    param = length(prior);
    
        %% Definition of model options        
        g_name = model_obs;
        f_name = model_evo;
        
        dim = struct('n',N_items,...  % number of hidden states
            'n_theta',1,... % number of evolution parameters
            'n_phi', param(mod),... % number of observation parameters
            'n_t',Ntrials); % number of trials
     %        'p',1,... % total output dimension
       
        options.DisplayWin = 1; % Display setting
        options.GnFigs = 0; % Plotting option
        options.verbose= 0;

        options.isYout = zeros(size(choice)); % vector of the size of y, 1 if trial out
        options.multinomial = 1; 
%         options.binomial = 1; % 1 if binary data, 0 if continuous data
        
        %% Definition of priors
        % Observation parameters :
        priors.muPhi = prior;
        priors.SigmaPhi = 1e1*eye(dim.n_phi);
        
        % Evolution parameters
        priors.muTheta = zeros(dim.n_theta,1);
        priors.SigmaTheta = 1e1*eye(dim.n_theta);
        
        % X0 related settings
        priors.muX0 = myratingfile.rating_all';
        priors.SigmaX0 = 1e1*eye(dim.n);
        priors.a_alpha = Inf;
        priors.b_alpha = 0;
        options.skipf(1) = 1 ;
        
        options.priors = priors;
        
        %% Performing the inversion
        options.figName='choice_simudata';
        size_y = size(y);
        inclusion = zeros(size_y);
        for h = 1:size_y(1)
            for q = 1:size_y(2)
                if isnan(y(h,q))
                    y(h,q) = 100;
                    inclusion(h,q) = 1;
                end
            end
        end
        options.isYout = inclusion';
            
        [posteriorr,outr] = VBA_NLStateSpaceModel(y,u_r,f_name,g_name,dim,options);
        %         displayResults(posterior,out,y,x,x0,theta,phi,Inf,Inf);

        model_evidence_r(N_sub,1)= outr.F;
        param_all_r(N_sub,:)= posteriorr.muPhi(1:end)';
        posterior_all{subj} = posteriorr;
        out_all{subj} = outr;
            
end

param = struct('Name',[func2str(modeles{1}),'_VBA'],'Val_param',param_all_r,'Priors',prior,'Var_priors',var_prior,'Rating_model_evidence',model_evidence_r,...
    'posterior',posterior_all,'out',out_all);

