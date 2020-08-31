function [result] = Barycentre(im, roi)
    u = size(roi);
    result = zeros(u(1), 2);
    i = 1;
    for r = roi'
        I = im(r(1):r(3), r(2):r(4));
        result(i,1) = Moment(I, 1, 0)/Moment(I, 0, 0);
        result(i,2) = Moment(I, 0, 1)/Moment(I, 0, 0);
        i = i +1 ;
    end
end