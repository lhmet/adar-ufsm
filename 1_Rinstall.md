# Instalando *R* e RStudio
Jônatan Tatsch, Roilan Valdés  
10-03-2016  


- - -

![](figs/adar.png)






- - -


# Introdução

Nessa seção descreve-se como instalar o *R* e o [RStudio](http://www.rstudio.com/) no Linux Ubuntu.

\"[R](https://www.r-project.org/about.html) é uma linguagem e um ambiente de programação para computação estatística e análise de dados interativa\". Além disso, o *R* é um software livre, de código fonte aberto e funciona em diversos sistemas operacionais (Linux, Windows e MacOS).

R é uma [linguagem interpretada](https://pt.wikipedia.org/wiki/Linguagem_interpretada) ou também chamada de alto nível. O código escrito em *R* não precisa ser compilado antes de ser rodado.

O usuário interage com o *R* pela linha de comando. Mas podemos facilitar essa interação por meio de uma interface gráfica. Nesse curso será utilizado o [RStudio](http://www.rstudio.com/) que também é multiplataforma.

O *R* pode ser instalado a partir dos binários pré-compilados ou do código fonte. Aqui, descreve-se a instalação do *R* a partir dos binários e como configurar o Linux Ubuntu para atualizar automaticamente o *R* e definir um diretório para armazenamento dos pacotes utilizados. A forma de instalação apresentada é mais didática do que prática. 

O procedimento de instalação requer senha de superusuário do sistema ou de privilégios [sudo](https://en.wikipedia.org/wiki/Sudo). Caso não a tenha, consulte o administrador do sistema.
Alguns comandos linux intuitivos serão utilizados, por isso, mesmo quem não é usuário linux será capaz de entendê-los. 

Ao utilizar distribuições Linux é importante optar por versões estáveis, nesse momento as versões de Suporte de longo prazo (LTS) são as 12.04 (abril de 2012, *codename* `precise`), 14.04 (abril de 2014, *codename* `trusty`) e a 15.04 (abril de 2015, *codename* `vivid`). Para saber mais sobre as versões de Ubuntu [clique aqui](http://releases.ubuntu.com/).

# *R* sempre atualizado

O [R](http://www.r-project.org/) é distribuído  na **Rede Abrangente de Arquivos do R** ([CRAN](http://cran.r-project.org/mirrors.html)). Geralmente há duas atualizações ao ano. A versão mais atual é a R version 3.2.4 (2016-03-10). Para que ele seja atualizado automaticamente no Ubuntu precisamos adicionar o [repósitório do R](http://cran.r-project.org/mirrors.html) mais próximo da nossa região à lista de repositórios do Linux. No nosso caso, o repositório mais próximo é o da UFPR (<http://cran-r.c3sl.ufpr.br/>).

## Incluindo repositório do *R* na Lista de repositórios do Ubuntu

A lista de repositórios do sistema é armazenada no arquivo `/etc/apt/sources.list`. Vamos visualizar o conteúdo desse arquivo. Em um terminal linux (use o atalho `Ctr+Alt+t`), digite o seguinte comando no terminal linux:
   
~~~~~~~
$ cat /etc/apt/sources.list 
~~~~~~~

Também é possível fazer isso a partir do *R*, conforme o comando abaixo que mostra as primeiras 15 linhas desse arquivo:


```
 [1] # deb cdrom:[Ubuntu 14.04.2 LTS _Trusty Tahr_ - Release amd64 (20150218.1)]/ trusty main restricted
 [2]                                                                                                    
 [3] # See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to                          
 [4] # newer versions of the distribution.                                                              
 [5] deb http://br.archive.ubuntu.com/ubuntu/ trusty main restricted                                    
 [6] deb-src http://br.archive.ubuntu.com/ubuntu/ trusty main restricted                                
 [7]                                                                                                    
 [8] ## Major bug fix updates produced after the final release of the                                   
 [9] ## distribution.                                                                                   
[10] deb http://br.archive.ubuntu.com/ubuntu/ trusty-updates main restricted                            
[11] deb-src http://br.archive.ubuntu.com/ubuntu/ trusty-updates main restricted                        
[12]                                                                                                    
[13] ## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu                        
[14] ## team. Also, please note that software in universe WILL NOT receive any                          
[15] ## review or updates from the Ubuntu security team.                                                
```

Para descobrir o nome da versão do sistema operacional, digite na terminal linux o seguinte comando [^1]:

[^1]: Se o comando `lsb_release` não funcionar você precisa instalar o pacote `lsb-release` no sistema. Para isso digite no terminal Linux `$ sudo apt-get install lsb-release`.

~~~~~~~
$ lsb_release --codename | cut -f2
~~~~~~~

Precisamos incluir no arquivo `sources.list` o repositório da UFPR. Assim o gerenciador de pacotes 
[apt](http://pt.wikipedia.org/wiki/Advanced_Packaging_Tool) [^2] fará a atualização do *R* quando uma nova versão estiver disponível. Ou seja, você estará utilizando sempre versão mais atual do *R*.

[^2]: o gerenciador de pacotes [apt](http://pt.wikipedia.org/wiki/Advanced_Packaging_Tool) é usado para instalação, atualização e remoção de pacotes em distribuições Debian GNU/Linux.

O endereço do repositório da UFPR será inserido na última linha do arquivo `sources.list` usando alguns comandos linux. Essa tarefa requer privilégios de [superusuário](https://pt.wikipedia.org/wiki/Superusu%C3%A1rio). Vamos trocar do seu usuário para o superusuário.

    $ sudo su

Vamos definir na terminal uma variável com o endereço do repositório e o nome de versão do Ubuntu.

    # repos="deb http://cran-r.c3sl.ufpr.br/bin/linux/ubuntu `lsb_release --codename | cut -f2`/"
 
Note que a variável `repos` é uma sequência de caracteres com as seguintes informações:

    deb `linkRepositorioSelecionado`/bin/linux/ubuntu `versaoUbuntu`/

O valor da variável `repos` é mostrado pelo comando: `$repos`. Certifique-se de que a última palavra corresponde ao nome da sua versão Ubuntu. 

Para acrescentar essa informação no final do arquivo `sources.list` digite no terminal linux:

    # echo $repos >> /etc/apt/sources.list

Podemos retornar a sessão de usuário comum (*lsi*):

    # exit

## [APT protegido](https://wiki.debian.org/SecureApt) (adaptado da [CRAN](http://cran.r-project.org) seção Secure Apt).  

Os arquivos binários do *R* para Ubuntu na [CRAN](http://cran.r-project.org) são assinados com uma chave pública [^3]. Para adicionar essa chave ao seu sistema digite os seguintes comandos:

    $ gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
        
e então use essa informação como entrada no `apt-key` com

    $ gpg -a --export E084DAB9 | sudo apt-key add -
    
Se aparecer a mensagem de que a chave pública foi importada, então não há necessidade de executar os comandos abaixo. Mas caso seja impresso alguma mensagem de erro, um método alternativo pode ser usado para obter a chave com os comandos:

    $ gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
    $ gpg -a --export E084DAB9 | sudo apt-key add -

Se os comandos acima falharem você pode tentar:

    $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9


[^3]: Chave pública de autenticação é um meio alternativo de se logar em um servidor ao invés de digitar uma senha. É uma forma mais segura e flexível, mas mais difícil de ser configurada. Esse meio alternativo de fazer login é importante se o computador está visível na internet. Para saber mais veja [aqui](http://the.earth.li/~sgtatham/putty/0.55/htmldoc/Chapter8.html).

 

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

<img src="figs/Chunck4-1.png" title="" alt="" style="display: block; margin: auto;" />

Vamos sair do *R* sem salvar os dados da seção.


```r
q(save = "no")
```

# Rstudio no Ubuntu

O RStudio é um ambiente integrado de desenvolvimento ([IDE](http://en.wikipedia.org/wiki/Integrated_development_environment)) construído especificamente para o *R*. Existem [diversas opções de IDEs](http://www.sciviews.org/_rgui/projects/Editors.html) para o *R*. Nesse curso utilizaremos o RStudio. Assim como *R* pode ser baixado gratuitamente e é multiplataforma. O ambiente do RStudio disponibiliza o console do *R*, um editor com realce da sintaxe do *R*, ferramentas para gráficos, navegação de diretórios, manejo do espaço de trabalho, depuração de código e páginas de ajuda do *R*.

Para instalação você precisa saber seu sistema operacional e é 64 ou 32-bit. No Linux Ubuntu essa informação é obtida pelo comando linux:

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
    
Agora você está pronto para começar a programar com *R* aproveitando as facilidades que o [RStudio](http://www.rstudio.com/) oferece.



<br/> 


<p style="font-family: verdana; font-size: 14px; font-style: italic; background: whitesmoke; color: black; line-height: 14px;width: 900px;">Próximo: [O ambiente R](https://rawgit.com/jdtatsch/adar-ufsm/master/2_AmbienteR.html)</p> 
