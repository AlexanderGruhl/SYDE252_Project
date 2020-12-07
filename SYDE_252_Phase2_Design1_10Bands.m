%filename_loud = 'Civ6_Loud.mp3';
filename_loud = 'MaleConversation_Loud.mp3';
%filename_medium = 'RiceMoon_Mid.mp3';
filename_medium = 'MaleConversation_Mid.mp3';
%filename_quiet = 'Canon_Quiet.mp3';
filename_quiet = 'FemaleConversation_Quiet.mp3';


audio(filename_loud);
%audio(filename_medium); %uncomment to run this sound file
%audio(filename_quiet); %uncomment to run this sound file

function audio(x)
  %Read audio file
  [y, Fs] = audioread(x);
  output_dimensions = size(y, 2);

  %Turn stereo sound to mono
  if output_dimensions > 1
    y = sum(y, 2) / size(y, 2);
  end
  
  %Play and graph the inputted sound
  %sound(y, Fs);
  figure(1);
  plot(y);
  input_sound_title = strcat(x, ' Inputted Signal');
  title(input_sound_title);
  xlabel('Audio Sample')
  ylabel('Amplitude')
  %pause(size(y, 1)./Fs); %pause file execution to let the inputted sound file play

  %Write the inputted sound to a new audio file
  x = erase(x, '.mp3');
  x = strcat(x, '.wav');
  new_audio_file_name = strcat('Returned_', x);
  disp(new_audio_file_name)
  audiowrite(new_audio_file_name, y, Fs);

  %%Time specifications:
  dt = 1/Fs;
  t = linspace(0, size(y, 1)./Fs, size(y, 1)); %signal length
    
  freq_seperator(y, t, Fs);
  %%Cosine wave:
  %Fc = 1000;                     % hertz
  %cos_audio = cos(2*pi*Fc*t);         %uses angular frequency, 2pi * frequency = ang freq
  %cos_audio_name = strcat('cosine_wave_', x);
  %audiowrite(cos_audio_name, cos_audio, Fs);
  %sound(cos_audio, Fs);

  %Graph two cycles of the cosine wave
  %two_cycles = (t>=0 & t<=0.002+dt);
  %cos_audio = cos(2*pi*Fc*t);
  %figure(2);
  %plot(t(two_cycles), cos_audio(two_cycles));
  %cosine_signal_title = strcat(cos_audio_name, ' Cosine Signal');
  %title(cosine_signal_title);
  %xlabel('Audio Sample')
  %ylabel('Amplitude')
  
  %pause(size(y, 1)./Fs); %pause file execution to let the inputted sound file play
end
 
function freq_seperator(y, t, Fs)
  disp("In freq_seperator")  
  %stop1 = 90;
  %stop1 = 95;
  %stop2 = 889;
  %pass1 = 100;
  %pass2 = 883;
  %inc = 790;
  
  %%stop1 = [90 880 1670 2460 3250 4040 4830 5620 6410 7200];
  %%stop2 = [889 1679 2469 3259 4049 4839 5629 6419 7209 7999];
  %%pass1 = [100 890 1680 2470 3260 4050 4840 5630 6420 7210];
  %%pass2 = [879 1669 2459 3249 4039 4829 5619 6409 7199 7989];
  
  stop1 = [100 890 1680 2470 3260 4050 4840 5630 6420 7210];
  stop2 = [889 1679 2469 3259 4049 4839 5629 6419 7209 7999];
  pass1 = [105 895 1685 2475 3265 4055 4845 5635 6425 7215];
  pass2 = [879 1669 2459 3249 4039 4829 5619 6409 7199 7989];
  
  %stop1 = [80 140.1 214.9 308 424 568.3 748 971.6 1250.1 1596.7 2028.2 2565.4 3234.1 4066.5 5102.9 6393];
  %stop2 = [140.1 214.9 308 424 568.3 748 971.6 1250.1 1596.7 2028.2 2565.4 3234.1 4066.5 5102.9 6393 7999];
  %pass1 = [90 150.1 224.9 318 434 578.3 758 981.6 1260.1 1606.7 2038.2 2575.4 3244.1 4076.5 5112.9 6403];
  %pass2 = [130.1 204.9 298 414 558.3 738 961.6 1240.1 1586.7 2018.2 2555.4 3224.1 4056.5 5092.9 6383 7989];
  
  %stop1 = [103.83 146.83 220 329.63 493.88 739.99 1108.73 1661.22 2489.02 3729.31 5587.65 7902.13];
  %stop2 = [146.83 220 329.63 493.88 739.99 1108.73 1661.22 2489.02 3729.31 5587.65 7902.13 8000];
  %pass1 = [113.83 156.83 230 339.63 503.88 749.99 1118.73 1671.22 2499.02 3739.31 5597.65 7912.13];
  %pass2 = [136.83 210 319.63 483.88 729.99 1098.73 1651.22 2479.02 3719.31 5577.65 7892.13 7990];
  
  %stop1 = [100.83 161.81 274.18 463.16 780.99 1315.51 2214.46 3726.31 6268.93 7902.13];
  %stop2 = [161.81 274.18 463.16 780.99 1315.51 2214.46 3726.31 6268.93 7902.13 8000];
  %pass1 = [110.83 171.81 284.18 473.16 790.99 1325.51 2224.46 3736.31 6278.93 7912.13];
  %pass2 = [151.81 264.18 453.16 770.99 1305.51 2204.46 3716.31 6258.93 7892.13 7990];

  Bandpass_Filter_Signals = cell(10);
  
  for counter=1:10
      BF = Chebyshev2_Bandpass_Filter(stop1(1 , counter), stop2(1, counter), pass1(1, counter), pass2(1, counter));
      %BF = Butterworth_Bandpass(stop1(1 , counter), stop2(1, counter), pass1(1, counter), pass2(1, counter));
      Bandpass_Filter_Signals{1, counter} = filter(BF,y);
  end
  
  %for counter = 1:10
      %BF = Bandpass_filter(stop1, stop2, pass1, pass2);
      %BF = Chebyshev2_Bandpass_Filter(stop1, stop2, pass1, pass2);
      %BF = Chebyshev2_Bandpass_Filter(stop1(1 , counter), stop2(1, counter), pass1(1, counter), pass2(1, counter));
      %switch(counter)
          %case 1
              %FilteredSignal1 = filter(BF,y);
          %case 2
              %FilteredSignal2 = abs(filter(BF,y));
          %case 3
              %FilteredSignal3 = abs(filter(BF,y));
          %case 4
              %FilteredSignal4 = abs(filter(BF,y));
          %case 5
              %FilteredSignal5 = abs(filter(BF,y));
          %case 6
              %FilteredSignal6 = abs(filter(BF,y));
          %case 7
              %FilteredSignal7 = abs(filter(BF,y));
          %case 8
              %FilteredSignal8 = abs(filter(BF,y));
          %case 9
              %FilteredSignal9 = abs(filter(BF,y));
          %case 10
              %%BF = Bandpass_filter(stop1, 8000, pass1, pass2);
              %FilteredSignal10 = filter(BF,y);
      %end
    
    %stop1 = stop1 + inc;
    %stop2 = stop2 + inc;
    %pass1 = pass1 + inc;
    %pass2 = pass2 + inc;
  %end
  
  figure(2);
  %plot(t, FilteredSignal1)
  plot(t, Bandpass_Filter_Signals{1, 1})
  figure(3);
  %plot(t, FilteredSignal10)
  plot(t, Bandpass_Filter_Signals{1, 10})
  
  figure(8);
  %plot(t, envelope(FilteredSignal1))
  plot(t, envelope(Bandpass_Filter_Signals{1, 1}))
  
  for abs_counter=1:10
      Bandpass_Filter_Signals{1, abs_counter} = abs(Bandpass_Filter_Signals{1, abs_counter});
  end
  
  %FilteredSignal1 = abs(FilteredSignal1);
  %FilteredSignal10 = abs(FilteredSignal10);
  
  figure(9);
  %plot(t, envelope(FilteredSignal1))
  plot(t, Bandpass_Filter_Signals{1, 1})

  %LF = New_Lowpass_Filter;
  %LF = Lowpass_Filter;
  LF = Tenth_Order_IIR_Lowpass_Filter;
  %LF = FIR_Lowpass_Filter;
  FilteredSignals = cell(10);
  
  for filter_counter=1:10
      FilteredSignals{1, filter_counter} = filter(LF,Bandpass_Filter_Signals{1, filter_counter});
  end
  
  %FilteredSignals{1, 1} = filter(LF,FilteredSignal1);
  %FilteredSignals{1, 2} = filter(LF,FilteredSignal2);
  %FilteredSignals{1, 3} = filter(LF,FilteredSignal3);
  %FilteredSignals{1, 4} = filter(LF,FilteredSignal4);
  %FilteredSignals{1, 5} = filter(LF,FilteredSignal5);
  %FilteredSignals{1, 6} = filter(LF,FilteredSignal6);
  %FilteredSignals{1, 7} = filter(LF,FilteredSignal7);
  %FilteredSignals{1, 8} = filter(LF,FilteredSignal8);
  %FilteredSignals{1, 9} = filter(LF,FilteredSignal9);
  %FilteredSignals{1, 10} = filter(LF,FilteredSignal10);
  
  
  %FilteredSignal1 = filter(LF,FilteredSignal1);
  %FilteredSignal2 = filter(LF,FilteredSignal2);
  %FilteredSignal3 = filter(LF,FilteredSignal3);
  %FilteredSignal4 = filter(LF,FilteredSignal4);
  %FilteredSignal5 = filter(LF,FilteredSignal5);
  %FilteredSignal6 = filter(LF,FilteredSignal6);
  %FilteredSignal7 = filter(LF,FilteredSignal7);
  %FilteredSignal8 = filter(LF,FilteredSignal8);
  %FilteredSignal9 = filter(LF,FilteredSignal9);
  %FilteredSignal10 = filter(LF,FilteredSignal10);
  
  figure(4);
  plot(t, FilteredSignals{1, 1})
  figure(5);
  plot(t, FilteredSignals{1, 10}) 
  
  disp("Part 3")
  cos_filters = cell(10);
  %middle_freq_test = sqrt(stop1(1 , 1)*stop2(1, 1));
  %disp(middle_freq)
  %%cos_filters(1, 1) = cos(middle_freq);
  %ex_fil = cos(middle_freq_test);
  %combine = ex_fil * FilteredSignals{1, 1};
  %figure(6);
  %plot(t, combine)   
  for cos_counter=1:10
      middle_freq = sqrt(stop1(1 , cos_counter)*stop2(1, cos_counter));
      cos_oscillator = cos(2*pi*middle_freq);
      %ex = cos_oscillator*FilteredSignals(1, cos_counter);
      cos_filters{1, cos_counter} = cos_oscillator*FilteredSignals{1, cos_counter};
  end
  
  figure(6);
  plot(t, cos_filters{1, 10})
  %figure(7);
  %plot(t, cos_filters(1, 10))
  added_signals = cos_filters{1, 1};
  
  for signal_count=2:10
      added_signals = added_signals + cos_filters{1, signal_count};
  end
  
  disp(max(abs(added_signals)))
  added_signals = added_signals/max(abs(added_signals));
  figure(7)
  plot(t, added_signals)
  %figure(8)
  %plot(t, added_signals)
  
  sound(added_signals, Fs);
  %returned_audio_file_name = 'Evenly_Spaced_Civ6_10Bands.wav';
  returned_audio_file_name = 'Evenly_Spaced_Loud_Male_Speech_10Bands.wav';
  %returned_audio_file_name = 'Evenly_Spaced_Female_Speech_10Bands.wav';
  disp(returned_audio_file_name)
  audiowrite(returned_audio_file_name, added_signals, Fs);
  
end