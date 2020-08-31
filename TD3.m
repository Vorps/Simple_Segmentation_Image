%% Run Application
app = App('file/ColorMarkers2.jpg', @BaseMesureColor, @FormRequirements, 10000, [1,1,1,1])
%% Load Application
load('save/app1.mat')
%%
close all
app.show('base')
%%
save('save/app2', 'app')
%%