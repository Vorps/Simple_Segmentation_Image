classdef App
    properties
        objetsColor;
        image;
        imageColor;
        imageBin;
    end
    
    methods

        function obj = App(path, baseMesureColor, formRequirements, artefacSize, priori)
            obj.image = imread(path);
            [obj.imageColor, obj.imageBin, color] = baseMesureColor(obj.image, @int16, 0.5);
            [n,m,b] = size(obj.imageColor);
            for i = 1:b
                objetsColor(i) = ObjetColor(obj.imageColor(:,:,i), obj.imageBin(:,:,i), artefacSize, formRequirements,  color{i}, priori(i));   
            end
            obj.objetsColor = objetsColor;
        end

        function show(obj, varargin)
            len = length(obj.objetsColor);
            x= len/2; y = len/2;
            if(mod(len,2) ~= 0)
                x = x+1;
            end
            celldisp(varargin)
            if(varargin{1} == "all")
                varargin =  {'base','result', 'threshold', 'zone', 'roi', 'form'};
            end
            for mode = string(varargin)
                switch(mode)
                case 'base'
                    figure;
                    bin = obj.imageBin(:,:,1:3);
                    bin = bin+obj.imageBin(:,:,4);
                    imshow(single(bin));
                    imwrite(single(bin), 'results/base_color.jpg');
                    title('Image avec la base "couleur"')
                    figure('NumberTitle', 'off', 'Name', 'Image avec la base "couleur"')
                    colormap(gray);
                    i = 1;
                    for objetColor = obj.objetsColor
                        subplot(x,y,i)
                        objetColor.show(mode);
                        i = i +1;
                    end
                case 'result'
                    figure('NumberTitle', 'off', 'Name', 'Résultat')
                    imshow(obj.image)
                    hold on
                    for objetColor = obj.objetsColor
                        objetColor.show(mode);
                    end
                    hold off
                case {'roi', 'form'} 
                    for objetColor = obj.objetsColor
                        objetColor.show(mode);
                    end
                otherwise
                    figure('NumberTitle', 'off', 'Name', mode)
                    colormap(gray);
                    i = 1;
                    for objetColor = obj.objetsColor
                        subplot(x,y,i)
                        objetColor.show(mode);
                        i = i +1;
                    end
                end
            end
        end
        
        function save(obj, path, name)
            save([path, name], 'obj') 
        end
    end
    
    methods(Static)
       function obj = load(path, name)
            load([path, name])
        end
    end
end

