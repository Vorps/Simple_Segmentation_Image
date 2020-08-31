function [result] = Moment(I, p,q, type)
    [m,n] = size(I);
    x = 1:1:n;
    y = 1:1:m;
    norm = 1;
    if nargin < 4
        type =   'Cartesiens';
    end
    while 1 % Simule un switch style Java/C/C++/...
        switch type
            case 'Centraux-Normalises'
                norm = Moment(I, 0, 0)^((p+q)/2+1);
                type = 'Centraux';
            case 'Centraux'
                x = x - Moment(I, 1, 0)/Moment(I, 0, 0);
                y = y - Moment(I, 0, 1)/Moment(I, 0, 0);
                break;
            otherwise
                break;
        end
    end
    result = (y.^q)*I*(x'.^p)/norm;
end