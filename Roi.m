function [result] = Roi(im)
    result = zeros(max(unique(im)), 4);
    [n,m] = size(im);
    for value = 1:max(unique(im))
        %Le premier find et le dernier
        %correspond à xmin, xmax
        xIndex = mod(find(im == value),n);
        %Rotate 90 degré l'image pour que le premier find et le dernier
        %correspond à ymin, ymax
        yIndex = mod(find(im' == value),m);
        result(value, 1) = min(xIndex);
        result(value, 2) = min(yIndex);
        result(value, 3) = max(xIndex);
        result(value, 4) = max(yIndex);
    end
end