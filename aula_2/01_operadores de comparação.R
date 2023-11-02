# Aula 2 parte 1 ----------------------------------------------------------
# testes lógicos ----------------------------------------------------------
# operadores de comparação ------------------------------------------------
# Em operações lógicas há apenas duas saídas
TRUE
FALSE

# datas -------------------------------------------------------------------

?strptime()

# operações ---------------------------------------------------------------

# 9 é igual, maior ou menor que 5?

9 ; 5 # ";" faz duas "linhas" ou codes separados rodar

9 == 5 # 9 é igual a 5?
9 <= 5 # 9 é menor ou igual a 5?
9 < 5 # 9 é menor que 5?
9 >= 5 # 9 é maior ou igual a 5?
9 > 5 # 9 é maior que 5?
9 != 5 # 9 é diferente de 5?
1 %in% c(1,2,3) # 1 pertence ao conjunto c(1,2,3)?
# com string

"a" == "b"
"a" != "b"

"PPGCS" == "UFRGS"
"PPGCS" == "PPGCS"
"PPGCS" == "ppgcs"

letters[1:2] > "a"

# função c() --------------------------------------------------------------
# serve para combinar/concatenar valores
?c()

c(1,2,3) == c(1,6,7)
c(1,2,3) != c(1,6,7)

c(1,2,3) %in% c(1,6,7)

# operadores lógicos ------------------------------------------------------

3 < 1 & 3 > 0 # 3 é menor que 1 e maior que 0?
3 < 1 | 3 > 0 # 3 é menor que 1 e maior que 0?
!0:2 == 2:0 # valores de um lado são diferente do outro?
0:2 != 2:0 # valores de um lado são diferente do outro?

# comparar

# atribuindo resultado ----------------------------------------------------

resultado_idade <- 26 == 27

print(resultado_idade) # função print imprime na tela
typeof(resultado_idade) # verifica o tipo de variável
