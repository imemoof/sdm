% Rating task for different items
clear all;       
    number_subjects = input('subject identification number?');
    do_rating_task = input('will there be a rating session?');
    if do_rating_task == 1
       rating_rec = input ('will you use keyboard to place a rating?');       % 1 = use keyboard, 0 = use mouse or touch screen
    end
    do_choice_task = input('will there be a choice session?');
    if do_choice_task == 1
        response_rec = input('Will you use number key pad to make a choice?'); % 1 = use number key pad, 0 = use mouse or touch screen
        mask_options = input('Do you want to mask choice options?')   % decide whether or not choice options are going to ba masked
    end
    
    % to judge which computer are we using
    [~, hostname] = system('hostname')
    if strcmp(hostname(1:5),'MBB31')
        addpath('C:\Users\chen.hu\Dropbox\PHD\SDM_behavior')
        cd 'C:\Users\chen.hu\Dropbox\PHD\SDM_behavior'
        displayConfig.imageLocation = ['C:\Users\chen.hu\Dropbox\PHD\SDM_behavior\'];
    elseif strcmp(hostname(1:6),'PRISME')
        addpath('C:\Users\chen.hu\Documents\MATLAB\experiment\SDM_behavior')
        cd 'C:\Users\chen.hu\Documents\MATLAB\experiment\SDM_behavior'
        displayConfig.imageLocation = ['C:\Users\chen.hu\Documents\MATLAB\experiment\SDM_behavior\'];        
    end


%% screen configuration
    screens = Screen('Screens');
    HideCursor()
    whichScreen =  max(screens);

    Screen('Preference', 'SkipSyncTests', 0);
    window = Screen('OpenWindow',whichScreen,[0 0 0]);
    Screen('Preference','VisualDebugLevel', 2);    
    backgroud = BlackIndex(whichScreen);
    surface = WhiteIndex(whichScreen);
    
    displayConfig.text.smallfont = 18;
    displayConfig.text.mediumfont = 20;  
    Screen('TextSize', window, displayConfig.text.mediumfont);
%    Font_Type = 'garamond';
%    Screen('TextFont', window, Font_Type);

    [L, H] = Screen('WindowSize',whichScreen);
    displayConfig.xCenter = L/2; 
    displayConfig.yCenter = H/2;

%%  Global variables
    scale.half_x = 400;
    scale.position_y = 200;
    scale.line_width = 3;
    scale.line_width_horizental = 4;
    scale.line_width_thin = 1;
    scale.word_gap = 50;
    scale.word_width = 180;

    scale.gap = 10;
    scale.stepsize = 2 * scale.half_x * 0.01;  % 100 steps in total
    scale.totalprice = 100;
    scale.step_price = scale.totalprice/100;  
    
    % fixationcross
    pic_cross = Screen('MakeTexture',window,imread('cross.bmp'));
    rect_cross = CenterRectOnPoint(Screen('Rect',pic_cross),displayConfig.xCenter,displayConfig.yCenter); 
    
    %------- response related --------------
    KbName('UnifyKeyNames')
    key.space = KbName('space');
    key.left = KbName('LeftArrow');
    key.right = KbName('RightArrow');
    key.escape = KbName('escape');
   
    % reset random generator
    rand('state',sum(100*clock));
    
    %------- trial configuaration
    item_perCate = 86;
    total_cate = 10;
    FoodorConf = 1;  % 0 = confidence rating, 1= food rating.
    items_y_up = 150 % move the food item up from the center to place scales underneath
    trials_perCate = 3;
    
    rect_linewidth = 3;
    rect_linegap = 3;
    color.frame = [255, 245, 157];
    color.ready = [121, 134, 203];
    color.chosen = [255, 160, 0];
    
    % intervals
    interval.minimum_itemdisp = 0.5;
    interval.time_out = 3;
    inverval.feedback = 1;
%     % Load  and display instructions
%     Load_instructions;    
%     DisplayInstru3(displayConfig, instru, 1)  




% which tasks to do
    if do_rating_task == 1
        task_rating
    end
    if do_choice_task == 1
        load(['pleasantRating_subject_',num2str(number_subjects),'.mat']);
        if response_rec == 1
            task_choice_keyboard 
        elseif response_rec == 0
            task_choice_mouse
        end
    end
    
    sca