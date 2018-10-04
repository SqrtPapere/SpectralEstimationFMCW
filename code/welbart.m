%WELBART Calculates periodogram of signal x using welch-bartlett method
%
%[ P ] = welbart(x, nfft, window, L, ov)
%
% x = column vector representing the signal
% nfft = integer number of samples on which calculate the fft
% window = string, name of the window to use ('', 'hamming', 'blackman')
% L = integer, length of the window to divide the signal in segment of
% length L as described by whelch-bartlett. Must be shorter than x.
% ov = integer between 0 and 99 representing the overlap percentage between
% windows
% 
% P = vector, power spectral density estimated with periodogram
%
% Example:  
%  Calculates periodogram with bartlett method using widow size 200 and 50
%  overlap
%  P = welbart(x, 1024, '', 200, 50)
%
%  Calculates periodogram with welch method using hamming window of size 200 and 30
%  overlap
%  P = welbart(x, 1024, 'hamming', 200, 30)

function [Px] = welbart(x, nfft, window, L, ov)
% x must be a column vector

    N = length(x);

    percov = round(L*ov/100);
    percov = L - percov;
    
    w = rectwin(L);

    if strcmp('hamming', window)
        w = hamming(L);
    elseif strcmp('blackman', window)
        w = blackman(L);
    end
    
    w = w(:)/(norm(w)/sqrt(L)); %normalization
    Px = 0;
    K = 0; %number of windows

    for i=0:percov:N-L
        xi = x(i+1:i+L).*w;
        Xi = fft(xi,nfft);
        K = K+1;
        Px = Px + (1/L)*abs(Xi(1:length(Xi)/2+1)).^2;
    end
    Px = (1/K)*Px;
    
end

