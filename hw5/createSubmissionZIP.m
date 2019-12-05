function createSubmissionZIP()
% CS484: Introduction to Computer Vision
% Acknowledgements:
% The original code is written by Prof. James Tompkin (james_tompkin@brown.edu).
% The second version is revised by Prof. Min H. Kim (minhkim@kaist.ac.kr).
%
% Students, hark!
% Run this script to create an appropriate zip file to submit.

% Files we wish to include
% - Everything in 'code'
% - writeup/writeup.pdf

% Some of you will end up in a pickle and run this
% from the wrong directory.
% Work out whether we're in the right directory
% to execute, e.g., one below 'code'
curdir = pwd;
[~,name,~] = fileparts( curdir );
foundMyself = strcmp( 'createSubmissionZIP.m', ls( 'createSubmissionZIP.m' ) );
if strcmp(name,'code') || strcmp(name,'data') || strcmp(name,'questions') || strcmp(name,'writeup')
    % Executing from the wrong directory,
    cd ..
elseif ~foundMyself
    % We haven't found this file, and
    % any other potential place is too complex for us to track
    disp( 'Are you sure you''re executing this script from the right place?' );
    disp( 'Please make sure the MATLAB ''Current Folder'' contains createSubimssionZIP.m');
end

% Compile the PDF if it doesn't exist
writeupFile = ['writeup' filesep 'writeup.pdf'];
if ~exist(writeupFile,'file')
    cd 'writeup'
    command1 = 'pdflatex writeup.tex';
    command2 = 'bibtex';
    % LaTeX assured compile sequence if bibtex is used
    system( command1 );
    system( command2 );
    system( command1 );
    system( command1 );
    cd ..
end

% Compile the PDF if it doesn't exist
writeupFile = ['questions' filesep '2019_Fall_Homework5_Questions.pdf'];
if ~exist(writeupFile,'file')
    cd 'questions'
    command1 = 'pdflatex 2019_Fall_Homework5_Questions.tex';
    command2 = 'bibtex';
    % LaTeX assured compile sequence if bibtex is used
    system( command1 );
    system( command2 );
    system( command1 );
    system( command1 );
    cd ..
end

zip( 'cs484submission.zip', {'code/*.m','writeup/writeup.pdf', 'questions/2019_Fall_Homework5_Questions.pdf'} );
disp( 'cs484submission.zip file is successfully generated.' );

end
