
%GETDIVIDEDCHIRP Creates a chirp signal, divides it in section of size 
%sectionSize and returns a matrix with a row for every section.
%
%[ C ] = getDividedChirp( sectionSize )
% sectionsize = size of the portions of Chirp 
% C = matrix with rows containing the portion of chirp with length
% sectionsize
%
% Example:  C = getDividedChirp( 40 )
function [ C ] = getDividedChirp( sectionSize )


    Fs = 1000;
    Ts = 1/Fs;


    t = 0:1/Fs:4;
    chi = chirp(t,0,2,500);

    C = [];
    for i = 1:sectionSize:length(chi)-sectionSize
        y = chi(i:i+sectionSize-1);
        C = [C ; y];
    end

end

