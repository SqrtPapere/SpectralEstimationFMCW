%BLACKTUC Calculates periodogram of signal x using blackman-tuckey method
%
%[ P ] =  blacktuc(x, nfft, window, M)
%
% x = column vector representing the signal
% nfft = integer number of samples on which calculate the fft
% window = string, name of the window to use to apply to autocorrelation of x('parzen', 'bartlett')
% 
% P = vector, power spectral density estimated with blackman-tuckey
%
% Example:  
%  Calculates periodogram using blacman-tuckey with parzen window of size
%  2*50 (from -M to M)
%  P = blacktuc(x, 1024, 'parzen', 50)


function [Px] =  blacktuc(x, nfft, window, M)

% x must be a column vector

    if  strcmp('parzen', window)
        w = parzenwin(2*M+1);
    elseif strcmp('bartlett', window)
        w = bartlett(2*M+1);
    end
    
    Rxx = xcorr(x,x,M,'biased'); 
    Rxx = Rxx.*w;
    dft = fft(Rxx,nfft);
    dft = dft(1:nfft/2+1); 
    Px = abs(dft);

end