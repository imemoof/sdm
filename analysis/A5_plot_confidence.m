clear all
subid = [1:18,20:24];
% trial_number = 72;
plotwidth = 2;
 [~, hostname] = system('hostname')
    if strcmp(hostname(1:5),'MBB31')
        resultsdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\'];    
        plotsdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_plot\'];        
%     elseif strcmp(hostname(1:6),'PRISME')
%         resultdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\'];        
    end
    cd(resultsdir)

    
  
itemnumber_index = 6;
highpos_index = 7;
highpos2_index = 8;
confidence_index = 41;

cate_total = [5];
for cate_number = cate_total;

    bin_simu = {};
    for subj = subid;
        subdir = strcat('sub',num2str(subj));
        load([resultsdir subdir filesep strcat('choice_subject_',num2str(subj),'cate_',num2str(cate_number),'.mat')]);  
        
        itnum =  choice_data(:,itemnumber_index);
        bpos =  choice_data(:,highpos_index);
        bpos2 =  choice_data(:,highpos2_index);    
        confidence_order  = choice_data(:,confidence_index); 
    
        % get 3 items trials
        for i   = 1:3
            items3 = find(itnum == 3);
            pos = bpos(items3);
            pos_bin = (find(pos ==i));
            bin_simu(subj). items3_1{i} = items3(pos_bin);
            bin_simu(subj). H0_confidence_3{i} = confidence_order(bin_simu(subj). items3_1{i});  
            m_h0_3_1(subj,i) = nanmean(bin_simu(subj). H0_confidence_3{i});
        end     
    
    
    % get 4 items trials
        for i   = 1:4
            items4 = find(itnum == 4);
            pos = bpos(items4);
            pos_bin = (find(pos ==i));
            bin_simu(subj). items4_1{i} = items4(pos_bin);
            bin_simu(subj). H0_confidence_4{i} = confidence_order(bin_simu(subj). items4_1{i});   
            m_h0_4_1(subj,i) = nanmean(bin_simu(subj). H0_confidence_4{i});
        end     
     
        % get 5 items trials
        for i   = 1:5
            items5 = find(itnum == 5);
            pos = bpos(items5);
            pos_bin = (find(pos ==i));
            bin_simu(subj). items5_1{i} = items5(pos_bin);
            bin_simu(subj). H0_confidence_5{i} = confidence_order(bin_simu(subj). items5_1{i});   
            m_h0_5_1(subj,i) = nanmean(bin_simu(subj). H0_confidence_5{i});
        end     
    
     
    % get 6 items trials
         for i   = 1:6
            items6 = find(itnum == 6);
            pos = bpos(items6);
            pos_bin = (find(pos ==i));
            bin_simu(subj). items6_1{i} = items6(pos_bin);
            bin_simu(subj). H0_confidence_6{i} = confidence_order(bin_simu(subj). items6_1{i});   
            m_h0_6_1(subj,i) = nanmean(bin_simu(subj). H0_confidence_6{i});
         end     
    end

% plot the probability of chosing the best option
    figure
    % subplot(1,2,1), 
    hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
    errorbar(nanmean(m_h0_3_1(subid,:)),nanstd(m_h0_3_1(subid,:))/sqrt(length(subid)),'Color','b', 'LineWidth',plotwidth)
    errorbar(nanmean(m_h0_4_1(subid,:)),nanstd(m_h0_4_1(subid,:))/sqrt(length(subid)),'Color','m', 'LineWidth',plotwidth)
    errorbar(nanmean(m_h0_5_1(subid,:)),nanstd(m_h0_5_1(subid,:))/sqrt(length(subid)),'Color','g', 'LineWidth',plotwidth)
    errorbar(nanmean(m_h0_6_1(subid,:)),nanstd(m_h0_6_1(subid,:))/sqrt(length(subid)),'Color','r', 'LineWidth',plotwidth)
    legend('3 items','4 items','5 items', '6 items');
    ylabel ('responset time')
    xlabel('position/order of the best option')
    if cate_number == 1
        title (['confidence veggie & fruits'])
    elseif cate_number == 2
        title (['confidence snacks'])
    elseif cate_number == 3
        title (['confidence music'])
    elseif cate_number == 4
        title (['confidence magazine'])
    elseif cate_number == 5
        title (['confidence film'])
    elseif cate_number == 15
        title (['confidence all Category'])
    end

    cd(plotsdir);saveas(gcf,['confidence_cate_',num2str(cate_number),'.tif']);
end

