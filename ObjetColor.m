classdef ObjetColor
    
    properties
        image;
        imageBin;
        barycentre;
        objetZone;
        color;
        zone;
        zoneBin;
        roi;
        sortForm;
    end
    
    methods
        function obj = ObjetColor(image, imageBin, artefacSize, formRequirements, color, priori)
            obj.image = image;
            obj.imageBin = imageBin;
            obj.color = color;
            
            obj.zone = Zone(obj.imageBin,artefacSize);
            obj.roi = Roi(obj.zone);
            obj.zoneBin = obj.zone > 0;
            
            [obj.sortForm, sortFormIndex] = Form.process(obj.zoneBin, obj.roi, formRequirements)

            [nb, c] = size(sortFormIndex);
            if priori < nb
                nb = priori;
            end
            obj.objetZone = obj.roi(sortFormIndex(1:nb,1), :);
            obj.barycentre = Barycentre(obj.zoneBin, obj.objetZone);
        end


        function show(obj, mode)
            switch(mode)
            case 'result'
                s = size(obj.objetZone)
                i = 1;
                for r = 1:s(1)
                    rectangle('Position',[obj.objetZone(i,2), obj.objetZone(i,1),obj.objetZone(i,4)-obj.objetZone(i,2), obj.objetZone(i,3)-obj.objetZone(i,1)],'EdgeColor', obj.color)
                    text(obj.objetZone(i,2)+obj.barycentre(i,1), obj.objetZone(i,1)+obj.barycentre(i,2)+100, ['x : ', num2str(int16(obj.objetZone(i,2)+obj.barycentre(i,1))), ' y : ', num2str(int16(obj.objetZone(i,1)+obj.barycentre(i,2)))], 'Color','red','FontSize',14)
                    plot(obj.objetZone(i,2)+obj.barycentre(i,1), obj.objetZone(i,1)+obj.barycentre(i,2),'r+', 'MarkerSize', 30, 'LineWidth', 2);
                    i = i+1
                end
            case 'base'
                imagesc(obj.image);
                imwrite(uint8(obj.image), ['results/Mesure de la couleur ', obj.color,'.jpg']);
                title(['Mesure de la couleur ', obj.color])
            case 'threshold'
                imwrite(obj.imageBin,['results/Objets_threshold', obj.color, '.jpg']);
                imagesc(obj.imageBin);
                title(['Objets ', obj.color])
            case 'zone'
                colormap('default');
                 imwrite(obj.zone, ['results/Objets_Zone ', obj.color, '.jpg']);
                 imagesc(obj.zone);
                title(['Objets ', obj.color])
            case 'roi'
                figure('NumberTitle', 'off', 'Name', ['Roi : ', obj.color]);
                colormap(gray);
                u = size(obj.roi)
                i = 1;
                for r = obj.roi'
                    subplot(1, u(1), i)
                    imwrite(obj.zoneBin(r(1):r(3), r(2):r(4)), ['results/Objets : ', obj.color, ' : ', num2str(i),'.jpg']);
                    imagesc(obj.zoneBin(r(1):r(3), r(2):r(4)));
                    title(['Objets : ', obj.color, ' : ', num2str(i)])
                    i = i +1;
                end
            case 'form'
                figure('NumberTitle', 'off', 'Name', ['Contour : ', obj.color]);
                colormap(gray);
                obj.sortForm
                u = size(obj.sortForm)
                i = 1;
                for f = obj.sortForm
                    subplot(1, u(2), i)
                    imwrite(f.image, ['results/Objets : ', obj.color, ' : ', num2str(f.requirementsValue), '.jpg']);
                    imagesc(f.image);
                    title(['Objets : ', obj.color, ' : ', num2str(f.requirementsValue)])
                    i = i +1;
                end
            otherwise
                error('Erreur mode')
            end
        end
    end
end

