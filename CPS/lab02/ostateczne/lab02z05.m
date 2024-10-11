clear; clc;

filename = 'DAB_real_2.048MHz_IQ_float.dat';
fileID = fopen(filename, 'r');
if fileID == -1
    error('File not found');
end
dabSignal = fread(fileID, [2, inf], 'float').';
fclose(fileID);
dabSignal = dabSignal(:, 1) + 1j * dabSignal(:, 2);
[PhaseRefSymb, sigPhaseRefSymb] = PhaseRefSymbGen(1);

[corr, lags] = xcorr(dabSignal, sigPhaseRefSymb);
[~, maxIndex] = max(abs(corr));
offset = lags(maxIndex);

%bez 0
dataStartIndex = offset + length(sigPhaseRefSymb) + 1;
dataEndIndex = dataStartIndex + 76 * 2552 - 1; % 76 bloków po 2552 próbki

if dataEndIndex > length(dabSignal)
    warning('The calculated end index exceeds the length of the signal. Adjusting to signal length.');
    dataEndIndex = length(dabSignal);
end

dabData = dabSignal(dataStartIndex:dataEndIndex);
%przetwarzanie blokow danych
for blockNum = 1:76
    blockStart = (blockNum - 1) * 2552 + 1;
    blockEnd = blockStart + 2551;
    currentBlock = dabData(blockStart:blockEnd);
    
    %cykliczny prefiks
    signalWithoutPrefix = currentBlock(505:end);
    
    %FFT sygnału
    signalDFT = fft(signalWithoutPrefix);
end
