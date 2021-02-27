function [speech_recv, music_recv] = separate_signals(mixed_spec,Bmusic,Bspeech, niter)

V   = abs(mixed_spec);
phi = angle(mixed_spec); %% -> phase of the mixed signal

Ws = Bspeech;
Wm = Bmusic;

%concatenate the basis
W = [Ws,Wm];

Hs = rand(200,977);
Hm = rand(200,977);

%concatenate the weights
H = [Hs;Hm];


%%calculate new weights
for i=1:niter

      H = H.*(W'*(V)./((W'*W)*H));

end

for i=1:size(Ws,2)*2
   
       xmaghat = W(:,i)*H(i,:);
%        xmaghat = [xmaghat;conj(xmaghat(end-1:-1:2,:))];

       
       xhat = xmaghat .* exp(1i*phi);
       xre(:,i)  = real(stft(xhat,2048,256,0,hann(2048)));
end

speech_recv =  xre(:,1:200);
music_recv  =  xre(:,200:end);

end