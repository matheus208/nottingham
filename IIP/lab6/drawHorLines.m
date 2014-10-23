function y=drawHorLines(amountLines, image)
dimension = size(image);
%width = dimension(1);
height = dimension(2);

y = image;
space = height/amountLines;

for k=1:amountLines
    y(round(space*k),:) = 0;
end