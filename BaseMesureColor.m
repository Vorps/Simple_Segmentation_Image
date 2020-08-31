function [image, imageBin, color] = BaseMesureColor(I, type, norm)
    [n,m, t] = size(I);
    % Composantes RGB
    r = type(I(:,:,1));
    g = type(I(:,:,2));
    b = type(I(:,:,3)); 
    % Changement de base, mesure de la couleur
    image = reshape(norm*[2*r-g-b, 2*g-b-r, 2*b-r-g, 255-r-g-b],[n,m,4]);
    imageBin(:,:,1) = image(:,:,1) > 40;
    imageBin(:,:,2) = image(:,:,2) > 10;
    imageBin(:,:,3) = image(:,:,3) > 30;
    imageBin(:,:,4) = image(:,:,4) > 112;
    color = {'red', 'green', 'blue', 'black'};
end

