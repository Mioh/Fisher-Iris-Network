% Shubert1 function
function y = Shubert_fun1(x)
n = length(x);
p = 1.0;
for i = 1: n
    s = 0.0;
    for j = 1:5
        s = s+j.*cos((j+1).*x(i)+j);
    end
    p = p.*s;
end
y = p;