function  [fx] = rt_evo_010(x,P,u,in)

    alpha = P(1);
    ID_items = u(3:8);
    ID_items =(ID_items(~isnan(ID_items)));
    v_zero = x(ID_items);
    
    winning_index = 1;
    k = 1;

  while k <= length(v_zero) -1
        if v_zero(winning_index) >= v_zero(k+1)                                                                % the previous winning option is the better of the two
            defeat_index = k+ 1; % winning_index stay unchanged;
            v_zero(defeat_index) = v_zero(defeat_index) - alpha;
            v_zero(winning_index) = v_zero(winning_index) + alpha;

        elseif v_zero(winning_index) < v_zero(k+1)  % if the new option is winning
            defeat_index = winning_index;
            winning_index = k + 1;
            v_zero(defeat_index ) = v_zero(defeat_index ) - alpha;
            v_zero(winning_index) = v_zero(winning_index) + alpha;

        elseif v_zero(winning_index) == v_zero(k+1)  % if the two options have the same value, flip a coin to decide which wins
            coin = rand(1);
            if coin >= 0.5
                defeat_index = k+1; % winning_index stay unchanged;
            elseif coin <0.5
                defeat_index = winning_index; 
                winning_index = k+1; 
            end
            v_zero(defeat_index ) = v_zero(defeat_index ) - alpha;
            v_zero(winning_index) = v_zero(winning_index) + alpha;
        end
        k = k + 1;
  end
   x(ID_items) = v_zero;
   fx = x;
   
end
