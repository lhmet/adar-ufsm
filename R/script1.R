## Primeiro script no R
15 + 4
1:100
1 * 2 * 3 * 4 * 5 *6 * 7 * 8 * 9 * 10
4-3

## salvando um gráfico da sequência de 1 a 100 em um arquivo pdf
pdf("plot_script1.pdf") # cria e abre um arquivo pdf
plot(1:100)             # faz o gráfico
dev.off()               # fecha o arquivo pdf

## atribuindo a x a sequência de 1 a 100
x <- 1:100
x