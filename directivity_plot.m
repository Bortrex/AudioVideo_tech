function []=directivity_plot(N_mic,D_mic,fc,angSteer,c)

% This function plots the directivity diagram of a discrete linear microphone array
% N_mic: number of microphone
% D_mic: distance between microphones
% fc: operating frequeny or frequencies
% angSteer: desired angle
% Example: beamforming_directivity_plot(16,0.07,800,60,340)

% Angles in degress
phi = 0:0.5:359;

% Angles in rad
phir = phi*pi/180;

% Desired angle in rad
 phir_v = angSteer*pi/180;
 cos_v = cos(phir_v);

% Directivities
direc = zeros(1,length(phi));

% Test for the number of mic (odd or even) to use the appropriate formula 

if mod(N_mic,2)==0
    
    for j=1:N_mic
          m = j-(N_mic+1)/2;
          direc = direc + exp(1i*2*pi*m*D_mic*fc*(cos(phir)-cos_v)/c);
    end
    
else
    
    for j=0:N_mic-1
          direc = direc + exp(1i*2*pi*j*D_mic*fc*(cos(phir)-cos_v)/c);
    end
end

 polarplot(phir,abs(direc))
 title('Azimuth Cut (elevation angle = 0.0°)')
