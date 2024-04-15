function  [imgs, N]= pdi( pasta, arqs, n , dim)

    for i=1:n       
        imgdir = strcat(pasta,arqs(i).name); %  
        img1=imread(imgdir);%ler entrada        
        img2 = rgb2gray(img1);
        limiar = 100;
        img3 = double(img2)/limiar;
        img4 = img3.^2;
        img5 = uint8(img4*limiar);     
        imgs{i} = img5;       
    end
    
    %Ruídos:
    N=size(imgs,2);
    for i=1:n %Pecorre apenas as imagens originais
        imgs{i+N}   = imnoise(imgs{i},'gaussian',0,0.01); %gaussiano
    end
    N=size(imgs,2);
    for i=1:n
        imgs{i+N} = imnoise(imgs{i},'gaussian',0,0.02); 
    end
    
    
    N=size(imgs,2);
    for i=1:n
       imgs{i+N} = imnoise(imgs{i},'poisson'); %poisson 
    end
    N=size(imgs,2);
    for i=1:n
       imgs{i+N} = imnoise(imgs{i},'salt & pepper',0.02);
    end
    N=size(imgs,2);
    for i=1:n
       imgs{i+N} = imnoise(imgs{i},'salt & pepper',0.02);
    end 
    N=size(imgs,2);
    for i=1:n
       imgs{i+N} = imnoise(imgs{i},'salt & pepper',0.05);
    end  
    
    
    N=size(imgs,2);
    for i=1:n
       imgs{i+N} = imnoise(imgs{i},'speckle',0.02);%speckle
    end  
    N=size(imgs,2);
    for i=1:n
        imgs{i+N} = imnoise(imgs{i},'speckle',0.05); 
    end  
    
    %Filtro mediana:
    N=size(imgs,2);
    for i=1:N %Percorre todas a imagens até modificada até aqui.
         imgs{i+N}  = medfilt2(imgs{i});  
    end
       
    
    %Filtro func ordfilt2 (Afina imagem):
     N=size(imgs,2);
     for i=1:N
         imgs{i+N} = ordfilt2(imgs{i},1,true(3));
     end
        
     %Filtro func ordfilt2 (Engrossa imagem):
     N=size(imgs,2);
     for i=1:N
         imgs{i+N} = ordfilt2(imgs{i},9,true(3)); 
     end
      
    
     %Filtro motion (Desfoca imagem):   
     N=size(imgs,2);
     for i=1:N
         imgs{i+N} = imfilter(imgs{i}, fspecial('motion', 5, 5)); 
     end
     
 
     %Filtro Wiener (Remove ruído):
     N=size(imgs,2);
     for i=1:N
         imgs{i+N}  = wiener2(imgs{i});            
     end
         
     
     %Rotaciona para direita:
     N=size(imgs,2);
     for i=1:n %i vai de 1241 à 2480   
        imgs{i+N}   = ~imrotate(~imgs{i},-10,'crop');%  rotaciona 
     end
    
     %Rotaciona para esquerda:
     N=size(imgs,2);
     for i=1:n %i vai de 1241 à 2480    
         img{i+N} = ~imrotate(~imgs{i}, 10,'crop');%  rotaciona
     end
    
     %Aumenta brilho: 
     N=size(imgs,2);
     for i=1:n
         imgs{i+N} = imgs{i}+30; 
     end
        
     N=size(imgs,2);
     for i=1:N
         imgs{i} = imresize(imgs{i},dim);%Redimensiona imagem (Deve vir antes da binarização)      
        % imgs{i} = imgs{i}>80; %Binariza (Deve vir depois de imresize()   
     end
    

end

