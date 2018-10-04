clear;
clc;

% Set doChirp to 0 or 1 if you want to plot spectrogram of chirp

doChirp = 0;

[UP, Fs] = retrieve_data();

nfft = 1024;


if doChirp == 1
    Fs = 1000;
    C = getDividedChirp(80);
    
    spectr_per( 'blacktuc', doChirp, Fs, C, nfft, 'bartlett', 25);
    xlabel('Time ms','FontSize',12) % x-axis label
    ylabel('Frequency Hz','FontSize',12) % y-axis label
    title('Spectrogram of chirp using blacktuc(bartlett, 25)')
    
   %spectr_per( 'welbart', doChirp, Fs, C, nfft, 'hamming', 50, 0);
    spectr_per( 'welbart', doChirp, Fs, C, nfft, 'hamming', 40, 50);
    xlabel('Time ms','FontSize',12) % x-axis label
    ylabel('Frequency Hz','FontSize',12) % y-axis label
    title('Spectrogram of chirp using welbart(hamming, 40, 50)')
    
    spectr_per( 'period', doChirp, Fs, C, nfft, '');
    xlabel('Time ms','FontSize',12) % x-axis label
    ylabel('Frequency Hz','FontSize',12) % y-axis label
    title('Spectrogram of chirp using period(boxcar)')

    % spectr_per( 'welbart', doChirp, Fs, C, nfft, 'hamming', 50, 40);
    % spectr_per( 'welbart', doChirp, Fs, C, nfft, 'hamming', 50, 30);
    % spectr_per( 'welbart', doChirp, Fs, C, nfft, 'hamming', 50, 20);
    
    

else



    %  spectr_per( 'welbart', doChirp, Fs, UP(1:1000, :), nfft, 'hamming', 240, 40);

    %  spectr_per( 'welbart', doChirp, Fs, UP(1:1000, :), nfft, 'hamming', 240, 30);

    %  spectr_per( 'welbart', doChirp, Fs, UP(1:1000, :), nfft, 'hamming', 240, 20);

  
    %spectr_per( 'blacktuc', doChirp, Fs, UP(1:1000, :),  nfft, 'bartlett', 171);
    
    spectr_per( 'period', doChirp, Fs, UP(1:1000, :),  nfft, '');
    xlabel('Time ms') % x-axis label
    ylabel('Frequency Hz') % y-axis label
    title('Spectrogram of ramps up using period')

    spectr_per( 'period', doChirp, Fs, UP(1:1000, :),  nfft, 'kaiser');
    xlabel('Time ms') % x-axis label
    ylabel('Frequency Hz') % y-axis label
    title('Spectrogram of ramps up using period (kaiser)')

    
    spectr_per( 'welbart', doChirp, Fs, UP(1:1000, :), nfft, 'hamming', 256, 0);
    title('Spectrogram of ramps up using welbart (hamming, 256, 0)')
    xlabel('Time ms') % x-axis label
    ylabel('Frequency Hz') % y-axis label


    spectr_per( 'welbart', doChirp, Fs, UP(1:1000, :), nfft, '', 256, 50);
    title('Spectrogram of ramps up using welbart (hamming, 256, 50)')
    xlabel('Time ms') % x-axis label
    ylabel('Frequency Hz') % y-axis label
    
    
    spectr_per( 'blacktuc', doChirp, Fs, UP(1:1000, :), nfft, 'parzen', 256);
    title('Spectrogram of ramps up using blacktuc (parzen, 256)')
    xlabel('Time ms') % x-axis label
    ylabel('Frequency Hz') % y-axis label
    
    spectr_per( 'blacktuc', doChirp, Fs, UP(1:1000, :), nfft, 'bartlett', 256);
    title('Spectrogram of ramps up using blacktuc (bartlett, 256)')
    xlabel('Time ms') % x-axis label
    ylabel('Frequency Hz') % y-axis label



end
