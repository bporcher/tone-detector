clear all;
close all;

%sinal de entrada
[data freq] = wavread('teste6.wav');

%subdivide o sinal de entrada em menos amostras
sample = 0.03; %fator de amostragem
t = linspace(0,sample,sample*freq+1);
width = length(t);
height = floor(length(data)/width);
dataS = reshape(data(1:(height*width)),width,height); %amostra o sinal de entrada

LowF = [697 770 852 941]; %linhas - Frequencias baixas
HighF = [1209 1336 1477 1633]; %colunas - Frequencias altas

%Separação do sinal nas frequências de interesse
%FREQUÊNCIAS BAIXAS
w = exp(1j*2*pi*LowF'*t);
dadosLow = abs(w*dataS)/width;

%FREQUÊNCIAS ALTAS
w = exp(1j*2*pi*HighF'*t);
dadosHigh = abs(w*dataS)/width;

%ignora o ruido menos intenso (threshold) e converte os dados
%para a escala de 1 a 4 (cada linha das matrizes de dados representa uma frequencia)
%que servirá de indice mais adiante
scale = 1:4;
threshold = 0.07;
low = scale*(dadosLow>threshold);
high = scale*(dadosHigh>threshold);

%Procura por diferenças entre zeros e valores positivos 
%e amostra o indice de cada numero digitado
indice = find(diff([0 low])>0);

%Os vetores "linha" e "coluna" vão armazenar a posição
%do caractere na matriz "teclas"
linha = low(indice);
coluna = high(indice);

teclas = ['123A'; '456B'; '789C'; '*0#D'];

qtd = length(linha); %numero de teclas pressionadas

%decodifica as teclas pressionadas
for x=1:qtd
    tons(x) = teclas(linha(x),coluna(x));
end

disp('Numeros digitados: ');
disp(tons);



