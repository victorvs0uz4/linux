# Usando o comando FREE para mostrar a porcentagem de memória usada (Used = Total – Free – Buffers – Cache)
free | grep Mem | awk '{print $3/$2 * 100.0}'


# Usando o comando FREE para mostrar a porcentagem de memória livre, que está completamente sem uso, nem por aplicações, nem pelo kernel, shared, buffers ou cache.
free | grep Mem | awk '{print $4/$2 * 100.0}'

# Usando o comando FREE para mostrar a porcentagem de memória disponível (Available), estimativa (uma conta interna) de quanta memória está disponível, sem o uso do espaço de swap, para ser utilizada por novas aplicações que se iniciem ou por aplicações em execução que necessitem de mais memória. Note que o Available considera que em caso de necessidade, o sistema pode realocar espaços de memória que estão atualmente sendo utilizados pelas implementações de Buffers e Caches, levando em conta que o uso da memória pelas aplicações tem prioridade ao uso da memória para melhoria de performance. Dessa forma, o espaço em  Available será sempre maior que o Free.
free | grep Mem | awk '{print $7/$2 * 100.0}'
