function [rate] = generateCMC( gallary, probe )
%GENERATECMC Summary of this function goes here
%   Detailed explanation goes here

        gallary_map = generateMap(gallary);
        probe_map = generateMap(probe);
        
        pro_key = keys(probe_map);
        gal_key = keys(gallary_map);
        intersection = gal_key(ismember(gal_key,pro_key));
        store = {};
        for i = 1 : length(intersection)
            index_record = {};
            key = char(intersection(i));
            for m = 1:size(probe_map(key).left{1},2)
                    leftPTemp = probe_map(key).left{1}{m};
                    leftPMask = probe_map(key).left{2}{m};
                    record = [];
                    for j = 1 : length(intersection)
                        key2 = char(intersection(j));
                        temp = [];
                        for k = 1 : size(gallary_map(key2).left{1},2) 
                                leftTempGal = gallary_map(key2).left{1}{k};
                                leftMaskGal = gallary_map(key2).left{2}{k};
                                tempLeftDiff = gethammingdistance(leftPTemp, leftPMask, leftTempGal, leftMaskGal,1);
                                temp = [temp,tempLeftDiff];
                        end
                        record = [record, median(temp)];
                    end
                index_record{end + 1} = record(:);        
            end
            store{end + 1} = index_record;
        end
        rate = zeros(1, length(intersection));
        for i = 1 : length(store)
            index = i;
            temp_index_record = store{i};
            for j = 1 : length(temp_index_record)
                sorted = sort(temp_index_record{j})';
                value = temp_index_record{j}(index);
                if isnan(value)
                    value = inf;
                end
                for k = 1 : length(sorted)
                    if isnan(sorted(k))
                        sorted(k) = inf;
                    end
                    if sorted(k) >= value
                        rate(k:length(rate)) = rate(k :length(rate))+1;
                        break;
                    end
                end
            end
        end
        rate1 = rate(:);
        %%   
        
        store = {};
        for i = 1 : length(intersection)
            index_record = {};
            key = char(intersection(i));
            for m = 1:size(probe_map(key).right{1},2)
                    rightPTemp = probe_map(key).right{1}{m};
                    rightPMask = probe_map(key).right{2}{m};
                    record = [];
                    for j = 1 : length(intersection)
                        key2 = char(intersection(j));
                        temp = [];
                        for k = 1 : size(gallary_map(key2).right{1},2) 
                                rightTempGal = gallary_map(key2).right{1}{k};
                                rightMaskGal = gallary_map(key2).right{2}{k};
                                tempLeftDiff = gethammingdistance(rightPTemp, rightPMask, rightTempGal, rightMaskGal,1);
                                temp = [temp,tempLeftDiff];
                        end
                        record = [record, median(temp)];
                    end
                index_record{end + 1} = record(:);        
            end
            store{end + 1} = index_record;
        end
        rate = zeros(1, length(intersection));
        for i = 1 : length(store)
            index = i;
            temp_index_record = store{i};
            for j = 1 : length(temp_index_record)
                sorted = sort(temp_index_record{j})';
                value = temp_index_record{j}(index);
                if isnan(value)
                    value = inf;
                end
                for k = 1 : length(sorted)
                    if isnan(sorted(k))
                        sorted(k) = inf;
                    end
                    if sorted(k) >= value
                        rate(k:length(rate)) = rate(k :length(rate))+1;
                        break;
                    end
                end
            end
        end
        %%
        for i = 1 : length(rate) 
            rate(i) = (rate(i) + rate1(i)) / (2*length(store{i}) * length(intersection));
        end
        x = 1 : length(rate);
        plot(x, rate);
end

