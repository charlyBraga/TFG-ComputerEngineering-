function imgs = abreImgs()

    nomes='*.png';%nomes dos arquivos
    pasta = 'C:\Users\Charly\Google Drive\tfg\Rede\Letras\test\'; %Caminho dos arquivos
    aux = strcat(pasta,nomes); %aux <- nomes e caminho dos arquivos
    arqs = dir( aux ); %arqs <- recebe todas as imagens(img*.jpg) 
    n = size(arqs,1); %n  recebe o num total de caracteeres segmentados
    dim= [80 50];
    t1 = cputime;%inicia contagem de tempo

    [imgs, N] = pdi (pasta, arqs, n, dim);

    
   
    for i=1:N
       imshow(imgs{i})%imprime uma imagem da letra
       pause(0.2)% muda a cada meio segundo            
    end
    
%Tempo final   
t2 = cputime-t1;
tmim = t2/60;
fprintf('Tempo %d seg ou %d min\n', t2, tmim);

end

