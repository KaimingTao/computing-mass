% Star motion
% Determine a star's motion by calculating the redshift in its spectrum, using the Hydrogen-alpha () line.

% Load data and define measurement parameters
load starData

nObs = size(spectra,1);
lambdaStart = 630.02;
lambdaDelta = 0.14;

% Create vector of wavelengths.
lambdaEnd = lambdaStart + (nObs - 1) * lambdaDelta;
lambda = (lambdaStart:lambdaDelta:lambdaEnd)';

% Extract spectrum of HD94028
% Extract the appropriate column of spectra
s = spectra(:, 6);

% Plot the spectrum
loglog(lambda, s, '.-');
xlabel('Wavelength')
ylabel('Intensity')

% Find the wavelength of the Hydrogen-alpha line
% Find the minimum spectral value and corresponding wavelength
[sHa idx] = min(s);
lambdaHa = lambda(idx);

% Add Hydrogen-alpha to spectrum plot
hold on;
x = lambdaHa;
y = sHa;
plot(x, y, 'rs', 'MarkerSize', 8);

% Determine the redshift & stellar motion
%redshift factor
z = (lambdaHa / 656.28) - 1;
speed = z * 299792.458;