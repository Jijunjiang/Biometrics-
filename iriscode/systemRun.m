function [ TP,FP,TN,FN ] = systemRun(gallary, probe)
    
 
        gallary_map = generateMap(gallary);
        probe_map = generateMap(probe);
        TP = 0;
        FP = 0;
        TN = 0;
        FN = 0;
        threshold = 0.1;
        
        
        [gal_size,~] = size(gallary_map);
        [pro_size,~] = size(probe_map);
        
        pro_key = keys(probe_gallary);
        for i=1:pro_size
            inGallary = false;
            alarm = false;
            id = pro_key(i);
            id = id{1,1};
            if(gallary_map.isKey(id))
                inGallary = true;
            end
            
            
            leftHD = Inf;
            rightHD = Inf;
            
            
            for j = 1:size(probe_map(id).left{1},2)
                leftTemp = probe_map(id).left{1}{j};
                leftMask = probe_map(id).left{2}{j};
                
                
                gal_key = keys(gallary_map);
                for p=1:gal_key
                    gal_id = gal_key(p);
                    for k=1:size(gallary_map(gal_id).left{1},2)
                        leftTempGal = gallary_map(id).left{1}{k};
                        leftMaskGal = gallary_map(id).left{2}{k};

                        tempLeftDiff = gethammingdistance(leftTemp, leftMask, leftTempGal, leftMaskGal,1);
                        if(tempLeftDiff<leftHD)
                            leftHD = tempLeftDiff;
                        end;
                    end
                end
            end
            
            for j = 1:size(probe_map(id).right{1},2)
                rightTemp = probe_map(id).right{1}{j};
                rightMask = probe_map(id).right{2}{j};
                
                gal_key = keys(gallary_map);
                for p=1:gal_key
                    gal_id = gal_key(p);
                    for k=1:size(gallary_map(gal_id).right{1},2)
                        rightTempGal = gallary_map(id).right{1}{k};
                        rightMaskGal = gallary_map(id).right{2}{k};

                        tempRightDiff = gethammingdistance(rightTemp, rightMask, rightTempGal, rightMaskGal,1);
                        if(tempRightDiff<rightHD)
                            rightHD = tempRightDiff;
                        end;
                    end
                end
            end
            
            if(leftHD <threshold && rightHD < threshold)
                alarm = true;
            end
            
            if(inGallary == true && alarm == true)
                TP = TP+1;
            elseif(inGallary == false && alarm == true)
                FP = FP+1;
            elseif(inGallary ==true && alarm == false)
                FN = FN+1;
            elseif(inGallary == false && alarm == false)
                TN = TN+1;
            end
        end


end

