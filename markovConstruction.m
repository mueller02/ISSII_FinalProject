clear all
clc

b = containers.Map;
b = generation(b, 'The Hunger Games.txt')
b = generation(b, 'Catching Fire.txt')
b = generation(b, 'MockingJay.txt')
%b = generation(b, 'dickens-corpus.txt')
b = generation(b, '(3.2) Mockingjay.txt')
%b = generation(b, 'obama.txt')
%b = generation(b, 'mobydick.txt')

analytics(b)

function a = generation(markovMap, filename)

numOfWords = 1000;

%markovMap = containers.Map;

fid = fopen(filename);
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
a = markovMap
end

function b = analytics(markovMap)
    mostCommonWords = strings(1,100);
    mostCommonLengths = zeros(1,100);
    for i = keys(markovMap)
        if length(markovMap(i{1})) >= min(mostCommonLengths)
            indices = find(mostCommonLengths==min(mostCommonLengths));
            mostCommonWords(indices(1)) = i;
            mostCommonLengths(indices(1)) = length(markovMap(i{1}));
        end
    end
    mostCommonWords
    mostCommonLengths
   
    for i = 1:length(mostCommonWords)
        
        index = find(mostCommonLengths==max(mostCommonLengths));
        
        %Place max in ordered array
        mostCommonLengthsOrdered(i) = mostCommonLengths(index(1));
        mostCommonWordsOrdered(i) = mostCommonWords(index(1));
        
        %Change the the most common length to -1 for thos indices in the
        %old array
        mostCommonLengths(index(1)) = -1;
        
    
    end
    
    mostCommonWordsOrdered = categorical(mostCommonWordsOrdered);
    mostCommonWordsOrdered = reordercats(mostCommonWordsOrdered,string(mostCommonWordsOrdered));
    bar(mostCommonWordsOrdered, mostCommonLengthsOrdered)
end