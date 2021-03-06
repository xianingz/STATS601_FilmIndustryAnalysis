#draw ellipse error plot

library(plotrix)
library(RColorBrewer)
coln <- unique(unlist(strsplit(coln,"_")))
convertomat <- function(col, coln){
  mat <- matrix(NA, nrow=length(coln), ncol=length(coln))
  rownames(mat) <- coln
  colnames(mat) <- coln
  for(i in coln){
    for(j in coln){
      if(i==j){
        next
      }else{
        if(paste0(i,"_",j) %in% names(col)){
          mat[i,j] <- col[paste0(i,"_",j)]
        }else{
          mat[i,j] <- col[paste0(j,"_",i)]
        }
      }
    }
  }
  return(mat)
}

plotheat <- function(mat1, mat2, mat3, cols, ns=NULL, tit){
  len <- dim(mat1)[1]
  colfunc <- colorRampPalette(cols)
  cols <- colfunc(100)
  plot(0, xaxt = 'n', yaxt = 'n', bty = 'n', pch = '', ylab = '', xlab = '', xlim=c(-1.5,len+1), ylim=c(-1,len+0.5), main=tit, font.main=2, cex.main=3)
  for(i in c(1:len)){
    for(j in c(1:len)){
      draw.ellipse(i,j,mat2[i,j]/2*0.9, mat3[i,j]/2*0.9, col = cols[round(mat1[i,j]*100)])
    }
  }
  if(is.null(ns)){
    ns <- rownames(mat1)
  }
  for(i in c(1:len)){
    segments(i+0.5,0.5,i+0.5,len+0.5,lty="dotted")
    segments(0.5,i+0.5,len+0.5,i+0.5,lty="dotted")
    text(i, 0.3, ns[i], pos=2, srt=45, font = 2, cex = 2)
    text(0.5, i, ns[i], pos=2, font = 2, cex=2)
  }
  for(i in c(1:100)){
    rect(len+1.1,len/4+0.05*(i-1), len+1.5, len/4+0.05*i,col = cols[i], border = cols[i])
  }
  text(len+1.25, len/4+0.05*1, "0", pos = 2, cex=2)
  text(len+1.25, len/4+0.05*50, "0.5", pos = 2, cex=2)
  text(len+1.25, len/4+0.05*100, "1", pos = 2, cex=2)
}

mat1 <- convertomat(comp.res[,1],coln)
mat2 <- convertomat(comp.res[,2],coln)
mat3 <- convertomat(comp.res[,3],coln)
pdf("E:/STATS601/project/1.pdf", width = 8, height = 8)
ns = c("Netflix","Universal","SONY","Disney","FOX","Columbia","HBO","Warner Bros.","Paramount")
plotheat(mat1,mat2,mat3, cols = c("#236fce","#f2f2f2","#dc392e"), ns=ns)
dev.off()

mat1 <- convertomat(comp.res[,1],coln)
mat2 <- convertomat(comp.res[,2],coln)
mat3 <- convertomat(comp.res[,3],coln)
mat4 <- convertomat(comp.res[,4],coln)
mat5 <- convertomat(comp.res[,5],coln)
mat6 <- convertomat(comp.res[,6],coln)
mat7 <- convertomat(comp.res[,7],coln)
mat8 <- convertomat(comp.res[,8],coln)
mat9 <- convertomat(comp.res[,9],coln)
pdf("E:/STATS601/project/svmheatmap.pdf", width = 24, height = 8)
par(mfrow=c(1,3),
    oma = c(5,4,1,0) + 0.5,
    mar = c(1,1,2,2) + 0.5)
ns = c("Netflix","Universal","SONY","Disney","FOX","Columbia","HBO","Warner Bros.","Paramount")
plotheat(mat1,mat2,mat3, cols = c("#236fce","#f2f2f2","#dc392e"), ns=ns, tit = "Imbalanced Data")
plotheat(mat4,mat5,mat6, cols = c("#236fce","#f2f2f2","#dc392e"), ns=ns, tit = "Subsampled Data")
plotheat(mat7,mat8,mat9, cols = c("#236fce","#f2f2f2","#dc392e"), ns=ns, tit = "Oversampled Data")
dev.off()

