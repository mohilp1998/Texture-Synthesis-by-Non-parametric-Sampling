function tray = neighbourhood(m,n,k)
    
    a = (k-1)/2;
    tray = [];
    coord = zeros(1,6);
    for i=1:(2*n+2*m+4)
        if i<=(n+2)
            coord(1,3) = max(1,(i-a-1)); % start column
            coord(1,4) = min((n),(i+a-1)); % end column
            coord(1,1) = 1; % start row
            coord(1,2) = a; % end row
            coord(1,5) = 1-a-1; %row
            coord(1,6) = (i-a-1); %column
            coord(1,1) = coord(1,1) - coord(1,5) +1;
            coord(1,2) = coord(1,2) - coord(1,5) +1;
            coord(1,3) = coord(1,3) - coord(1,6) +1;
            coord(1,4) = coord(1,4) - coord(1,6) +1;
        elseif i<=(m+n+3)
            coord(1,3) = (n+2)-a-1; % start column
            coord(1,4) = n; %end column
            coord(1,1) = max(2,(i-a-n-1))-1; %start row
            coord(1,2) = min((m+1),(i+a-n-1))-1;% end row
            coord(1,6) = (n+2)-a-1;%column
            coord(1,5) = (i-a-n-1) - 1;%row
            coord(1,1) = coord(1,1) - coord(1,5) +1;
            coord(1,2) = coord(1,2) - coord(1,5) +1;
            coord(1,3) = coord(1,3) - coord(1,6) +1;
            coord(1,4) = coord(1,4) - coord(1,6) +1;
        elseif i<= 2*n+m+4
            coord(1,4) = min(n,n-(i-n-m-4)+a); % end column
            coord(1,3) = max(1,n-(i-n-m-4)-a); % start column
            coord(1,1) = m+2-a-1; % start row
            coord(1,2) = m; % end row
            coord(1,5) = m+2-a-1;%row
            coord(1,6) = n-(i-n-m-4)-a;%column
            coord(1,1) = coord(1,1) - coord(1,5) +1;
            coord(1,2) = coord(1,2) - coord(1,5) +1;
            coord(1,3) = coord(1,3) - coord(1,6) +1;
            coord(1,4) = coord(1,4) - coord(1,6) +1;
        else
            coord(1,3) = 1; % start column
            coord(1,4) = a; %end column
            coord(1,1) = max(1,m-(i-2*n-m-5)-a); %start row
            coord(1,2) = min(m,m-(i-2*n-m-5)+a);% end row
            coord(1,6) = 1-a-1;%column
            coord(1,5) = m-(i-2*n-m-5)-a;%row
            coord(1,1) = coord(1,1) - coord(1,5) +1;
            coord(1,2) = coord(1,2) - coord(1,5) +1;
            coord(1,3) = coord(1,3) - coord(1,6) +1;
            coord(1,4) = coord(1,4) - coord(1,6) +1;
        end
        tray = [tray;coord];
    end
    
end
