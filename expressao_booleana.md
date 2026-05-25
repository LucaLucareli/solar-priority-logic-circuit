## 2. Expressão Lógica do Sistema

---

### a) Expressão original do problema

Para estruturar a expressão lógica inicial, o comportamento do sistema foi dividido em dois cenários principais, tendo como eixo central o **Horário de Pico ($C$)**:

1. **Fora do horário de pico ($\overline{C}$):** A carga é ativada se houver energia solar **OU** bateria ($A + B$), **E** se o equipamento for solicitado ($D$).
2. **Durante o horário de pico ($C$):** A carga é ativada **APENAS** se houver energia solar ($A$), **E** se o equipamento for solicitado ($D$).

Unindo esses dois cenários com uma porta lógica **OR** ($+$), obtemos a expressão bruta (não simplificada):

> $$S = (\overline{C} \cdot (A + B) \cdot D) + (C \cdot A \cdot D)$$
> 
> 

---

### b) Simplificação Booleana

A expressão original é funcional, mas exige muitas portas lógicas. Para otimizar o circuito no Tinkercad, aplicamos as propriedades da Álgebra Booleana no passo a passo a seguir:

**Passo 1: Propriedade Distributiva** *(aplicada no primeiro termo)*


$$S = (A \cdot \overline{C} \cdot D) + (B \cdot \overline{C} \cdot D) + (C \cdot A \cdot D)$$

**Passo 2: Propriedade Comutativa** (reorganização para agrupar os termos com $A \cdot D$)


$$S = (A \cdot \overline{C} \cdot D) + (A \cdot C \cdot D) + (B \cdot \overline{C} \cdot D)$$

**Passo 3: Propriedade Distributiva Reversa / Fatoração** (colocando $A \cdot D$ em evidência)


$$S = A \cdot D \cdot (\overline{C} + C) + B \cdot \overline{C} \cdot D$$

**Passo 4: Propriedade do Complemento** (sabendo que $\overline{C} + C = 1$)


$$S = A \cdot D \cdot (1) + B \cdot \overline{C} \cdot D$$

**Passo 5: Propriedade da Identidade** (sabendo que $X \cdot 1 = X$)


$$S = A \cdot D + B \cdot \overline{C} \cdot D$$

**Passo 6: Fatoração Final** (colocando $D$ em evidência para enxugar o hardware)

> $$S = D \cdot (A + B \cdot \overline{C})$$
> 
> 

---

### Justificativas e Impacto no Projeto

* **Propriedades Algébricas Utilizadas:**
  * Distributiva
  * Comutativa
  * Complemento
  * Identidade
\n

**Impacto na Implementação do Circuito (Hardware):**
A expressão original exigiria o uso de múltiplas portas **AND** de 3 ou mais entradas e várias portas **OR**, resultando em um hardware complexo. Com a expressão matemática otimizada ( $S = D \cdot (A + B \cdot \overline{C})$ ), o circuito exigirá apenas **4 portas lógicas** para funcionar:
 
1. Porta **NOT** (para inverter $C$)
2. Porta **AND** (para multiplicar $B \cdot \overline{C}$)
3. Porta **OR** (para somar $A$)
4. Porta **AND** (para multiplicar o resultado por $D$)



**Conclusão:** Essa simplificação reduz drasticamente o custo financeiro do hardware, a complexidade da fiação no protoboard e a probabilidade de falhas físicas (mau contato).
