%% Run Application
app = App('file/ColorMarkers2.jpg', @BaseMesureColor, @FormRequirements, 10000, [1,1,1,1])
%% Load Application
load('save/app2.mat')
%%
close all
app.show('result')
%%
save('save/app2', 'app')
%%