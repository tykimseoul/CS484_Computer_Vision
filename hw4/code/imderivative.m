function I = imderivative(img,direction)
    It = imtranslate(img,-direction,'OutputView','full');
    Ip = padarray(img,flip(direction),0,'pre');
    I = It-Ip;
    I = I(1:size(I,1)-direction(2),1:size(I,2)-direction(1));
end