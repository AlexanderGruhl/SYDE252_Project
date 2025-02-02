function Hd = Tenth_Order_IIR_Lowpass_Filter
%TENTH_ORDER_IIR_LOWPASS_FILTER Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.8 and Signal Processing Toolbox 8.4.
% Generated on: 05-Dec-2020 04:08:45

% Butterworth Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 16000;  % Sampling Frequency

Fpass = 400;         % Passband Frequency
%Fpass = 200;         % Lower Passband Frequency Test
%Fpass = 800;         % Higher Passband Frequency Test
Fstop = 8000;        % Stopband Frequency
%Fstop = 1500;        % Stopband Frequency Test
Apass = 1;           % Passband Ripple (dB)
Astop = 80;          % Stopband Attenuation (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);

% [EOF]
