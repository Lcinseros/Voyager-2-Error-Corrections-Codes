image = uint8(imread('earth.png')); % Loads the image and stores its dimensions
imageDim = size(image);
snr = 11; % Sets the snr value (dB) for our simulated AWGN
itterations = 1;

bitstream = reshape(de2bi(image, 'left-msb'), 1, []);
for snrVal = 10:snr
    %get the rs encoded bitstream
    convolutionalCode = convolutionalEncoder(bitstream,snrVal);
    noisyBitstream = addNoise(bitstream,snrVal);
    
    snrUnencodeData(snrVal) = sum(abs(bitstream-uint8(noisyBitstream))) / length(bitstream);
    snrDecodeData(snrVal) = sum(abs(bitstream-uint8(convolutionalCode))) / length(bitstream);
    snrData(snrVal) = snrVal;
end

clf;
lineseries = semilogy(snrData, snrUnencodeData, 'o-');
hold on;
lineseries = semilogy(snrData, snrDecodeData, 'o-');
grid on;

