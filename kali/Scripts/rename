#!/bin/bash
  Hash_Sample_Size=$((50 * 1024 * 1024))  #50 - Tamanho do bloco de amostra (em bytes)


# Funções
renomear() {
  echo "Executando a renomeação..."
  
  # Contador inicial para nomes temporários
  temp_contador=1
  echo "[" > "$mapeamento"
  
  # echo "------------ Lista de nomes ------------" > nomes.txt
  
  # Renomeação temporária
  echo "Executando renomeação temporária..."
  find "$diretorio" -type f -printf "%s %p\n" | sort -n | while read -r _ arquivo; do
    # Obtém o nome antigo do arquivo
    antigo_nome="${arquivo##*/}"
    
    # Cria o nome temporário
    extensao="${arquivo##*.}"
    temp_nome="$temp_contador.$extensao"
    
    # Calcula o hash do arquivo
    hash=$(calcular_hash_parcial "$arquivo")
    
    # Salva o mapeamento no JSON
    echo "{\"antigo_nome\":\"$antigo_nome\",\"novo_nome\":\"$temp_nome\",\"hash\":\"$hash\"}," >> "$mapeamento"
    

    echo "$arquivo -> $diretorio/temp$temp_nome"
    mv "$arquivo" "$diretorio/temp$temp_nome"
    
    temp_contador=$((temp_contador + 1))
  done
  
  # Contador inicial para nomes finais
  final_contador=1
  
  # Renomeação final
  echo "Executando renomeação final..."
  find "$diretorio" -type f -printf "%s %p\n" | sort -n | while read -r _ arquivo; do
    
    # Define o nome final
    extensao="${arquivo##*.}"
    final_nome="$final_contador.$extensao"
    
    echo "temp$final_nome -> $final_nome"
    mv "$arquivo" "$diretorio/$final_nome"
    
    final_contador=$((final_contador + 1))
  done
  
  # Remove a última vírgula do arquivo JSON antes de fechar o array
  truncate -s -2 "$mapeamento"
  echo "]" >> "$mapeamento"
  
  echo "Renomeação concluída! O mapeamento foi salvo em $mapeamento."
}

reverter() {
  echo "Executando a reversão..."
  
  # Verifica se o arquivo de mapeamento existe
  if [ ! -f "$mapeamento" ]; then
    echo "Erro: Arquivo de mapeamento '$mapeamento' não encontrado!"
    exit 1
  fi

  # Lê o arquivo de mapeamento e itera sobre os registros
  jq -c '.[]' "$mapeamento" | while read -r linha; do
    # Extrai os campos do JSON usando jq
    antigo_nome=$(echo "$linha" | jq -r '.antigo_nome')
    hash_registrado=$(echo "$linha" | jq -r '.hash')
    novo_nome=$(echo "$linha" | jq -r '.novo_nome')

    # Caminho completo para o arquivo renomeado
    arquivo_atual="$diretorio/$novo_nome"

    # Verifica se o arquivo renomeado existe
    if [ ! -f "$arquivo_atual" ]; then
      echo "Aviso: Arquivo '$arquivo_atual' não encontrado. Pulando."
      continue
    fi

    # Calcula o hash do arquivo atual
    hash_atual=$(calcular_hash_parcial "$arquivo_atual")

    # Compara o hash calculado com o registrado
    if [ "$hash_atual" == "$hash_registrado" ]; then
      # Caminho completo para o nome original
      caminho_antigo="$diretorio/$antigo_nome"
      echo "Renomeando: '$arquivo_atual' -> '$caminho_antigo'"
      mv "$arquivo_atual" "$caminho_antigo"
    else
      echo "Erro: Hash não corresponde para o arquivo '$arquivo_atual'. Pulando."
    fi
  done
  
  echo "Processo de reversão concluído!"
}

# Exibe ajuda
mostrar_ajuda() {
  echo "Uso: $0 -d <diretorio> -m <mapeamento> [-r | -v]"
  echo ""
  echo "Opções:"
  echo "  -d    Diretório onde estão os arquivos (obrigatório)"
  echo "  -m    Arquivo de mapeamento JSON (obrigatório)"
  echo "  -n    Executa a renomeação dos arquivos"
  echo "  -x    Executa a reversão dos arquivos"
  echo "  -h    Exibe esta ajuda"
  exit 1
}

# Função para calcular o hash de um arquivo
calcular_hash() {
  sha256sum "$1" | awk '{print $1}'
}

calcular_hash_parcial() {
  head -c "$Hash_Sample_Size" "$1" | sha256sum | awk '{print $1}' # Hash dos primeiros 10MB
}

# Parsing de opções
acao=""
while getopts "d:m:nxh" opt; do
  case $opt in
    d) diretorio="$OPTARG" ;;
    m) mapeamento="$OPTARG" ;;
    n) acao="renomear" ;;
    x) acao="reverter" ;;
    h) mostrar_ajuda ;;
    *) mostrar_ajuda ;;
  esac
done

# Verifica se as opções obrigatórias foram fornecidas
if [ -z "$diretorio" ] || [ -z "$mapeamento" ]; then
  echo "Erro: Diretório e arquivo de mapeamento são obrigatórios."
  mostrar_ajuda
fi

# Verifica se uma ação foi selecionada
if [ -z "$acao" ]; then
  echo "Erro: Você deve selecionar uma ação (-r para renomear ou -v para reverter)."
  mostrar_ajuda
fi

# Executa a ação selecionada
case $acao in
  renomear) renomear ;;
  reverter) reverter ;;
esac
