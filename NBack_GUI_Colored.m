%% N-back Task with GUI, Performance Plots & Colored Figures
% Sleep & Working Memory Project
% Author: Mariam
% -------------------------------------------

clear; clc;

%% Settings
nTrials = 60;               % total trials per level
nBackLevels = [2 3];        % levels: 2-back and 3-back
stimDur = 1.5;              % stimulus duration (sec)
targetProb = 0.25;          % probability of a target trial
lettersSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

% Colors for each level
levelColors = [0 0.4470 0.7410; 0.8500 0.3250 0.0980]; % blue, orange

%% Initialize result table
Results = table();
performanceSummary = table();

%% Loop over N-back levels
for idx = 1:length(nBackLevels)
    nBack = nBackLevels(idx);

    % Generate letter sequence
    letters = lettersSet(randi([1 length(lettersSet)], 1, nTrials));
    isTarget = false(1,nTrials);

    for t = (nBack+1):nTrials
        if rand < targetProb
            letters(t) = letters(t-nBack);
            isTarget(t) = true;
        end
    end

    % Response arrays
    resp = NaN(1,nTrials);
    rt   = NaN(1,nTrials);

    % Create figure for GUI
    hFig = figure('Name',sprintf('%d-back Task',nBack),'NumberTitle','off', ...
        'MenuBar','none','ToolBar','none','Color',[0.9 0.9 0.9]);

    hText = uicontrol('Style','text','FontSize',36,'Position',[100 150 300 100],'String','');
    uicontrol('Style','text','Position',[10 10 500 20],'String','Press Z for target, M for non-target');

    trialIdx = 1;
    set(hFig,'UserData',[]);  % used to signal key press

    set(hFig,'KeyPressFcn',@keyPress);  % nested function

    while trialIdx <= nTrials
        set(hText,'String',letters(trialIdx));
        drawnow;

        tic;
        waitfor(hFig,'UserData');  % wait until a key is pressed
        rt(trialIdx) = toc;

        keyPressed = get(hFig,'UserData');

        if strcmpi(keyPressed,'z')
            resp(trialIdx) = 1;
        elseif strcmpi(keyPressed,'m')
            resp(trialIdx) = 0;
        end

        trialIdx = trialIdx + 1;
        set(hFig,'UserData',[]);  % reset for next trial
        pause(stimDur);
    end

    close(hFig);

    % Compute performance
    accuracy = sum(resp == isTarget) / nTrials;
    meanRT = mean(rt(~isnan(rt)));
    fprintf('\n%d-back Results: Accuracy = %.2f%%, Mean RT = %.3f sec\n', nBack, accuracy*100, meanRT);

    % Append to results table
    T = table(repmat(nBack, nTrials,1), (1:nTrials)', letters', isTarget', resp', rt',...
        'VariableNames', {'NBack','Trial','Stimulus','IsTarget','Response','RT'});
    Results = [Results; T];

    % Save summary for plotting
    performanceSummary = [performanceSummary; table(nBack, accuracy, meanRT)];
end

%% Save full dataset
writetable(Results,'Extended_NBack_GUI_Colored_Results.csv');
disp('All data saved to Extended_NBack_GUI_Colored_Results.csv');

%% Plot performance summary with colors
figSummary = figure('Name','Performance Summary','NumberTitle','off');
subplot(1,2,1);
bar(performanceSummary.NBack, performanceSummary.accuracy*100,'FaceColor','flat');
barHandles = findobj(gca,'Type','Bar');
for i = 1:height(performanceSummary)
    barHandles.CData(i,:) = levelColors(i,:);
end
xlabel('N-back Level'); ylabel('Accuracy (%)');
title('Accuracy per N-back Level');
ylim([0 100]);

subplot(1,2,2);
bar(performanceSummary.NBack, performanceSummary.meanRT,'FaceColor','flat');
barHandles = findobj(gca,'Type','Bar');
for i = 1:height(performanceSummary)
    barHandles.CData(i,:) = levelColors(i,:);
end
xlabel('N-back Level'); ylabel('Mean Reaction Time (s)');
title('Mean Reaction Time per N-back Level');

% Save figure as PNG
saveas(figSummary,'Performance_Summary_Colored.png');
disp('Colored performance summary figure saved as Performance_Summary_Colored.png');

%% Nested function for key press
function keyPress(~, event)
    set(gcbf,'UserData',event.Key);  % store pressed key in figure
end
