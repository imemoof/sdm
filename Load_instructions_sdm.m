% Instructions Loading

task_instruction_duration = 5;

% Instruction_specification
streching_coeff = 1;
cd(instruction_dir)

    % Attention to read instructions clearly and slowly
    Bien_Lire = Screen('MakeTexture',window,imread('bien_lire.png'));
    Bien_Lire_rect =  CenterRectOnPoint(Screen('Rect',Bien_Lire)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);

    % On touch Screen training
    TouchScreen_Training = Screen('MakeTexture',window,imread('touchscreen_training.png'));
    TouchScreen_Training_rect =  CenterRectOnPoint(Screen('Rect',TouchScreen_Training)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);

    TouchScreen_Fail = Screen('MakeTexture',window,imread('touchscreen_fail.png'));
    TouchScreen_Fail_rect =  CenterRectOnPoint(Screen('Rect',TouchScreen_Fail)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);

    TouchScreen_Success = Screen('MakeTexture',window,imread('touchscreen_success.png'));
    TouchScreen_Success_rect =  CenterRectOnPoint(Screen('Rect',TouchScreen_Success)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);


    % Training Session
    Training_SessionStructure = Screen('MakeTexture',window,imread('training_sessionstructure.png'));
    Training_SessionStructure_rect =  CenterRectOnPoint(Screen('Rect',Training_SessionStructure)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);
    
    Training_Rating1 = Screen('MakeTexture',window,imread('training_rating1.png'));
    Training_Rating1_rect =  CenterRectOnPoint(Screen('Rect',Training_Rating1)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
    Training_Rating2 = Screen('MakeTexture',window,imread('training_rating2.png'));
    Training_Rating2_rect =  CenterRectOnPoint(Screen('Rect',Training_Rating2)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
    
    Training_Choice1 = Screen('MakeTexture',window,imread('training_choice1.png'));
    Training_Choice1_rect =  CenterRectOnPoint(Screen('Rect',Training_Choice1)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
    Training_Choice2 = Screen('MakeTexture',window,imread('training_choice2.png'));
    Training_Choice2_rect =  CenterRectOnPoint(Screen('Rect',Training_Choice2)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
    Training_Choice2_Mask = Screen('MakeTexture',window,imread('training_choice2_mask.png'));
    Training_Choice2_Mask_rect =  CenterRectOnPoint(Screen('Rect',Training_Choice2_Mask)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
    
%     Training_Consequence1 = Screen('MakeTexture',window,imread('training_consequence1.png'));
%     Training_Consequence1_rect =  CenterRectOnPoint(Screen('Rect',Training_Consequence1)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
%     Training_Consequence2 = Screen('MakeTexture',window,imread('training_consequence2.png'));
%     Training_Consequence2_rect =  CenterRectOnPoint(Screen('Rect',Training_Consequence2)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
    Training_Consequence = Screen('MakeTexture',window,imread('training_consequence.png'));
    Training_Consequence_rect =  CenterRectOnPoint(Screen('Rect',Training_Consequence)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);      
    
    % Main task
    Main_Rating = Screen('MakeTexture',window,imread('main_rating.png'));
    Main_Rating_rect =  CenterRectOnPoint(Screen('Rect',Main_Rating)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
    Main_Choice = Screen('MakeTexture',window,imread('main_choice.png'));
    Main_Choice_rect =  CenterRectOnPoint(Screen('Rect',Main_Choice)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
    Main_Choice_Mask = Screen('MakeTexture',window,imread('main_choice_mask.png'));
    Main_Choice_Mask_rect =  CenterRectOnPoint(Screen('Rect',Main_Choice_Mask)* streching_coeff , displayConfig.xCenter, displayConfig.yCenter);    
    
    cd(root)
