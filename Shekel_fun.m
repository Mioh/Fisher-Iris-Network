% Shekel function
% function y = Shekel_fun(x,m)
function y = Shekel_fun(x)
% The number of variables n = 4
% The parameter m should be one of m = 5,7,10.
m=5;
if (length(x)==4 & (m==5 | m==7 | m==10))
    v1=[4 1 8 6 3 2 5 8 6 7.0];
    v2=[4 1 8 6 7 9 5 1 2 3.6];
    v3=[4 1 8 6 3 2 3 8 6 7.0];
    v4=[4 1 8 6 7 9 3 1 2 3.6];
    M=[v1;v2;v3;v4];
    V=[0.1 0.2 0.2 0.4 0.4 0.6 0.3 0.7 0.5 0.5]';
    switch m
        case 5
            a=M(:,1:5);
            c=V(1:5);
        case 7
            a=M(:,1:7);
            c=V(1:7);
        case 10
            a=M;
            c=V;
    end
    s1=0;
    for i = 1: m
        s2 = 0;
        for j = 1:4
            s2 = s2+(x(j)-a(j,i)).^2;
        end
        s1 = s1+1/(s2+c(i));
    end
    y = -s1;
else
    if length(x)~=4
        error('ERROR IN DIMENSIONS!!! Shekel`s function is 4 dimensional.');
    else
        error('The value of the second argument must be 5, 7 or 10.');
    end
end
