function [image, requirementsValue] = FormRequirements(im,roi)
    P = im(roi(1):roi(3), roi(2):roi(4));
    I = Erode(P, true(10), 1);
    image = P-I;
    requirementsValue = Moment(P-I, 0, 0)/Moment(P, 0, 0); 
end

