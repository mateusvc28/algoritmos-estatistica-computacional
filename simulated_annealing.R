# ---- ALGORITMO: Otimização Estocástica via Simulated Annealing (SA) ----
# Objetivo: Estimação de parâmetros de máxima verossimilhança via Algoritmo SANN.

# 1. Funções de Suporte Matemático e Densidades Customizadas
calc_support <- function(alpha, beta, gamma) {
  if (gamma > 0) {
    lim_inf <- ((alpha^2 * beta + 2 * beta * gamma^2)) / (2 * gamma^2) - 
      sqrt((alpha^4 * beta^2 + 4 * alpha^2 * beta^2 * gamma^2) / gamma^4) / 2
    lim_sup <- Inf
  } else if (gamma < 0) {
    lim_inf <- 0
    lim_sup <- ((alpha^2 * beta + 2 * beta * gamma^2)) / (2 * gamma^2) + 
      sqrt((alpha^4 * beta^2 + 4 * alpha^2 * beta^2 * gamma^2) / gamma^4) / 2
  } else { 
    lim_inf <- 0; lim_sup <- Inf
  }
  return(c(lim_inf, lim_sup))
}

pdf_custom <- function(t, alpha, beta, gamma) {
  support <- calc_support(alpha, beta, gamma)
  if (t < support[1] || t > support[2]) return(0)
  
  at <- (1 / alpha) * (sqrt(t / beta) - sqrt(beta / t))
  At <- t^(-3 / 2) * ((t + beta) / (2 * alpha * sqrt(beta)))
  
  if (gamma != 0) {
    dens <- At * (1 + gamma * at)^(-1 - 1 / gamma) * exp(- (1 + gamma * at)^(-1 / gamma))
  } else {
    dens <- At * exp(-exp(-at) - at)
  }
  return(as.numeric(ifelse(dens < Inf && dens > 0, dens, 0)))
}

# 2. Ingestão da Base Amostral de Teste
dados_amostra <- c(3.83, 0.95, 467.07, 514.15, 25.49, 0.26, 0.86, 12.64, 1.72, 457.23,
                   0.66, 3.71, 0.85, 0.21, 1.28, 1.35, 0.41, 6.40, 55.24, 9.36,
                   0.31, 6.87, 80.73, 10.74, 961.81, 3383.35, 9.93, 0.22, 0.97, 1.51)

# 3. Log-Verossimilhança e Otimizador SANN (Simulated Annealing)
log_likelihood_calc <- function(params, data) {
  alpha <- params[1]; beta <- params[2]; gamma <- params[3]
  if (alpha <= 0 || beta <= 0) return(-Inf)
  
  support <- calc_support(alpha, beta, gamma)
  valid_data <- data[data >= support[1] & data <= support[2]]
  if (length(valid_data) == 0) return(-Inf)
  
  log_lik <- sum(sapply(valid_data, function(t) {
    val <- pdf_custom(t, alpha, beta, gamma)
    if (val > 0) log(val) else -Inf
  }))
  return(ifelse(is.finite(log_lik), log_lik, -Inf))
}

optim_sa <- function(data) {
  obj_func <- function(params) -log_likelihood_calc(params, data)
  result <- optim(c(1, 1, 0), obj_func, method = "SANN", control = list(maxit = 500, temp = 100))
  return(result$par)
}

# Execução
print("Ajustando parâmetros via Simulated Annealing...")
params_sann <- optim_sa(dados_amostra)
print(paste("Estimativas obtidas -> Alpha:", round(params_sann[1],4), "| Beta:", round(params_sann[2],4)))