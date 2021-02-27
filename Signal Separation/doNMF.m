function B = doNMF(V,K,niter,Binit,Winit)


%% V = W*H

W = Binit;
H = Winit;

for i=1:niter
    
    W = W.*(V*H')./(W*(H*H'));

    H = H.*(W'*V)./((W'*W)*H);

end

B = W;

end