clear all
clc
A = ["Hello"; "Rabbits"];
B = ["World"];
%B = [A,B];

numOfWords = 10;

markovMap = containers.Map;
markovMap("keyOne") = [];
markovMap("keyOne") = [markovMap("keyOne");A];
markovMap("keyOne") = [markovMap("keyOne");B];
markovMap("keyOne")


fid = fopen('obama.txt');
data = textscan(fid, '%s');
fclose(fid);
stringData = string(data{:});
stringData;

for i = 1:length(stringData) - 1
   word = stringData(i);
   nextWord = stringData(i+1);
   
   if(isKey(markovMap,word))
       markovMap(word) = [markovMap(word); nextWord];
   else
       markovMap(word) = [nextWord];
   end
   
end



randomNum = randi(length(stringData)); %random number bewtween one ans string length
firstWord = stringData(randomNum);
outputString = firstWord;


for i = 1:numOfWords
    x = randi(length(markovMap(firstWord)));
    valArray = markovMap(firstWord);
    firstWord = valArray(x);
    outputString = strcat(outputString, " ");
    outputString = strcat(outputString, firstWord);
end

outputString
