# ---- ALGORITMO: Gradiente Descendente Estocástico (SGD) aplicado a SVM ----
# Objetivo: Otimização iterativa por amostragem pontual para classificação linear.
library(e1071)
library(ggplot2)

set.seed(777)

# 1. Simulação de Dados para Classificadores lineares (Hard vs Soft Margins)
dados_hard <- data.frame(
  X1 = c(rnorm(10, mean = 2, sd = 0.2), rnorm(10, mean = 5, sd = 0.2)),
  X2 = c(rnorm(10, mean = 2, sd = 0.2), rnorm(10, mean = 5, sd = 0.2)),
  Classe = factor(rep(c("categoria1", "categoria2"), each = 10))
)

dados_soft <- data.frame(
  X1 = c(rnorm(10, mean = 2, sd = 0.5), rnorm(10, mean = 4, sd = 1)),
  X2 = c(rnorm(10, mean = 2, sd = 0.5), rnorm(10, mean = 4, sd = 1)),
  Classe = factor(rep(c("categoria1", "categoria2"), each = 10))
)

# 2. Ajuste via Bibliotecas Padrão (Filtro de Comparação)
svm_hard <- svm(Classe ~ ., data = dados_hard, kernel = "linear", cost = 1e5)
svm_soft <- svm(Classe ~ ., data = dados_soft, kernel = "linear", cost = 0.1)

# 3. Algoritmo Iterativo SGD para SVM (Implementado na Mão)
sgd_svm_fit <- function(X, y, lambda, N) {
  n <- nrow(X)
  d <- ncol(X)
  theta <- rep(0, d)
  
  for (t in 1:N) {
    w_t <- (1 / (lambda * t)) * theta  
    i <- sample(1:n, 1) # Escolha aleatória de um único ponto (Propriedade Estocástica)
    
    if (y[i] * sum(w_t * X[i, ]) < 1) {
      theta <- theta + y[i] * X[i, ]
    }
  }
  w_bar <- (1 / N) * colSums(matrix(rep(w_t, N), nrow = N, byrow = TRUE))
  return(w_bar)
}
print("Algoritmo SGD para SVM pronto para execução.")