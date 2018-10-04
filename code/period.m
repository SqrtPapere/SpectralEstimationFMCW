%PERIOD Calculates periodogram of signal x
%
%[ P ] = period( x, nfft, window )
%
% x = column vector representing the signal
% nfft = integer number of samples on which calculate the fft
% window = string, name of the window to use ('', 'hamming', 'kaiser', 'hann')
% 
% P = vector, power spectral density estimated with periodogram
%
% Example:  
%  Calculates periodogram using boxcar
%  P = period(x, 1024, '')
%
%  Calculates periodogram using hann window
%  P = period(x, 1024, 'hann')

function [psdx] =  period(x, nfft, window)

% x must be a column vector

    N = length(x);
    w = boxcar(N);
    if  strcmp('hamming', window)
        w = hamming(N);
    elseif strcmp('blackman', window)
        w = blackman(N);
    elseif strcmp('kaiser', window)
        w = kaiser(N);
    elseif strcmp('hann', window)
        w = hann(N);
    end

    U = sum(w.^2)/N;

    y = x.*w;
    xdft = fft(y,nfft);
    xdft = xdft(1:nfft/2+1); 
    psdx = 1/(N*U)*abs(xdft).^2;


end