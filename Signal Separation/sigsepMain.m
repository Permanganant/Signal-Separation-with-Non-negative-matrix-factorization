%{
This is a template main script for signal separation problem 

%}

musicw = audioread('musicf1.wav');
speechw = audioread('speechf1.wav');
mixedw = audioread('mixedf1.wav');


% ADD CODE TO COMPUTE MAG. SPECTOROGRAMS OF MUSIC AND SPEECH
 sMusic 	 = stft(musicw',2048,256,0,hann(2048));
 sMusicMag   = abs(sMusic);
 sMusicPhase = sMusic./(sMusicMag+eps);
 
 sSpeech      = stft(speechw',2048,256,0,hann(2048));
 sSpeechMag   = abs(sSpeech);
 sSpeechPhase = sSpeech./(sSpeechMag+eps);

% ADD CODE TO CPMPUTE MAG. SPECTROGRAM AND PHASE OF MIXED

sMixed        = stft(mixedw',2048,256,0,hann(2048));
sMixedMag     = abs(sMixed);
sMixedPhase   = sMixed./(sMixedMag+eps);


%
K = 200;     %number of bases.
niter = 250; %number of iterations.

Bminit = load('Bminit.mat').Bm;
Wminit = load('Wminit.mat').Wm;

Bsinit = load('Bsinit.mat').Bs;
Wsinit = load('Wsinit.mat').Ws;


Bm = doNMF(sMusicMag,K,niter,Bminit,Wminit);

Bs = doNMF(sSpeechMag,K,niter,Bsinit,Wsinit);

% ADD CODE TO SEPARATE SIGNALS
% INITIALIZE WEIGHTS INSIDE separate_signals using rand() function
[speech_recv, music_recv] = separate_signals(sMixed,Bm,Bs, niter);



% ADD CODE TO MULTIPLY BY PHASE AND RECONSTRUCT TIME DOMAIN SIGNAL

% WRITE TIME DOMAIN SPEECH AND MUSIC USING audiowrite with 16000 sampling
% frequency
speech_recv = sum(speech_recv,2); %sum all bases
audiowrite('speech_recv.wav',speech_recv,16e3);

music_recv = sum(music_recv,2);   %%sum all bases
audiowrite('music_recv.wav',music_recv,16e3);



