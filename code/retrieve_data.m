function [ up, Fs] = retrieve_data( )


% PARAMETRI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sorgente file acquisizione fisso
file_name_fixed = 'fiovest_20180523_raw_up.bin';
%file_name_fixed = 'fiovest_20180523_raw_dw.bin';
%fiovest_20180523_raw_dw

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data Conversion Parameters
VMAX=1;
NBIT_SAMPLE=8;
OFFSET=0.5;%Il segnale ? offsettato di 500mV


% LETTURA FILE & ESTRAZIONE INFO

filename = file_name_fixed;

fileID = fopen(strcat('sample', '/', filename), 'rb');

%%% Header Size
%Header - Stringa
head_size_byte_cell_head = textscan(fileID,'%s', 1 ,'Delimiter',':');
%Dato - Intero
head_size_byte_cell_data = textscan(fileID,'%d', 1 ,'Delimiter',',');

%Header - Stringa
Data_Size_Acq_Block_Byte_head = textscan(fileID,'%s', 1 ,'Delimiter',':');
%Dato - Intero
Data_Size_Acq_Block_Byte_data = textscan(fileID,'%d', 1 ,'Delimiter',',');

%Header - Stringa
Num_samples_Acq_Block_head = textscan(fileID,'%s', 1 ,'Delimiter',':');
%Dato - Intero
Num_samples_Acq_Block_data = textscan(fileID,'%d', 1 ,'Delimiter',',');

%Header - Stringa
Freq_sample_Hz_head = textscan(fileID,'%s', 1 ,'Delimiter',':');
%Dato - Intero
Freq_sample_Hz_data = textscan(fileID,'%d', 1 ,'Delimiter',',');


%Header - Stringa
Data_Fatt_Mult_head = textscan(fileID,'%s', 1 ,'Delimiter',':');
%Dato - Intero
Data_Fatt_Mult_data = textscan(fileID,'%d', 1 ,'Delimiter',',');

%%% Pitch
%Header - Stringa
Data_Format_head = textscan(fileID,'%s', 1 ,'Delimiter',':');
%Dato - Float
Data_Format_data = textscan(fileID,'%s', 1 ,'Delimiter',',');

%Header - Stringa
Num_Acq_Blocks_head = textscan(fileID,'%s', 1 ,'Delimiter',':');
%Dato - Intero
Num_Acq_Blocks_data = textscan(fileID,'%d', 1 ,'Delimiter',',');
%Dimensione in Byte dell'header


head_size_byte = cast(head_size_byte_cell_data{1},'double');
%Dimensione in Byte dei dati
data_size_byte = 1;

%Vado all'inizio del file
frewind(fileID);
%Mi sposto di un offset in byte, pari alla dimensione dell'header
fseek(fileID, head_size_byte, 0);
% Lettura Dati(8 bit: 1 bit ramp up + 7 bit sample xadc)
raw_data = fread(fileID, '*ubit8');

fclose(fileID);
%++++++++++++++++++++++++++++++++++++++
%Elaboration of informations
%++++++++++++++++++++++++++++++++++++++

Fs = cast(Freq_sample_Hz_data{1},'double');
Ts = 1/Fs; % Sampling frequency

%Lunghezza Vettore Dati
[L_raw, ~] = size(raw_data);

%Tempo totale di acquisizione
total_time_window = L_raw * Ts;

data=raw_data;
%Assegnamento dummy per chiarezza
L_data = L_raw;

% TIME DOMAIN PROCESS



% Time vector
t_data = (0:L_data-1)*Ts;
t_data = t_data';

%Data Conversion
Resolution = VMAX / 2^NBIT_SAMPLE;
data_conv = Resolution * double(data);


%Offset Canc Calc
offset_polyfit = polyfit(t_data,data_conv,1);
offset_polyval = polyval(offset_polyfit,t_data);
offset_calc = mean(offset_polyval);

data_conv = detrend(data_conv);


% RAMP DETECTOR




num_ramps_per_acquisition = cast(Num_Acq_Blocks_data{1},'double');


%Numero di zone up or down (rese uguali)
num_up_down_ramps = num_ramps_per_acquisition;
%fprintf('Number of Ramps UP or DOWN: %d\n',num_up_down_ramps);

%Inizializzazione matrici contenenti rampe up e down
up_ramps = zeros(num_up_down_ramps, 580);
%down_ramps = zeros(num_up_down_ramps, num_samples_between_ramp_trig);

%Composizione matrici up e down ramp
%Inizializzo indici riga e colonna
index_up_row = 1;
index_up_col = 1;
%index_dow_row = 1;
%index_dow_col = 1;

num_samples_between_ramp_trig=580; %%%%%%%%%%% vedi email bisio %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for index_vector = 1:1:L_data
    %Fino al penultimo campione
    if(index_vector < L_data)
            up_ramps(index_up_row,index_up_col) = data_conv(index_vector);
            %Se il campione successivo ? ancora ramp up
            %Avanzo di colonna e rimango sulla stessa riga
            if(index_up_col <num_samples_between_ramp_trig)
                index_up_col = index_up_col + 1;
                %Se il campione successivo diventa ramp down
                %Resetto la colonna e avanzo di riga
            else
                index_up_col = 1;
                index_up_row = index_up_row + 1;
            end;
    end;
end;
    
%Eliminazione prima e ultima rampa up/down perch? possono essere incomplete
up = up_ramps(2:num_up_down_ramps-1,1:num_samples_between_ramp_trig);

end

