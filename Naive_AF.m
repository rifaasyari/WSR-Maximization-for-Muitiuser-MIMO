load('test1.mat')
ge=0;
for snrdb=-10:5:20
    snr=10^(snrdb/10);
    V=sqrt(P/4)*eye(4,4);
    n=sqrt(Pr/trace(H*V*V'*H'+(1/snr)*eye(4,4)));
    F=n*eye(4,4);
    V1=V(:,1:Mu);
    V2=V(:,Mu+1:2*Mu);
    A1=G1*F*H;
    A2=G2*F*H;
    Rz1=A1*(V2*V2'*A1')+(1/snr)*(G1*(F*F')*G1'+eye(2,2));
    Rz2=A2*(V1*V1'*A2')+(1/snr)*(G2*(F*F')*G2'+eye(2,2));
    R1=(1/2)*log2(abs(det(eye(2,2)+V1'*A1'*(Rz1^-1)*A1*V1)));
    R2=(1/2)*log2(abs(det(eye(2,2)+V2'*A2'*(Rz2^-1)*A2*V2)));
    ge=ge+1;
    R(ge)=w1*R1+w2*R2;
end
i=-10:5:20;
save('Naive_AF.mat')
plot(i,R,'-ro')
