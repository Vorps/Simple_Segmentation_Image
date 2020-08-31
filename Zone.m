function [ENoArtefact] = Zone(Im, sizemin)
    i = 1;
    [n,m] = size(Im);
    E =  zeros(n,m,1);
    for x = 1:n
        for y = 1:m
            % Si le point est un élément d'un objet
            if(Im(x, y) == 1)
                if(E(x,y-1) ~= 0 || E(x-1,y) ~= 0)
                    % Si une zone est adjacente au point (Gauche, Haut)
                    % Inutile de tester en (bas, droite) on est pas encore
                    % passé
                    if(E(x,y-1) ~= 0 && E(x-1,y) ~= 0)
                        %Si deux zones sont adjacentes
                        if(E(x-1,y) ~= E(x,y-1))
                            % Il est possible qu'on assemble deux zones
                            % différentes dans ce cas fusionner les deux
                            % zones par la gauche.
                            % Trés couteux en temps pas moyen de faire
                            % fonctionner les pointeurs correctement ***
                            E(E==E(x-1,y)) = E(x,y-1);
                        end
                        E(x,y) = E(x,y-1);
                    elseif(E(x,y-1) ~= 0)
                        % Si une zone à gauche 
                        E(x,y) = E(x,y-1);
                    elseif(E(x-1,y) ~= 0)
                        % Si une zone en haut
                        E(x,y) = E(x-1,y);
                    end
                else
                    % Si aucune zone est autour de ce point => création
                    % d'une nouvelle zone avec un nouveau index
                    E(x,y) = i;
                    i = i +1;
                end
            end
        end
        disp([num2str(x/double(n)*100), ' %'])
    end
    %Calcule la surface des zones et retire celles qui font moins de
    %sizemin puis les tries dans l'ordre décroissant
    number = unique(E);
    surface = zeros(length(number),2);
    for i = 1:length(number) %Relation entre la zone et la surface
        surface(i,1) = number(i);
        surface(i,2) = length(E(E==number(i)));
    end
    %Retire les zones dont la surface fait moins que sizemin
    surfaceNoArtefact = surface(find(surface(:,2) > sizemin & surface(:,1) ~=0 ),:)
    %Triage sur les surfaces décroissant
    [values,idx]  = sort(surfaceNoArtefact(:,2),'descend');
    sortSurfaceNoArtefac = surfaceNoArtefact(idx,:)
    %Attribue de nouveaux index aux zones
    ENoArtefact = zeros(n,m);
    e = 1;
    for i = sortSurfaceNoArtefac(:,1)'
        ENoArtefact(E == i) = e;
        e = e+1;
    end
end