function [a,b] = lin_reg(data)

    delta = 0; %Convergente == varying less than 1%

    a = 0;
    b = 0;

    first = 1;
    %While it does not converge
    while 1
        prev_a = a;
        prev_b = b;
        [a,b] = stepGradDesc(prev_a,prev_b,data,0.001);
        
        if ~first && (a-prev_a)/prev_a > delta && (b-prev_b)/prev_b > delta
            break;
        end
        first = 0;
    end
    
    subplot(1,2,1);
    scatter(data(:,1), data(:,2));
    
    subplot(1,2,2);
    fplot(@(x)a*x+b,[0 length(data)]);

end



function [a,b] = stepGradDesc(a,b, data, learningRate)

    N = length(data);
    for i=1:N
        a_grad = (a*i+b) - data(i,2);
        b_grad = ((a*i+b) - data(i,2)) * data(i,1);
    end

    a = a - learningRate * 1/N * a_grad;
    b = b - learningRate * 1/N * b_grad;
end