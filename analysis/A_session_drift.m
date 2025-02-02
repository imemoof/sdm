clear
subid = [2:4,6,8,9,11];
plotwidth = 2;
[~, hostname] = system('hostname');
if strcmp(hostname(1:5),'MBB31')
    resultsdir = 'C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\';
    plotsdir = 'C:\Users\chen.hu\Documents\GitHub\sdm\results_plot\';
else
    resultsdir = '/Users/chen/Documents/GitHub/sdm/results_sdm/';
    plotsdir = '/Users/chen/Documents/GitHub/sdm/results_plot/';
end
cd(resultsdir)

session_order_index = 4;
itemnumber_index = 6; % how many items in this trial
highpos_index = 7;      % the position of the higest valued item
choice_index = 39;
rt_index = 40;          % response time index
confidence_index = 41;


cate_total = [15]; %#ok<NBRAK>
N_session = 5;
n_sub = length(subid);

for cate_number = cate_total
    bin_simu = {};
    [mean_rt_3, mean_rt_4,mean_rt_5 ,mean_rt_6,mean_confidence_3,mean_confidence_4,...
        mean_confidence_5,mean_confidence_6 ,mean_choicematch_3 , mean_choicematch_4,...
        mean_choicematch_5 , mean_choicematch_6, mean_match_3, mean_match_4, mean_match_5, mean_match_6]=  deal(NaN(n_sub, N_session));
    
    for i = 1:n_sub
        subj = subid(i);
        subdir = strcat('sub',num2str(subj));
        load([resultsdir subdir filesep strcat('choice_subject_',num2str(subj),'cate_',num2str(cate_number),'.mat')]);
        for g = 1:N_session
            tmp = arrayfun(@(ii) {megafind(choice_data,[session_order_index, itemnumber_index],{g,ii},rt_index)},3:6);
            [rt_3items, rt_4items, rt_5items, rt_6items] = deal(tmp{:});
            [mean_rt_3(i,g),mean_rt_4(i,g),mean_rt_5(i,g), mean_rt_6(i,g)] = deal(nanmean(rt_3items),...
                nanmean(rt_4items),nanmean(rt_5items),nanmean(rt_6items));
        end
        
        for g = 1:N_session
            tmp = arrayfun(@(ii) {megafind(choice_data,[session_order_index, itemnumber_index],{g,ii},confidence_index)},3:6);
            [confidence_3items, confidence_4items, confidence_5items, confidence_6items] = deal(tmp{:});
            [mean_confidence_3(i,g),mean_confidence_4(i,g),mean_confidence_5(i,g), mean_confidence_6(i,g)] = deal(nanmean(confidence_3items),...
                nanmean(confidence_4items),nanmean(confidence_5items),nanmean(confidence_6items));
        end
        
        for g = 1:N_session
            tmp = arrayfun(@(ii) {megafind(choice_data,[session_order_index, itemnumber_index],{g,ii},highpos_index)},3:6);
            [bestloc_3items, bestloc_4items, bestloc_5items, bestloc_6items] = deal(tmp{:});
            tmp = arrayfun(@(ii) {megafind(choice_data,[session_order_index, itemnumber_index],{g,ii},choice_index)},3:6);
            [choice_3items, choice_4items, choice_5items, choice_6items] = deal(tmp{:});
            [mean_match_3(i,g),mean_match_4(i,g),mean_match_5(i,g), mean_match_6(i,g)] = deal(nanmean(choice_3items == bestloc_3items),...
                nanmean(choice_4items == bestloc_4items),nanmean(choice_5items == bestloc_5items),nanmean(choice_6items == bestloc_6items));                      
        end
    end
    
    % plot the probability of chosing the best option
    figure
    hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
    errorbar(nanmean(mean_rt_3), nanstd(mean_rt_3)/sqrt(n_sub),'Color','b', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_rt_4), nanstd(mean_rt_4)/sqrt(n_sub),'Color','m', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_rt_5), nanstd(mean_rt_5)/sqrt(n_sub),'Color','g', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_rt_6), nanstd(mean_rt_6)/sqrt(n_sub),'Color','r', 'LineWidth',plotwidth)
    legend('3 items','4 items','5 items', '6 items');
    ylabel ('mean responset time')
    xlabel('session order')
    cd(plotsdir);saveas(gcf,'RT_session_order.tif');
    
    figure
    hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
    errorbar(nanmean(mean_confidence_3),nanstd(mean_confidence_3)/sqrt(n_sub),'Color','b', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_confidence_4),nanstd(mean_confidence_4)/sqrt(n_sub),'Color','m', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_confidence_5),nanstd(mean_confidence_5)/sqrt(n_sub),'Color','g', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_confidence_6),nanstd(mean_confidence_6)/sqrt(n_sub),'Color','r', 'LineWidth',plotwidth)
    legend('3 items','4 items','5 items', '6 items');
    ylabel ('mean confidence level')
    xlabel('session order')
    cd(plotsdir);saveas(gcf,'conf_session_order.tif');
    
    figure
    hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
    errorbar(nanmean(mean_match_3),nanstd(mean_match_3)/sqrt(n_sub),'Color','b', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_match_4),nanstd(mean_match_4)/sqrt(n_sub),'Color','m', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_match_5),nanstd(mean_match_5)/sqrt(n_sub),'Color','g', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_match_6),nanstd(mean_match_6)/sqrt(n_sub),'Color','r', 'LineWidth',plotwidth)
    legend('3 items','4 items','5 items', '6 items');
    ylabel ('P choose best rated option')
    xlabel('session order')
    cd(plotsdir);saveas(gcf,'P1_session.tif');    
end


    figure
    hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
    bar(nanmean(m2_evo_posterior));
    errorbar(nanmean(m2_evo_posterior),nanstd(m2_evo_posterior)/sqrt(11),'Color','r', 'LineWidth',2)
    ylabel ('posterior of default bonus')
    cd(plotsdir);saveas(gcf,'m2_evo_posterior.tif');    
