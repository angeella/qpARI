# 
# library(pARI)
# m = 50
# n = 20
# B = 1000
# 
# X <- simulateData(pi0 = 0.9, m=m, n=n, rho = 0, power = 0.8)
# Test <- oneSample(X = t(X))$Test
# length(Test)
# qT <- signFlipQuantile(t(data), B = B) 
# Obs_Quantile <- stats::quantile(Test, probs = seq(from=1/(B),to=1,by = 1/(B)))
# QT <- cbind(Obs_Quantile, qT)
# dim(QT)
# pv <-pvQuantile(QT = abs(QT), Test = abs(Test), B = B)
# length(pv)
# summary(pv)
# library(matrixStats)
# pv1 <- rowRanks(-abs(QT)) / (B)
# summary(pv1[,1])
# summary(pv)
# 
# pvalues[1:5] <- 1/1000
# 
# out <- ARIperm::lambdaOptQuantile(B = B, pvalues = pv ,alpha = 0.05, family = "simes")
# 
# 
# out <- ARIpermutation::signTest(t(X), rand = T)
# pv <- out$pv
# plot(sort(pv))
# 
# dataF <- data.frame(index = c(1:m), pv = pv)
# jump <- sum(pv == min(pv))
# 
# vec = c(jump+1, seq(10,50,10))
# 
# colvec = ifelse(vec==jump+1, "red", "black")
# 
# ggplot(dataF, aes(x=index, y=sort(pv))) + 
#   geom_step() + ylab(expression(p[(i)])) + xlab(expression(i)) +
#   theme_classic() +   geom_vline(xintercept = jump+1, linetype="dotted", size = 1, col = "red") +
#   scale_x_discrete(labels =  c(vec), breaks = c(vec), limits = vec) + ylim(0,1) +
#   theme(axis.text.x=element_text(colour = colvec))
# 
#   
#   
# 
