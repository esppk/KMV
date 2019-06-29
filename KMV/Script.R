#����nleqslv
library(nleqslv);
#�����޷�������
print("�޷�������:")
r <- 0.0225;
print(paste("r=", r))
#���빫˾ծ������
print("��˾ծ������:")
T <- 1;
print(paste("T=", T))
#����������ծ����������ծ
print("������ծ����������ծ:")
SD <- 1e8;
LD <- 0.5 * 1e8;
print(paste("SD=", SD))
print(paste("LD=", LD))
#����ΥԼ��
print("ΥԼ��:")
D0 <- SD + 0.5 * LD;
print(paste("D0=", D0))
#����fair value�޸�ΥԼ��
D <- D0;
#�����Ȩ������
print("��Ȩ������:")
PriceTheta <- 0.2893;
print(paste("PriceTheta=", PriceTheta))
#�²���
EquityTheta <- PriceTheta * sqrt(12);
print(paste("EquityTheta=", EquityTheta))
#�����Ȩ��ֵ
print("��Ȩ��ֵ:")
E <- 214512867;
print(paste("E=", E))
if (FALSE) {
    "KMVģ�ͱ������"
}
cat('\n')

print("KMVģ�ͱ������")

x0 <- c(1, 1);
KMV_fun <- function(x) {
    y <- numeric(2);
    d1 <- (log(x[1] * E / D) + (r + 0.5 * x[2] ^ 2) * T) / (x[2] * sqrt(T));
    d2 <- d1 - x[2] * sqrt(T);
    y[1] <- x[1] * pnorm(d1) - D * exp(-r * T) * pnorm(d2) / E - 1;
    y[2] <- pnorm(d1) * x[1] * x[2] - EquityTheta;
    y
}
#���KMV
z <- nleqslv(x0, KMV_fun, method = "Newton")
print(paste("z=", z))
cat('\n')

#VA
print("��˾�ʲ���ֵ:")
V0 <- z$x[1] * E
print(paste("V0=", V0))
#AssetTheta
print("��˾�ʲ���ֵ�Ĳ�����:")
ThetaV <- z$x[2]
print(paste("ThetaV=", ThetaV))
cat('\n')

#����ΥԼ����
print("ΥԼ����:")
DD <- (V0 - D0) / (V0 * ThetaV)
print(paste("DD=", DD))
#����ΥԼ��
print("ΥԼ��:")
EDF <- pnorm(DD)
print(paste("EDF=", EDF))