
library(ggplot2)
library(ggrepel)
library(readstata13)

datObj = read.dta13('/zdsk/Manuscripts/Baydoun/UK-BioBank/2023-01-06--04--BrainVol-CVD-Inf/2023-01-06/Outputdata_overall_F_INFECTIONPARMS.dta')

datObj$EffSize   = factor((datObj$estimate > -0.69) + (datObj$estimate > 0.69), 0:2, c('LnOR < .69', '0.69 = LnOR = 0.69', 'LnOR > 0.69'))

datObj$label      = sub('_0_0_yn', '', datObj$parm)
datObj$label      = sub('ts_',     '', datObj$label)

Volcano = function() ggplot(data=datObj, aes(x=estimate, y=-log10(p), label=label, col=EffSize)) +
  geom_point(shape=20) +
  geom_text_repel(size=3) +
  labs(x='Ln(Odds ratio)') +
  labs(col='Effect size') +
  theme_minimal() +
  theme(legend.position = c(0.5, 0.8)) +
  scale_color_manual(values=c("blue", "black", "red")) +
  geom_hline(yintercept=-log10(0.05/76), col="gray", linetype=2)

pdf('/zdsk/Manuscripts/Baydoun/UK-BioBank/2023-01-06--04--BrainVol-CVD-Inf/2023-01-06/2023-01-06.pdf')
Volcano()
jnk = dev.off()

png('/zdsk/Manuscripts/Baydoun/UK-BioBank/2023-01-06--04--BrainVol-CVD-Inf/2023-01-06/2023-01-06.png')
Volcano()
jnk = dev.off()
