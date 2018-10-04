%SPECTR_PER Calculates spectrogram using different kinds of periodogram
%estimate and plot it in 3D
%
%[ S ] =  spectr_per( type, doChirp, Fs, X, nfft, win, Lwin, ov)
%
% type = string describing one of the possible method for periodogram ('period', 'blacktuc', 'welbart')

% doChirp = boolean (0 or 1), a utility argument to plot the correct time and frequency
% domain
% Fs = integer, for plotting correct frequency domain 
% X = matrix containing the divided version of a signal. Each row contains
% a piece of the signal
% nfft = integer number of samples on which calculate the fft
% win = string, name of the window to use in a periodogram method
% 
% S = Matrix, representing the spectrogram
%
% Example:  
%  Calculates spectrogram using modified period method using 'hann' window 
%  S = spectr_per( 'period', doChirp, Fs, X,  nfft, 'hann');


function [S] = spectr_per( type, doChirp, Fs, X, nfft, win, Lwin, ov)

    S=[];
    for i = 1:size(X, 1)
        y = X(i,:)';
        if strcmp(type,'period')
            if nargin <=4
                win = '';
            end
            [Px] = period(y, nfft, win);
        elseif strcmp(type,'welbart')
            [Px] = welbart(y, nfft, win, Lwin, ov);
        elseif strcmp(type,'blacktuc')
            [Px] = blacktuc(y, nfft, win, Lwin);
        else
            return
        end
        
        Px = 10*log10(Px);
        S = [S Px];
    end

    %matrix normalization from 0 to 1
    normS = S - min(S(:));
    S = normS ./ max(normS(:));

    F= 0:Fs/nfft:Fs/2;

    if doChirp == 1
        k=size(X, 2);
        t = 0:1/Fs:4;
        T = 0:(k*1/Fs):(length(t)*1/Fs)-(k*1/Fs);
    else
        T = (0:size(S,2)-1)*26;
    end
   

    figure, surf(T,F,S, 'EdgeColor','none'), axis([T(1) T(end) F(1) F(end)]), view(90,270)
    colorbar()

end


