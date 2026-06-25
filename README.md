Algoritmos e Otimização Numérica em Estatística
================
Mateus Vieira Costa

# Algoritmos de Otimização e Estatística Computacional

Este repositório reúne um conjunto de algoritmos matemáticos e
computacionais implementados do zero (*from scratch*) para as
disciplinas de Estatística Computacional e Tópicos em Estatística da
Universidade de Brasília (UnB). O foco do projeto é demonstrar a lógica
lógica, matemática e algorítmica por trás dos principais motores de
otimização numérica utilizados em Data Science e Machine Learning.

## 🛠️ Tecnologias e Ferramentas Utilizadas

- **Linguagem Principal:** R
- **Diferenciação Numérica:** `numDeriv`
- **Modelagem de Suporte e Gráficos:** `e1071`, `ggplot2`

------------------------------------------------------------------------

## 🧠 Algoritmos Implementados

### 1. Gradiente Descendente Puro (`gradient_descent.R`)

Implementação clássica do algoritmo de otimização de primeira ordem para
encontrar mínimos globais e locais de funções matemáticas multivaloradas
em R^d por meio de taxas de aprendizado direcionadas. \* **Destaque:** O
script avalia a velocidade de convergência e estabilidade do algoritmo
sob diferentes taxas de aprendizado (*Learning Rates* - $\eta$),
demonstrando empiricamente o problema de convergência lenta em
subestimações e instabilidade ou oscilação em superestimações.

### 2. Gradiente Descendente Estocástico para SVM (`stochastic_gradient_descent_svm.R`)

Função algorítmica construída manualmente para resolver o problema de
otimização de classificadores *Support Vector Machines* (SVM) por meio
de gradientes estocásticos (SGD). \* **Destaque:** Em vez de computar o
gradiente sobre toda a base de dados (custo computacional massivo), o
algoritmo seleciona amostras pontuais e estocásticas para atualizar o
vetor de pesos, simulando o comportamento real de algoritmos de produção
em cenários de Big Data. Ele também avalia e plota a separação de
classes em margens rígidas (*Hard-SVM*) e suaves (*Soft-SVM*).

### 3. Otimização Estocástica via Simulated Annealing (`simulated_annealing.R`)

Algoritmo de Recozimento Simulado (Simulated Annealing - SA) aplicado à
estimação por Máxima Verossimilhança em distribuições probabilísticas
com suportes complexos e restrições paramétricas severas. \*
**Destaque:** Demonstra a aplicação de métodos heurísticos globais para
escapar de máximos locais em funções de log-verossimilhança severamente
não-lineares, calculando e comparando métricas de erro estatístico (MSE
e MAE) contra algoritmos de busca em malha (Grid Search) clássicos.

------------------------------------------------------------------------

## 📁 Estrutura do Repositório

- `gradient_descent.R`: Script contendo a implementação do gradiente
  descendente puro e o laço de teste para taxas de aprendizado.
- `stochastic_gradient_descent_svm.R`: Algoritmo iterativo SGD e
  simulação de dados com plots de hiperplanos lineares de separação.
- `simulated_annealing.R`: Framework probabilístico de estimação
  estocástica global via algoritmo de recozimento (`SANN`).

## ⚙️ Como Executar os Códigos

Cada script na raiz deste repositório é completamente autocontido e
independente, possuindo geradores de dados simulados locais e sementes
fixas (`set.seed`). Não há dependência de ficheiros externos, bastando
abrir o script desejado no RStudio e executá-lo diretamente para
observar as métricas de iteração, convergência e os gráficos gerados
diretamente no console e painel visual.
