---
title: maths
summary: useful maths
---

# maths

## mathjax guide

$$
\bar x
\hat y
$$

$$
\int f(x)dx  
$$  

$$
distance = speed \cdot time
$$

$$
\int_{i=0}^\infty i^2
$$

$$
\mathbb R
$$

$$
\infty
$$

$$
\lim \limits_{x \to 1}
$$
## algebra

### **perfect square**

$$
x^2 + 2bx + b^2 = (x+b)^2
$$


## linear algebra

## errors 

### mean absolute error

where y is your value and y_hat is the predicted value for your equation

$$
AME = \frac{1}{n}\sum_{i=0}^n|y- \hat y|
$$

### mean squared error

$$
MSE = \frac{1}{n}\sum_{i=0}^n(y - \hat y)^2
$$


## probabilty

### entropy and probability

to calculate the entropy of a system.
if you have 10 balls 5 red and 5 blue. m = number of red, n = number of blue

$$
Entropy = -\frac{m}{n+m}log_2\frac{m}{n+m} - \frac{n}{n+m}log_2\frac{n}{n+m}
$$

### naive bayes

prob of A given R
for a situation where two people A and B. They both sometimes where a Red jumper.


$$
P(A|R) = \frac{P(A)P(R|A)}{P(A)P(R|A)+P(B)P(R|B)}
$$



### **Rule of Completement**


$$
P(A^c) = 1 - P(A)
$$

The probabilty something doesn't happen, minus the probability that it does

e.g.
A six-sided dice is rolled
prob of a 1, 2. either sum (1, 2) or 1- sum(3-6)

hard example
prob that 1 of 3 six sided dice rolls a 6.
prob 1 dice not roll a 6 = 5/6 
3 dice (5/6)^3
1 - (5/6)^3


## graphs


### hyperbolic tangent function

$$
f\left(x\right)=\frac{e^{x}-e^{-x}}{e^{x}+e^{-x}}
$$

### sigmoid curve

$$
f(x) = \frac{1}{1+e^-x}
$$

and its derivative

$$
f'(x) = (\frac{1}{1-e^{-x}})(1 - \frac{1}{1-e^{-x}})
$$

### logistic curve 

logistic s-shape curves

$$
F(x) = \frac{L}{1 + e^{-k(x-x_0)}}
$$

where L is the max in Y
-k is the curve slop
x0 is th curve midpoint



## functions

### **adeffect**

$$
tv-factor = \frac{tv-coeff}{1-adstock}
$$

## machine learning 

### perceptron error function

$$
E(w) = -\frac{1}{m}\sum_{i=1}^m {y_i}ln(\hat y_i) + (1 + y_i)ln(1 - \hat y_i)
$$

### cross entropy
where i  and j are 2 categories. y is category values and p is the probabilty

$$
E = \sum_{i=1}^n\sum_{j=1}^my_{ij}ln(p_{ij})
$$
