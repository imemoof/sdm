% Use the mouse to make a click response

k = 1;
stoptask = 0;
[per_trial, trials] = group_items(ratingItem)
while k <= trials_perCate;
      if stoptask; break; end    
      
  
    HideCursor()
      % fixation
    Screen('DrawTexture',window,pic_cross,[],rect_cross);
    Screen('Flip', window);
    jitter_cross = 1 + 3*rand(1);
    WaitSecs(jitter_cross);
   
% 6 position on the screen
    horizental_gap = (L - 300*3)/4;
    vertical_gap = (H - 225*2)/3;
    rect_pos(:,1) = [horizental_gap ;vertical_gap; horizental_gap + 300; vertical_gap + 225];
    rect_pos(:,2) = [2*horizental_gap + 300; vertical_gap; 2*horizental_gap + 600; vertical_gap + 225];
    rect_pos(:,3) = [3*horizental_gap + 600; vertical_gap ;3*horizental_gap + 900; vertical_gap + 225];
    rect_pos(:,4) = [horizental_gap ; 2*vertical_gap + 225 ; horizental_gap + 300; 2*vertical_gap + 450];
    rect_pos(:,5) = [2*horizental_gap + 300; 2*vertical_gap + 225; 2*horizental_gap + 600; 2*vertical_gap + 450];
    rect_pos(:,6) = [3*horizental_gap + 600;2*vertical_gap + 225; 3*horizental_gap + 900; 2*vertical_gap + 450];
    
    rect_line = ones(4,6)*rect_linegap.*[-1;-1;1;1];  % leave a 5 pixel border
    % first item appear, random location of the 6, click space to
    % proceed
    pos_perm = randperm(6);
    positions_item = rect_pos(:,pos_perm(1:trials.itemNumber{k}));
    items_whichones = trials.itemsordered{k};
    ItemImage = {};

    for n = 1: trials.itemNumber{k}
        if n == 1
            % rectangles
            Screen('FrameRect',window, color.frame,[rect_pos + rect_line],rect_linewidth) %light purple
            % photo
            ItemImage{n} = imread([displayConfig.imageLocation, 'cate1\cate1', '_', num2str(items_whichones(n)),'.jpeg']);
            [s1, s2, s3] = size(ItemImage{n});    
            ItemTexture = Screen('MakeTexture', window, ItemImage{n});
            positionItem = positions_item(:,n)';        
            Screen('DrawTexture', window, ItemTexture, [], positionItem, 0);
            Screen('Flip', window);

        elseif n >1
            % rectangles
            Screen('FrameRect',window, color.frame,[rect_pos + rect_line],rect_linewidth) %light purple
            % photo
            ItemImage{n} = imread([displayConfig.imageLocation, 'cate1\cate1', '_', num2str(items_whichones(n)),'.jpeg']);
            [s1, s2, s3] = size(ItemImage{n});    
            ItemTexture = Screen('MakeTexture', window, ItemImage{n});
            positionItem = positions_item(:,n)';        
            Screen('DrawTexture', window, ItemTexture, [], positionItem, 0);           
            
            % filled rectange of the previous locations
            Screen('FillRect',window, color.frame,[positions_item(:,1:(n-1))])
            Screen('Flip', window);
        end
        
        % press the key to proceed to the next pic
            WaitSecs(interval.minimum_itemdisp) 
            keyIsDown = 0;
            while true
                [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
                if keyIsDown == 1
                        if response_rec == 1 % use keyboard to make a response 
                            if find(keyCode == 1) == 101; break;  end; % if key is pressed and the pressed key is 5 on the numeric keyboard
                        elseif response_rec == 0  % use mouse to make a response, press space key to continue
                            if find(keyCode == 1) == key.space; break; end;
                        end      
                end                
            end
            
            if keyCode(key.escape) == 1
                stoptask = 1;
            end

            
   % after the last item has appeard, turn the color of the previous
   % locations,click the mouse to choose from.
            if mask_options == 0
                if  n == trials.itemNumber{k}
                    Screen('FrameRect',window, color.ready,[rect_pos + rect_line],rect_linewidth)             
                    ItemTexture1 = Screen('MakeTexture', window, ItemImage{1});
                    Screen('DrawTexture', window, ItemTexture1, [], positions_item(:,1), 0);
                    ItemTexture2 = Screen('MakeTexture', window, ItemImage{2});
                    Screen('DrawTexture', window, ItemTexture2, [], positions_item(:,2), 0);
                    ItemTexture3 = Screen('MakeTexture', window, ItemImage{3});
                    Screen('DrawTexture', window, ItemTexture3, [], positions_item(:,3), 0);
                    if n >= 4
                        ItemTexture4 = Screen('MakeTexture', window, ItemImage{4});
                        Screen('DrawTexture', window, ItemTexture4, [], positions_item(:,4), 0); 
                    end
                    if n >= 5
                        ItemTexture5 = Screen('MakeTexture', window, ItemImage{5});
                        Screen('DrawTexture', window, ItemTexture5, [], positions_item(:,5), 0); 
                    end      
                    if n == 6
                        ItemTexture6 = Screen('MakeTexture', window, ItemImage{6});
                        Screen('DrawTexture', window, ItemTexture6, [], positions_item(:,6), 0); 
                    end
                    Screen('Flip', window);
                end
            
            elseif mask_options == 1            
               if n == trials.itemNumber{k}
                        % filled rectange of the previous locations
                        Screen('FrameRect',window, color.ready,[rect_pos + rect_line],rect_linewidth)
                        Screen('FillRect',window, color.ready,[positions_item(:,1:n)])
                        Screen('Flip', window);
               end
            end
            
           WaitSecs(interval.minimum_itemdisp)  
    end
    
    % detect the mouse response
    ShowCursor('Hand')
    SetMouse(displayConfig.xCenter, displayConfig.yCenter, window)

    start_timer = GetSecs;
    too_slow = 0;
    
%     nbClick = 0;    
%     while nbClick == 0
%         Click_time = GetSecs;
%         [nbClick,choice_x,choice_y,buttonClick] = GetClicks(window, 0); 
%         if (Click_time - start_timer) > interval.time_out
%             nbClick = 1;
%             too_slow = 1;
%             findposition = 100;
%         end  
%     end
    
    MousePress=0; %initializes flag to indicate no response
    while MousePress == 0 %checks for completion
        [choice_x,choice_y,buttons] = GetMouse();  %waits for a key-press
        MousePress = any(buttons); %sets to 1 if a button was pressed
%        WaitSecs(.01); % put in small interval to allow other system events
        Click_time = GetSecs;
        if (Click_time - start_timer) > interval.time_out
            MousePress = 1;
            too_slow = 1;
            findposition = 100;
        end        
    end

    if strcmp(hostname(1:5),'MBB31')
        choice_x = choice_x - 1920;  % a weird screen coordination system
    end

%    Then feed back phase, the chosen item appear in the red square
    findposition = 1000;
    for x = 1: trials.itemNumber{k}
        option_position = positions_item(:,x);
        if choice_x >= option_position(1) && choice_x <= option_position(3) && choice_y >= option_position(2) && choice_y <= option_position(4)
            findposition = x;
        end
    end
    
        % photo
        if too_slow == 1
            DrawFormattedText(window, 'Too slow!', 'center', 'center', surface, 60, 0, 0, 1.5, 0, [])
        else
            if findposition <7
                ItemImage = imread([displayConfig.imageLocation, 'cate1\cate1', '_', num2str(items_whichones(findposition)),'.jpeg']);
                ItemTexture = Screen('MakeTexture', window, ItemImage);
                positionItem = positions_item(:,findposition)'; 
                Screen('FrameRect',window, color.chosen,[positionItem + [-rect_linewidth, -rect_linewidth, rect_linewidth, rect_linewidth]], rect_linewidth) %light purple
                Screen('DrawTexture', window, ItemTexture, [], positionItem, 0);      
            elseif findposition == 1000
                DrawFormattedText(window, 'Wrong click!', 'center', 'center', surface, 60, 0, 0, 1.5, 0, [])
            end
        end
        
  

        % filled rectange of the previous locations
        Screen('Flip', window); 
        WaitSecs(inverval.feedback)

    % confidence rating
    if findposition <7
        FoodorConf = 0;
        xCursor = displayConfig.xCenter + randi([-25,25])*scale.stepsize;
        Scale_rating
        % onsetE.response(i) = GetSecs - 0.5;    % after press space, waited 0.5 seconds
        cursorFinal(k) = ((ansRating - displayConfig.xCenter + scale.half_x)/scale.stepsize)* scale.step_price;     
    else
        cursorFinal(k) = -100;
    end
    
    k = k+1;
end
sca
% proceed to the next trial