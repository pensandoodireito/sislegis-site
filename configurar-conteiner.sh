#!/bin/bash
#Author: Paulo Jerônimo (@paulojeronimo, paulojeronimo@gmail.com)

while [[ ! $ok =~ ^[Ss]$ ]]
do
  read -p 'Usuário no GitHub.............: ' GHUSER
  read -p 'Fork do projeto sislegis-site.: ' GHFORK
  read -p 'Nome..........................: ' NOME
  read -p 'Email.........................: ' EMAIL
  GHFORK=${GHFORK:-http://github.com/$GHUSER/sislegis-site}
  echo -e "\nGHUSER=$GHUSER\nGHFORK=$GHFORK\nNOME=$NOME\nEMAIL=$EMAIL\n"
  read -p "Confirma? (s/N): " ok
done

yum -y install vim
useradd -G rvm $GHUSER -s /bin/bash
su - $GHUSER <<EOF
git config --global user.name "$NOME"
git config --global user.email "$EMAIL"
git config --global push.default simple
git clone $GHFORK
cd sislegis-site
git remote add upstream https://github.com/pensandoodireito/sislegis-site
git fetch upstream
git merge upstream/master
rvm use 2.1@sislegis-site --create --ruby-version
bundle install
EOF
