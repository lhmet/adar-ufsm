---
title: "Instalando R e RStudio"
#subtitle: "Mantendo o R sempre atualizado no Linux Ubuntu"
author: "Jônatan Tatsch e Roilan Valdés"
date: '2018-03-12'
output:
  html_document:
    fig_caption: yes
    fig_height: 7
    fig_width: 8
    highlight: kate
    keep_md: yes
    number_sections: no
    toc: yes
    default: TRUE
    self_contained: TRUE
---








</style>
<div class="midcenter" style="margin-left:1px; margin-top:50px;">
<img src="figs/adar.png" height="110px" width="1000px" />
</div>


O *R* é um software livre, de código fonte aberto e funciona em diversos sistemas operacionais (Linux, Windows e MacOS). O usuário interage com o *R* pela linha de comando. Essa interação pode ser facilitada por meio de uma interface gráfica. Nesse curso será utilizado o [RStudio](http://www.rstudio.com/) que também é multiplataforma.

A seguir descreve-se como instalar o *R* e o [RStudio](http://www.rstudio.com/) no Linux Ubuntu. A forma de instalação do R no Linux é mais didática do que prática. Alguns comandos linux básicos serão utilizados, mas mesmo quem não é usuário linux será capaz de entendê-los.

# Instalação

O *R* pode ser instalado a partir dos [binários pré-compilados](https://cran.r-project.org/bin/) ou do [código fonte](https://cran.r-project.org/sources.html). Aqui, descreve-se a instalação do *R* a partir dos binários

## Windows 

A forma de instalar o R no Windows é baixar o binário executável da **Rede Abrangente de Arquivos do R** ([CRAN](https://cran.r-project.org/)).
Depois clicar em *Download R for Windows* e  *install R for the first time*. Quando este tutotial foi escrito a última versão foi a [R 4.3.3](https://cran.r-project.org/bin/windows/base/R-3.4.3-win.exe).

A instalação do R para Windows a partir do executável acima incluirá na instalação uma GUI chamada `RGui.exe`, mostrada abaixo.

<div class="figure">
<img src="figs/rgui-windows.png" alt="Interface gráfica do usuário para o R para Windows." width="1042" />
<p class="caption">Interface gráfica do usuário para o R para Windows.</p>
</div>


## Linux 

### Ubuntu

Há várias formas de instar o R no Ubuntu, mas geralmente a versão compilada no repositório *default* do Ubuntu não é a última. Se isso for problema para você então basta executar:


```r
sudo apt-get install r-base
```


### R sempre atualizado

Se você prefere trabalhar com a última versão estável do R, precisamos configurar o Linux Ubuntu para atualizar automaticamente o *R*. Também uma boa prática definir um diretório para armazenamento dos pacotes utilizados. 

O procedimento de instalação requer senha de superusuário do sistema ou de privilégios [sudo](https://en.wikipedia.org/wiki/Sudo). Caso não tenha, consulte o administrador do sistema.

Ao utilizar distribuições Linux Ubuntu é importante optar por versões estáveis[^1]. As versões de Suporte de longo prazo (LTS) mais recentes são:

- 14.04 (abril de 2014, *codename* `trusty`) 
- 16.04 (abril de 2016, *codename* `xenial`)

[^1]: Clique [aqui](http://releases.ubuntu.com) para saber mais sobre as versões do Ubuntu.

 
O [R](http://www.r-project.org/) é distribuído  na CRAN. Geralmente há duas atualizações ao ano. A versão mais atual é a R version 3.4.3 (2017-11-30). Para que ele seja atualizado automaticamente no Ubuntu precisamos adicionar o [repósitório do R](http://cran.r-project.org/mirrors.html) mais próximo da nossa região à lista de repositórios do Linux. No nosso caso, o repositório mais próximo é o da UFPR (<http://cran-r.c3sl.ufpr.br/>).

### Incluindo repositório do *R* na Lista de repositórios do Ubuntu

A lista de repositórios do sistema é armazenada no arquivo `/etc/apt/sources.list`. Vamos visualizar o conteúdo desse arquivo. Em um terminal linux (use o atalho `Ctr+Alt+t`), digite o seguinte comando:
   
    $ cat /etc/apt/sources.list | head -15
    

```
## # deb cdrom:[Ubuntu 14.04.2 LTS _Trusty Tahr_ - Release amd64 (20150218.1)]/ trusty main restricted
## 
## # See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
## # newer versions of the distribution.
## # deb http://br.archive.ubuntu.com/ubuntu/ trusty main restricted
## # deb-src http://br.archive.ubuntu.com/ubuntu/ trusty main restricted
## deb http://ubuntu.c3sl.ufpr.br/ubuntu/ trusty main restricted
## deb-src http://ubuntu.c3sl.ufpr.br/ubuntu/ trusty main restricted
## ## Major bug fix updates produced after the final release of the
## ## distribution.
## deb http://br.archive.ubuntu.com/ubuntu/ trusty-updates main restricted
## deb-src http://br.archive.ubuntu.com/ubuntu/ trusty-updates main restricted
## 
## ## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## ## team. Also, please note that software in universe WILL NOT receive any
```

Para descobrir o nome da versão do sistema operacional, digite na terminal linux o seguinte comando[^2] :

    $ lsb_release --codename | cut -f2
   

```
trusty
```

[^2]: Se o comando `lsb_release` não funcionar você precisa instalar o pacote `lsb-release` no sistema. Para isso digite no terminal Linux `$ sudo apt-get install lsb-release`.

Precisamos incluir no arquivo `sources.list` o repositório da UFPR. Assim o gerenciador de pacotes 
[apt](http://pt.wikipedia.org/wiki/Advanced_Packaging_Tool) [^3] fará a atualização do *R* quando uma nova versão estiver disponível. Ou seja, você estará utilizando sempre versão mais atual do *R*.

[^3]: o gerenciador de pacotes [apt](http://pt.wikipedia.org/wiki/Advanced_Packaging_Tool) é usado para instalação, atualização e remoção de pacotes em distribuições Debian GNU/Linux.

O endereço do repositório da UFPR será inserido na última linha do arquivo `sources.list` usando alguns comandos linux. Essa tarefa requer privilégios de [superusuário](https://pt.wikipedia.org/wiki/Superusu%C3%A1rio). Vamos trocar do seu usuário para o superusuário.


    $ sudo su


Vamos definir no terminal uma variável com o endereço do repositório e o nome de versão do Ubuntu.

    # repos="deb http://cran-r.c3sl.ufpr.br/bin/linux/ubuntu `lsb_release --codename | cut -f2`/"
 
Note que a variável `repos` é uma sequência de caracteres com as seguintes informações:

    deb `linkRepositorioSelecionado`/bin/linux/ubuntu `versaoUbuntu`/

O valor da variável `repos` é mostrado pelo comando: `$repos`. Certifique-se de que a última palavra corresponde ao nome da sua versão Ubuntu. 

Para acrescentar essa informação no final do arquivo `sources.list` digite no terminal linux:

    # echo $repos >> /etc/apt/sources.list

Podemos retornar a sessão de usuário comum (*lsi*):

    # exit

## [APT protegido](https://cran.r-project.org/bin/linux/ubuntu/README.html#secure-apt) 

Os arquivos binários do *R* para Ubuntu na [CRAN](http://cran.r-project.org) são assinados com uma chave pública [^4] Para adicionar essa chave ao seu sistema digite os seguintes comandos:

    $ gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9

[^4]: Chave pública de autenticação é um meio alternativo de se logar em um servidor ao invés de digitar uma senha. É uma forma mais segura e flexível, mas mais difícil de ser configurada. Esse meio alternativo de fazer login é importante se o computador está visível na internet. Para saber mais veja [aqui](http://the.earth.li/~sgtatham/putty/0.55/htmldoc/Chapter8.html).
        
e então use essa informação como entrada no `apt-key` com

    $ gpg -a --export E084DAB9 | sudo apt-key add -
    
Se aparecer a mensagem de que a chave pública foi importada, então não há necessidade de executar os comandos abaixo. Mas caso seja impresso alguma mensagem de erro, um método alternativo pode ser usado para obter a chave com os comandos:

    $ gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
    $ gpg -a --export E084DAB9 | sudo apt-key add -

Se os comandos acima falharem você pode tentar:

    $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9



 

## Atualização da lista de repositórios do Ubuntu e instalação do *R*

Após fazer as configurações da lista de repositórios e adicionar a chave é necessário fazer a atualização dessa lista (requer poderes de super usuário):

    $ sudo apt-get update
    
Agora, pode instalar o binário do R:

    $ sudo apt-get install r-base

## Diretório para instalação de pacotes

Para termos melhor controle sobre os pacotes do *R* instalados no sistema é recomendado criar um diretório (`/home/usuario/.R/libs`) no seu `home`. O diretório do `home` pode ser obtido com o comando `echo $HOME`.

    $ mkdir -p `echo $HOME`/.R/libs/
    
Para informar ao **R** onde procurar os pacotes que instalamos criamos um arquivo chamado `.Renviron` no diretório `$HOME` contendo a linha `R_LIBS=/home/usuario/.R/libs/`, o que pode ser feito com o  comando:

    $ echo 'R_LIBS=`echo $HOME`/.R/libs/' >> `echo $HOME`/.Renviron
    
Esse caminho fica então visível ao *R*, o que pode ser verificado executando a função `.libPaths()` no console do *R*.     

## Testando o *R*

Para iniciar o *R* no Ubuntu, digite `R` no cursor do terminal:

    $ R

A partir desse momento já começamos uma sessão no R. Vamos gerar uma sequência numérica de 1 a 10 e plotá-la.


```r
# sequência de 10 números
1:10
```

```
 [1]  1  2  3  4  5  6  7  8  9 10
```

```r
# gráfico
plot(1:10)
```

![Gráfico da sequência de 10 números.](figs/Chunck4-1.png)

Vamos sair do *R* sem salvar os dados da seção.


```r
q(save = "no")
```

# Rstudio no Ubuntu

O RStudio é um ambiente integrado de desenvolvimento ([IDE](http://en.wikipedia.org/wiki/Integrated_development_environment)) construído especificamente para o *R*. Existem [diversas opções de IDEs](http://www.kdnuggets.com/polls/2011/r-gui-used.html) para o *R*. Nesse curso utilizaremos o RStudio. Assim como *R* pode ser baixado gratuitamente e é multiplataforma. O ambiente do RStudio disponibiliza o console do *R*, um editor com realce da sintaxe do *R*, ferramentas para gráficos, navegação de diretórios, manejo do espaço de trabalho, depuração de código e páginas de ajuda do *R*.

Para instalação você precisa saber seu sistema operacional é 64 ou 32-bit. No Linux Ubuntu essa informação é obtida pelo comando:

    $ arch

Se retornar **x86_64** sua máquina é 64-bit.

Com essa informação, siga os seguintes passos:

  1. acesse [RStudio](http://www.rstudio.com/)
  2. clique em *Download RStudio*
  3. clique *Desktop*
  4. clique em *Download RStudio Desktop*
  5. clique sobre o link da sua plataforma, p.ex.: *RStudio x.xx.xxx - Debian 8+/Ubuntu 12.04+ (64-bit)*
  6. clique sobre o arquivo baixado com o botão direito, abra com *Ubuntu Software Center* e clique em `instalar`.

Abra o RStudio digitando no terminal:

    $ rstudio &
    
Agora você está pronto para começar a programar em *R* aproveitando as facilidades que o [RStudio](http://www.rstudio.com/) oferece. Para saber mais sobre os recursos fornecidos pelo RStudio assista ao vídeo *[RStudio Essencials](https://www.rstudio.com/resources/webinars/rstudio-essentials-webinar-series-part-1/)*. Isso o ajudará a usar mais efetivamente o RStudio.


<br/> 


<p style="font-family: verdana; font-size: 14px; font-style: italic; background: whitesmoke; color: black; line-height: 14px;width: 900px;">Próximo: [Interface do Usuário](https://rawgit.com/jdtatsch/adar-ufsm/master/2_InterfaceUsuario.html)</p> 
