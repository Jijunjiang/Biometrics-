function [threshold] = GenuineImposterDistribution(gallary, probe)
    
        gallary_map = generateMap(gallary);
        probe_map = generateMap(probe);
        
        pro_key = keys(probe_map);
        gal_key = keys(gallary_map);
        [~,len_Pkey] = size(pro_key);
        [~,len_Gkey] = size(gal_key);
        intersection = gal_key(ismember(gal_key,pro_key));
        
        genuine = [];
        imposter =[];
        
        for i = 1:len_Pkey
            Pid_inter = pro_key(i);
            Pid = Pid_inter{1,1};
            if(strcmpi(Pid, '*'))
                continue;
            elseif(~gallary_map.isKey(Pid))
                continue;
            else
                for j=1:len_Gkey
                    Gid_inter = gal_key(j);
                    Gid = Gid_inter{1,1};
                    if(strcmpi(Gid, '*'))
                        continue;
                    elseif(~ismember(Gid_inter, intersection))
                        continue;
                    else
                        
                        if(strcmpi(Pid, Gid))
                            tmpLeft = []; %to store the hd distance
                            tmpRight = [];
                            for m = 1:size(probe_map(Pid).left{1},2)
                                leftPTemp = probe_map(Pid).left{1}{m};
                                leftPMask = probe_map(Pid).left{2}{m};
                                t_tmp=[];
                                    for k=1:size(gallary_map(Gid).left{1},2)   
                                        leftTempGal = gallary_map(Gid).left{1}{k};
                                        leftMaskGal = gallary_map(Gid).left{2}{k};

                                        tempLeftDiff = gethammingdistance(leftPTemp, leftPMask, leftTempGal, leftMaskGal,1);
                                        
                                        t_tmp = [t_tmp,tempLeftDiff];
                                        

                                    end
                                    tmpLeft = [tmpLeft,median(t_tmp)]
                            end
                            
                            for m = 1:size(probe_map(Pid).right{1},2)
                                rightPTemp = probe_map(Pid).right{1}{m};
                                rightPMask = probe_map(Pid).right{2}{m};
                                t_tmp = [];
                                for k=1:size(gallary_map(Gid).right{1},2)
                                    rightTempGal = gallary_map(Gid).right{1}{k};
                                    rightMaskGal = gallary_map(Gid).right{2}{k};
                                    
                                    tempRightDiff = gethammingdistance(rightPTemp, rightPMask, rightTempGal, rightMaskGal,1);
                                    t_tmp = [t_tmp, tempRightDiff];
                                end
                                tmpRight = [tmpRight,median(t_tmp)];
                            end
                                    
                            genuine = [genuine, tmpLeft];
                            genuine = [genuine, tmpRight];
                        else
                            tmpLeft = []; %to store the hd distance
                            tmpRight = [];
                            for m = 1:size(probe_map(Pid).left{1},2)
                                leftPTemp = probe_map(Pid).left{1}{m};
                                leftPMask = probe_map(Pid).left{2}{m};
                                t_tmp=[];
                                    for k=1:size(gallary_map(Gid).left{1},2)   
                                        leftTempGal = gallary_map(Gid).left{1}{k};
                                        leftMaskGal = gallary_map(Gid).left{2}{k};

                                        tempLeftDiff = gethammingdistance(leftPTemp, leftPMask, leftTempGal, leftMaskGal,1);
                                        
                                        t_tmp = [t_tmp,tempLeftDiff];
                                        

                                    end
                                    tmpLeft = [tmpLeft,median(t_tmp)]
                            end
                            
                            for m = 1:size(probe_map(Pid).right{1},2)
                                rightPTemp = probe_map(Pid).right{1}{m};
                                rightPMask = probe_map(Pid).right{2}{m};
                                t_tmp = [];
                                for k=1:size(gallary_map(Gid).right{1},2)
                                    rightTempGal = gallary_map(Gid).right{1}{k};
                                    rightMaskGal = gallary_map(Gid).right{2}{k};
                                    
                                    tempRightDiff = gethammingdistance(rightPTemp, rightPMask, rightTempGal, rightMaskGal,1);
                                    t_tmp = [t_tmp, tempRightDiff];
                                end
                                tmpRight = [tmpRight,median(t_tmp)];
                            end
                                    
                            imposter = [imposter, tmpLeft];
                            imposter = [imposter, tmpRight];
                        end
                    end
                end
            end
        end
        
        [counts_g, centers_g] = hist(genuine);
        counts_g = [0, counts_g/sum(counts_g), 0];
        centers_g = [0, centers_g, 0.5];
        
        [counts_i, centers_i] = hist(imposter);
        counts_i = [0, counts_i/sum(counts_i), 0];
        centers_i = [0, centers_i, 1];
        
        figure
%         histogram(g_x2,'Normalization','Probability');
%         histfit(g_x2,10);
        plot(centers_g, counts_g);
        hold on
%         histogram(i_x,'Normalization','Probability');
%         histfit(i_x,20);
        plot(centers_i, counts_i);
        threshold = 0;
            
                
        
        


end

