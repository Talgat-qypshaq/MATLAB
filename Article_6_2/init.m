function will_use = init(user_x_1, user_y_1, user_x_2, user_y_2)
    clc;
    segments = load('Article_6_2/segments.txt');
    X = segments(:, [2,4]);
    Y = segments(:, [3,5]);
    number_of_segments = size(X,1);
    
    fid = fopen('Article_6_2/routes.txt');
    routes = textscan(fid, '%s%s%s','Delimiter','\t');
    fclose(fid);
    number_of_routes = size(routes{2},1);    
    
    for a=1:1:number_of_segments
        %fprintf('x1 = %d; s_x_1 = %d; x2 = %d; s_x_2 = %d;\n',user_x_1,X(a,1),user_x_2,X(a,2));
        if(((user_x_1 == X(a,1)&&user_x_2 == X(a,2))||(user_x_2 == X(a,2) && user_x_1 == X(a,1)))&&((user_y_1 == Y(a,1) && user_y_2 == Y(a,2))||(user_y_2 == Y(a,2) && user_y_1 == Y(a,1))))
            %fprintf('segment id = %d\n',a);
            for b = 1:1:number_of_routes
                beginning = strcat('"',int2str(a));
                beginning = strcat(beginning,',');
                middle = strcat(',',int2str(a));
                middle = strcat(middle,',');
                ending = strcat(',',int2str(a));
                ending = strcat(ending,'"');                
                %fprintf('b = %s; m = %s; e = %s;\n',beginning, middle, ending);
                %fprintf('bb = %d; ee = %d;\n',contains(routes{2},beginning),contains(routes{2},ending))
                if( (isequal(contains(routes{2}(b),beginning),1)) || (isequal(contains(routes{2}(b),middle),1)) || (isequal(contains(routes{2}(b),ending),1)) )
                    %fprintf('found at the route %s\n', routes{1}{b});
                    %fprintf('route id = %d;\n', beginning);
                    %fprintf('route id = %d;\n', routes{2}{b});
                    prediction = route_usage(routes{1}{b});
                    fprintf('The route will be used with the probability: %.2f\n',prediction);
                end
            end
        end
    end    
    will_use = 5;
end