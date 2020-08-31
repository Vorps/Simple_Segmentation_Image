classdef Form

    properties
        image;
        requirementsValue;
    end
    
    methods
        function obj = Form(image, requirementsValue)
            obj.image = image;
            obj.requirementsValue = requirementsValue;
        end
    end

    methods(Static)
        function [sortform, sortFormIndex] = process(im, roi, formRequirements)
            u = size(roi)
            formIndex = zeros(u(1),1)
            i = 1;
            for r = roi'
                [image, requirementsValue] = formRequirements(im, r)
                form(i) = Form(image, requirementsValue);
                formIndex(i) = i;
                i = i +1;
            end
            [values,idx]  = sort([form(:).requirementsValue]);
            sortform = form(idx);
            sortFormIndex = formIndex(idx);
        end
    end
end

