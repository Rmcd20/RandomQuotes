#!/bin/bash

# Função para buscar uma citação motivacional da API
get_quote() {
    echo "Fazendo requisição à API para obter uma citação..."

    # Faz a chamada à API e captura a resposta
    response=$(curl -s https://zenquotes.io/api/random)

    # Verifica se a requisição foi bem-sucedida
    if [ $? -ne 0 ]; then
        echo "Erro ao fazer a requisição à API."
        echo "Usando uma mensagem padrão."
        # Mensagem padrão caso a API falhe
        echo "Stay positive, work hard, make it happen! - Autor Desconhecido"
    else
        echo "Requisição bem-sucedida! Processando a citação..."

        # Extrai a citação usando 'jq'
        quote=$(echo $response | jq -r '.[0].q')

        # Extrai o autor usando 'jq'
        author=$(echo $response | jq -r '.[0].a')

        # Retorna a citação completa
        echo "$quote - $author"
    fi
}

# Chama a função para obter uma citação
random_message=$(get_quote)

# Exibe a citação diretamente como uma notificação
notify-send "Citação Motivacional" "$random_message"

# Dorme por um tempo aleatório (de 1 a 60 minutos)
sleep_time=$(( (RANDOM % 60 + 1) * 60 ))
echo "Dormindo por $((sleep_time / 60)) minutos antes de executar novamente..."
sleep $sleep_time

