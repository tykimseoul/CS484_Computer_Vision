%% HW3-b
% Calculate the fundamental matrix using the normalized eight-point
% algorithm.
function f = calculate_fundamental_matrix(pts1, pts2)
    clc;
    [pts1, T1]=normalize_points(pts1', 2);
    [pts2, T2]=normalize_points(pts2', 2);
    pts1=pts1';
    pts2=pts2';
    x=padarray(pts1',1,1,'post');
    xp=padarray(pts2,[0 1],1,'post');
    A=[];
    for i=1:size(x,2)
        A=cat(1,A,reshape((x(:,i).*xp(i,:))',[1 9]));
    end
    F=reshape(smallest_eigenvector(A'*A),[3 3])
    F=update_sv(F);
    
    f = T2'*F*T1
end

function v = smallest_eigenvector(A)
    [V,D] = eig(A);
    [d,ind] = sort(diag(D));
    Ds = D(ind,ind);
    Vs = V(:,ind);
    v=Vs(:,1);
end

function Fp = update_sv(F)
    [U,S,V]=svd(F);
    [~,idx]=sort(diag(S));
    S=S(idx, idx);
    V=V(:,idx);
    U=U(:,idx);
    S(1,1)=0;
    Fp=U*S*V';
end
