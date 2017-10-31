function [ out_map] = generateMap( input)
    
    keySet = input.data{1};
    
    valueSet = {};
    
    [~,len] = size(input.data{2});
    
    for i = 1: len
        eye = {};
        tmp_left = {};
        msk_left = {};
        tmp_right = {};
        msk_right = {};
        not_fill = false;
        
        if(~isempty(input.data{2}{i}{1}))
            for j=1:size(input.data{2}{i}{1},2)
                tmp_left=[tmp_left, input.data{2}{i}{1}{j}];
            end
        else
            not_fill = true;
        end
        if(~isempty(input.data{2}{i}{2}))
            for j=1:size(input.data{2}{i}{2},2)
                msk_left = [msk_left, input.data{2}{i}{2}{j}];
            end
        else
            not_fill = true;
        end
        if(~isempty(input.data{2}{i}{3}))
            for j=1:size(input.data{2}{i}{3},2)
                tmp_right = [tmp_right, input.data{2}{i}{3}{j}];
            end
        else
            not_fill = true;
        end
        if(~isempty(input.data{2}{i}{4}))
            for j=1:size(input.data{2}{i}{4},2)
                msk_right = [msk_right, input.data{2}{i}{4}{j}];
            end
        else
            not_fill = true;
        end
        
        eye.left = {tmp_left,msk_left};
        eye.right ={tmp_right, msk_right};
        
        if(not_fill)
            keySet{i} = '*';
        end
        valueSet = [valueSet, eye];
    end;
    
    out_map = containers.Map(keySet, valueSet);

end

