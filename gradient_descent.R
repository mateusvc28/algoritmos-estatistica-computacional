# ---- ALGORITMO: Gradiente Descendente Puro ----
# Objetivo: Minimização de funções matemáticas em R^d por derivadas numéricas e analíticas.
library(numDeriv)

# 1. Definição da Função Objetivo (Exemplo Quadrático)
f_alvo <- function(par) {
  x <- par[1]
  y <- par[2]
  return(1.25 * (x + 6)^2 + (y - 8)^2)
}

# 2. Implementação Funcional do Gradiente Descendente
gradiente_descent <- function(f, w0, eta, n_iter, epslon = 10^(-4)) {
  w <- w0
  w_min <- w  
  f_min <- f(w) 
  
  for (i in 1:n_iter) {
    w_ant <- w
    
    # Cálculo do vetor gradiente via derivada numérica do pacote numDeriv
    v <- grad(f, w_ant)
    
    # Passo de atualização dos parâmetros
    w <- w_ant - eta * v
    
    # Teste de Convergência (Critério de Parada por tolerância)
    if (abs(f(w) - f(w_ant)) < epslon) {
      break
    }
    
    # Armazenamento do mínimo global encontrado na trajetória
    if (f(w) < f_min) {
      w_min <- w
      f_min <- f(w)
    }
  }
  return(list(w_opt = w_min, f_opt = f_min, iterations = i))
}

# 3. Execução e Análise do Impacto do Learning Rate (eta)
etas <- c(0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75)
print("--- Avaliação de Convergência por Learning Rate ---")
for (eta in etas) {
  solucao <- gradiente_descent(f_alvo, w0 = c(0, 0), eta = eta, n_iter = 100)
  print(paste("Eta =", eta, "| Iterações:", solucao$iterations, 
              "| Mínimo Encontrado:", paste(round(solucao$w_opt, 4), collapse = ", ")))
}