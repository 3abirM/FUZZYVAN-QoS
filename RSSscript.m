DistanceMsr=[0.5 100 200 300 400 500];
%%%%Parameters Setting%%%%%
clc;
%DistanceMsr=6


LightSpeedC=3e8;
BlueTooth=2400*1000000;%hz    
Zigbee=915.0e6;%hz    
Freq=BlueTooth;
TXAntennaGain=1;%db
RXAntennaGain=1;%db
Dref=1;%Meter
PTx=0.001;%watt
sigma=6;%Sigma from 6 to 12 %Principles of communication systems simulation with wireless application P.548
mean=0;
PathLossExponent=2;%Line Of sight
%%%%%%   FRIIS Equation %%%%%%%%%
% Friis free space propagation model:
%        Pt * Gt * Gr * (Wavelength^2)
%  Pr = --------------------------
%        (4 *pi * d)^2 * L
Wavelength=LightSpeedC/Freq;
PTxdBm=10*log10(PTx*1000);
M = Wavelength / (4 * pi * Dref);
Pr0=PTxdBm + TXAntennaGain + RXAntennaGain- (20*log10(1/M)) %%http://www.daycounter.com/Calculators/Friis-Calculator.phtml

% log normal shadowing radio propagation model:
% Pr0 = friss(d0)
% Pr(db) = Pr0(db) - 10*n*log(d/d0) + X0
% where X0 is a Gaussian random variable with zero mean and a variance in db
%        Pt * Gt * Gr * (lambda^2)   d0^passlossExp    (X0/10)
%  Pr = --------------------------*-----------------*10
%        (4 *pi * d0)^2 * L          d^passlossExp
% get power loss by adding a log-normal random variable (shadowing)
% the power loss is relative to that at reference distance d0
%  reset rand does influcence random
% rstate = randn('state');
% randn('state', DistanceMsr);
%GaussRandom=normrnd(0,6)%mean+randn*sigma;    %Help on randn
GaussRandom= (randn*0.1+0);
%disp(GaussRanom);
%for i=[0 500]
Pr=Pr0-(10*PathLossExponent* log10(DistanceMsr/Dref))+GaussRandom;
% randn('state', rstate);
%end
figure
plot(DistanceMsr,Pr,'linewidth',1)
xlabel('Disance(m)');
ylabel('RSS(dB)');
xlim([0 500])
ylim([-100 -30])

hgrid = gridxy(get(gca,'XTick'),get(gca,'YTick'),'Color',[0.6 0.6 0.6],'Linestyle','--', 'LineWidth', 0.6); 

%end
% width = 3;     % Width in inches
% height = 3;    % Height in inches
% alw = 0.75;    % AxesLineWidth
% fsz = 11;      % Fontsize
% lw = 1.5;      % LineWidth
% msz = 8;       % MarkerSize
% 
% figure(2);
% pos = get(gcf, 'Position');
% set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
% set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% plot(DistanceMsr,Pr,'b-','LineWidth',lw,'MarkerSize',msz); %<- Specify plot properites
% xlim([0 500]);
% ylim([-100 -30]);
% legend('RSS', 'Location', 'SouthEast');
% xlabel('x');
% title('Received Signal POwer');
% Set Tick Marks
% set(gca,'XTick',0:500);
% set(gca,'YTick',-100:-30);

% Here we preserve the size of the image when we save it.
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);

% % Save the file as PNG
% print('improvedExample','-dpng','-r300');
% print('improvedExample','-depsc2','-r300');
% if ispc % Use Windows ghostscript call
%   system('gswin64c -o -q -sDEVICE=png256 -dEPSCrop -r300 -oimprovedExample_eps.png improvedExample.eps');
% else % Use Unix/OSX ghostscript call
%   system('gs -o -q -sDEVICE=png256 -dEPSCrop -r300 -oimprovedExample_eps.png improvedExample.eps');
% end

