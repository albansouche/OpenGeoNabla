function  [N, dNdu] = shp_deriv_tetra(ipx, nnodel)

%%% BASED ON SHP_DERIV_TRIANGLE.m from MILAMIN

nip  = size(ipx,1);
N    = cell(nip,1);
dNdu = cell(nip,1);

for i=1:nip
    eta2 = ipx(i,1);
    eta3 = ipx(i,2);
    eta4 = ipx(i,3);
    eta1 = 1-eta2-eta3-eta4;
    
    switch nnodel
        
        case 4
            SHP   = [eta1; ...
                     eta2; ...
                     eta3; ...
                     eta4];
            DERIV = [-1 1 0 0; ...   
                     -1 0 1 0; ...
                     -1 0 0 1];        
                 
         case 10    
             
             SHP   = [eta1*(2*eta1-1); ...
                      eta2*(2*eta2-1); ...
                      eta3*(2*eta3-1); ...
                      eta4*(2*eta4-1); ...
                      4*eta4*eta3; ...
                      4*eta4*eta1; ...
                      4*eta2*eta1; ...
                      4*eta2*eta3; ...
                      4*eta2*eta4; ...
                      4*eta1*eta3];
             DERIV = [4*(eta2+eta3+eta4)-3  4*eta2-1  0  0       0                 -4*eta4  4-8*eta2-4*eta3-4*eta4  4*eta3  4*eta4                 -4*eta3;...   
                      4*(eta2+eta3+eta4)-3  0  4*eta3-1  0  4*eta4                 -4*eta4                 -4*eta2  4*eta2       0  4-4*eta2-8*eta3-4*eta4;...
                      4*(eta2+eta3+eta4)-3  0  0  4*eta4-1  4*eta3  4-4*eta2-4*eta3-8*eta4                 -4*eta2       0  4*eta2                 -4*eta3];     
                       
        otherwise
            error('Unknown element')

    end
	
    N{i}    = SHP;
    dNdu{i} = DERIV';
 
end
