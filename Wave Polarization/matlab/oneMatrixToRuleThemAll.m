function M = oneMatrixToRuleThemAll(text)
% Type of device -> linear / circular / 4waveplate / 2waveplate
% Orientation angle (with respect to HORIZONTAL) -> In degrees
% Text : type+orientation
% Example: Linear polarizer at -30º -> Text = linear+-30
%                    Quarter waveplate fast axis Y -> 4waveplate+90
 %                    Right circular polarizer -> circularR

M = zeros(2,2);
separator = strfind(text,'+');
if isempty(separator)
    type =text(1:end-1);
    rotation = text(end);
else
    type = text(1:separator-1);
    angle = str2double(text(separator+1:end));
end

switch type
    case 'circular'
        switch rotation
            case 'R'
                M = 0.5*[1 1i; -1i 1];
            case 'L'
                M = 0.5*[1 -1i; 1i 1];
        end
    case 'linear'
        M = [cosd(angle)^2 cosd(angle)*sind(angle) ; cosd(angle)*sind(angle) sind(angle)^2];
    case '4waveplate'
        M = exp(-1i*pi/4)*[(cosd(angle)^2 +1i*sind(angle)^2) (1-1i)*sind(angle)*cosd(angle) ; (1-1i)*sind(angle)*cosd(angle)  (sind(angle)^2 +1i*cosd(angle)^2)];
    case '2waveplate'
        M = exp(-1i*pi/2)*[(cosd(angle)^2 -sind(angle)^2) 2*sind(angle)*cosd(angle) ; 2*sind(angle)*cosd(angle)  (sind(angle)^2 -cosd(angle)^2)];
    otherwise
        error('Please enter a valid expression')
end






end

