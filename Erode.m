function result = Erode(image, struct, pass)
    [n,m] = size(image);
    [w,h] = size(struct)
    result = zeros(n,m);
    for e = 1:pass
        for x = 1:n-h
            for y = 1:m-w
                result(x, y) = isequal(image(x:x+h-1, y:y+w-1), struct);
            end
            disp([num2str(x/double(n)*100), ' %'])
        end
        disp(['Pass : ', num2str(e)])
    end
end