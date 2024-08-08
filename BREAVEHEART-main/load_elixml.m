%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BRAVEHEART - Open source software for electrocardiographic and vectorcardiographic analysis
% load_musexml.m -- Load GE MUSE XML format ECGs
% Copyright 2016-2023 Hans F. Stabenau and Jonathan W. Waks
% 
% Source code/executables: https://github.com/BIVectors/BRAVEHEART
% Contact: braveheart.ecg@gmail.com
% 
% BRAVEHEART is free software: you can redistribute it and/or modify it under the terms of the GNU 
% General Public License as published by the Free Software Foundation, either version 3 of the License, 
% or (at your option) any later version.
%
% BRAVEHEART is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
% See the GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License along with this program. 
% If not, see <https://www.gnu.org/licenses/>.
%
% This software is for research purposes only and is not intended to diagnose or treat any disease.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [hz, I, II, V1, V2, V3, V4, V5, V6] = load_elixml(filename, rh_or_med_flag)
% ELI 380 Ecg Cart (formerly known as Mortara) XML format
% Need to construct III, avL, avR, avF using leads I and II (see ECG12.m)

if nargin < 2 || strcmpi(rh_or_med_flag,'rhythm')
	waveformstring='rhythm';
elseif strcmpi(rh_or_med_flag,'median')
	waveformstring='median';
else
	error('load_musexml: expected nothing, "rhythm", or "median" for rh_or_med_flag, got %s', rh_or_med_flag)
end


file = xml2struct(filename);
file = file.EliEcg;


decodedTexts = cell(1, 8);



hz = 500;
lowcut = 150; % Low cutoff frequency in Hz
% highcut = 5; % High cutoff frequency in Hz

% Design a band-pass filter
d = designfilt('lowpassfir', 'SampleRate', hz, 'FilterOrder', 20,'CutoffFrequency', lowcut);

for i = 1:8
    extractedText = file.Ecg.Waveform.Lead{i}.Rhythm.Text;

    % Decode the extracted base64 text
    sig = matlab.net.base64decode(extractedText);

    if mod(numel(sig), 2) ~= 0
    % If 'sig' has an odd number of elements, pad it with a zero at the end
    % This assumes that appending a zero will not significantly affect your data
        sig(end+1) = 0; % Append a 0 to make the number of elements even
    end

    sig = double(typecast(sig, 'uint16'));
    decodedTexts{i} = sig / 1000;

end


I = decodedTexts{1};
II = decodedTexts{2};
V1 = decodedTexts{3};
V2 = decodedTexts{4};
V3 = decodedTexts{5};
V4 = decodedTexts{6};
V5 = decodedTexts{7};
V6 = decodedTexts{8};

signal_lengths = [length(I), length(II), length(V1), length(V2), length(V3), length(V4), length(V5), length(V6)];

% Find the minimum length among the signals
min_length = min(signal_lengths);

% Truncate signals to the minimum length if necessary
I = I(1:min_length);
II = II(1:min_length);
V1 = V1(1:min_length);
V2 = V2(1:min_length);
V3 = V3(1:min_length);
V4 = V4(1:min_length);
V5 = V5(1:min_length);
V6 = V6(1:min_length);











% doc = xmlread(filename);
% 
% baseline = 0;
% 
% % Define lead names for easy reference
% leadNames = {'I', 'II', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
% 
% % TO-DO: Ensure the XML leads match expected names
% % for i = 1:length(leadNames)
% %     assert(strcmp(xml.EliEcg.Ecg.Waveform.Lead{i}.Attributes.Name, leadNames{i}), ...
% %            sprintf('%s corresponds to %%s right now; modify indexing', leadNames{i}), ...
% %            xml.EliEcg.Ecg.Waveform.Lead{i}.Attributes.Name);
% % end
% 
% % Determine waveform type and extract relevant data
% ecgWaveform = doc.getDocumentElement.getElementsByTagName('Ecg').item(0).getElementsByTagName('Waveform').item(0);
% attributes = ecgWaveform.getAttributes;
% 
% % Determine waveform type and extract relevant data
% if strcmp(waveformstring, 'median')
%     hz = str2double(attributes.getNamedItem('MedRate').getValue);
%     % gain = str2double(attributes.getNamedItem('MedResolution').getValue);
%     % Assuming no offset adjustment needed for median, otherwise retrieve as done for rhythm
% else
%     hz = str2double(attributes.getNamedItem('RhyRate').getValue);
%     % gain = str2double(attributes.getNamedItem('RhyResolution').getValue);
%     % Example for rhythm, assuming there's a 'StartTime' attribute to check
%     % This part might need adjustment based on the actual XML structure and needs
% end
% 
% assert(hz==500, "hz is %d, which is different from batch specification (500) - will influence signal subsampling", hz);
% 
% for i = 1:length(leadNames)
%     lead = leadNames{i};
% 
%     % Dynamically access the waveform data for the current lead
%     % Here's where you fetch the waveform text data specifically for each lead within the loop
%     if strcmp(waveformstring, 'median')
%         waveformElement = ecgWaveform.getElementsByTagName('Lead').item(i-1).getElementsByTagName('Median').item(0);
%     else
%         waveformElement = ecgWaveform.getElementsByTagName('Lead').item(i-1).getElementsByTagName('Rhythm').item(0);
%     end
% 
%     if ~isempty(waveformElement) % Make sure we have a waveform element to work with
%         waveformText = char(waveformElement.getTextContent);
% 
%         % Decode the Base64-encoded waveform text for the current lead
%         decodedData = matlab.net.base64decode(waveformText);
%         decodedData = decodedData(1:min(size(decodedData, 2), 5000));
% 
%         if mod(numel(decodedData), 2) ~= 0
%             % Append a zero byte if the total number of bytes is odd
%             decodedData = decodedData(1: end-1); % Makes length of decodedData even
%         end
% 
%         intSignal = double(typecast(decodedData, 'uint16')); % Convert binary data to integers
% 
%         % Adjust the signal with baseline and scale according to gain
%         % Assuming baseline and gain have been correctly identified previously
%         adjustedSignal = (intSignal + baseline) / 1000;
% 
%         % Store the processed signal in the struct under the current lead name
%         signals.(lead) = adjustedSignal;
%     else
%         warning('Missing waveform data for lead %s', lead);
%         signals.(lead) = []; % Handle missing data appropriately
%     end
% end
% 
% % Calculate the minimum length among the signals stored in the 'signals' struct
% signal_lengths = [length(signals.I), length(signals.II), length(signals.V1), length(signals.V2), length(signals.V3), length(signals.V4), length(signals.V5), length(signals.V6)];
% min_length = min(signal_lengths);
% 
% % Truncate signals to the minimum length if necessary
% I = signals.I(1:min_length);
% II = signals.II(1:min_length);
% V1 = signals.V1(1:min_length);
% V2 = signals.V2(1:min_length);
% V3 = signals.V3(1:min_length);
% V4 = signals.V4(1:min_length);
% V5 = signals.V5(1:min_length);
% V6 = signals.V6(1:min_length);

end