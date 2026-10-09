# Multi-motor-Synchronous-Control
Simulink simulation of synchronous control of multiple motors based on PMSM.

## 版本说明
请使用'MATLAB 2025b' 之后的版本

## 运行说明
先运行 `.m` 文件，然后运行任意 `.slx` 文件即可

# 文件介绍

## 硬件控制

## `FOC_driver.epro` --- 电机驱动电路

### `motor_param.m` --- 电机和控制器参数文件

## 单电机simulink


### `single_motor_FOC.slx` --- 单个电机的foc控制

### `single_motor_FOC_PWM.slx` --- 带有门控单元仿真的单个电机的foc控制

### `single_motor_fix_vel.slx` --- 单个电机的固定时间速度控制（三角波负载）

定义通用幂次符号函数：

$$
\text{sig}(x, a) = |x|^a \cdot \text{sgn}(x)
$$

### 速度环
#### 控制器
$$
 e_w = \bar{w} - w_{ref} 
$$
$$
 e_v = w_m - w_{ref} 
$$
$$
 s = w_m - \bar{w} 
$$
$$
 \dot{\bar{w}} = \frac{1}{\tau} \left( -\lambda_1 \text{sig}(e_w, 0.5) - \lambda_2 \text{sig}(e_w, \vartheta) - \lambda_3 e_w \right) 
$$
$$
 \dot{\xi} = \kappa_0 e_v + \kappa_1 \text{sig}(e_v, \alpha_1) + \kappa_2 \text{sig}(e_v, \alpha_2) 
$$
$$
 u_{cmd} = J_m \dot{\bar{w}} + D_m \bar{w} - k_i \xi - k_w s - k_1 \text{sig}(s, 0.5) - k_2 \text{sig}(s, \vartheta) 
$$

#### 符号含义
| 符号 | 含义 |
| :---: | :--- |
| $$w_{ref}$$ | 参考转速 |
| $$w_m$$ | 实际转速 |
| $$\bar{w}$$ | 滤波转速 |
| $$\xi$$ | 积分状态（用于负载转矩估计） |
| $$u_{cmd}$$ | 速度环输出（参考转矩/电流） |
| $$J_m, D_m$$ | 电机机械参数（转动惯量、阻尼系数） |
| $$\lambda, \tau, \kappa, \alpha, k$$ | 控制器设计参数 |

### 电流环
#### 控制器
$$
 e_z = z_q - i_{q,ref} 
$$
$$
 e_{\bar{q}} = i_q - z_q 
$$
$$
 \dot{z}_q = -\lambda_{q1} \text{sig}(e_z, \rho_1) - \lambda_{q2} \text{sig}(e_z, \rho_2) 
$$
$$
 V_q = L_q \left( \dot{z}_q + k_{q1} \text{sig}(e_{\bar{q}}, r_1) + k_{q2} \text{sig}(e_{\bar{q}}, r_2) \right) + R_s z_q + L_d \omega_e i_d + \omega_e \Phi 
$$
$$
 V_d = L_d \left( k_{d1} \text{sig}(i_d, r_1) + k_{d2} \text{sig}(i_d, r_2) \right) + R_s i_d + L_q \omega_e i_q 
$$

#### 符号含义
| 符号 | 含义 |
| :---: | :--- |
| $$i_{q,ref}$$ | q轴参考电流 |
| $$i_q, i_d$$ | q轴、d轴实际电流 |
| $$z_q$$ | q轴辅助迭代状态 |
| $$V_q, V_d$$ | q轴、d轴电压控制律 |
| $$R_s$$ | 定子电阻 |
| $$L_d, L_q$$ | d轴、q轴电感 |
| $$\omega_e$$ | 电角速度 |
| $$\Phi$$ | 转子磁链 |
| $$\lambda, \rho, k, r$$ | 控制器设计参数 |


### `single_motor_fix_ob_vel.slx` --- 带有负载观测器的单个电机的固定时间速度控制（三角波负载）



### 固定时间负载观测器
#### 控制器
$$
 \varepsilon = w_m - \hat{w} 
$$
$$
 \dot{\hat{w}} = \frac{1}{J_m} \left( u_{cmd} + \hat{T}_L - D_m \hat{w} + k_1 \text{sig}(\varepsilon, p_1) + k_2 \text{sig}(\varepsilon, p_2) + k_3 \varepsilon \right) 
$$
$$
 \dot{\hat{T}}_L = k_4 \text{sig}(\varepsilon, 2p_1 - 1) + k_5 \text{sig}(\varepsilon, 2p_2 - 1) + k_6 \varepsilon 
$$

#### 符号含义
| 符号 | 含义 |
| :---: | :--- |
| $w_m$ | 实际转速 |
| $\hat{w}$ | 估计转速 |
| $\hat{T}_L$ | 估计负载转矩 |
| $u_{cmd}$ | 控制输入（力矩指令） |
| $\varepsilon$ | 转速估计误差 |
| $J_m, D_m$ | 电机机械参数（转动惯量、阻尼系数） |
| $p_1, p_2, k_1 \sim k_6$ | 观测器设计参数 |


### 速度环
#### 控制器
$$
 e_w = \bar{w} - w_{ref} 
$$
$$
 \dot{\bar{w}} = \frac{1}{\tau} \left( -\lambda_1 \text{sig}(e_w, 0.5) - \lambda_2 \text{sig}(e_w, \vartheta) - \lambda_3 e_w \right) 
$$
$$
 s = w_m - \bar{w} 
$$
$$
 u_{cmd} = J_m \dot{\bar{w}} + D_m \bar{w} - \hat{T}_L - k_w s - k_1 \text{sig}(s, 0.5) - k_2 \text{sig}(s, \vartheta) 
$$

#### 符号含义
| 符号 | 含义 |
| :---: | :--- |
| $w_{ref}$ | 参考转速 |
| $w_m$ | 实际转速 |
| $\bar{w}$ | 滤波转速 |
| $\hat{T}_L$ | 观测器估计的负载转矩 |
| $u_{cmd}$ | 速度环输出（参考转矩/电流指令） |
| $J_m, D_m$ | 电机机械参数（转动惯量、阻尼系数） |
| $\lambda, \tau, \vartheta, k$ | 控制器设计参数 |


### 电流环
#### 控制器
$$
 e_z = z_q - i_{q,ref} 
$$
$$
 \dot{z}_q = -\lambda_{q1} \text{sig}(e_z, \rho_1) - \lambda_{q2} \text{sig}(e_z, \rho_2) 
$$
$$
 e_{\bar{q}} = i_q - z_q 
$$
$$
 V_q = L_q \left( \dot{z}_q + k_{q1} \text{sig}(e_{\bar{q}}, r_1) + k_{q2} \text{sig}(e_{\bar{q}}, r_2) \right) + R_s z_q + L_d \omega_e i_d + \omega_e \Phi 
$$
$$
 V_d = L_d \left( k_{d1} \text{sig}(i_d, r_1) + k_{d2} \text{sig}(i_d, r_2) \right) + R_s i_d + L_q \omega_e i_q 
$$

#### 符号含义
| 符号 | 含义 |
| :---: | :--- |
| $i_{q,ref}$ | q轴参考电流 |
| $i_q, i_d$ | q轴、d轴实际电流 |
| $z_q$ | q轴辅助迭代状态 |
| $V_q, V_d$ | q轴、d轴电压控制律 |
| $R_s$ | 定子电阻 |
| $L_d, L_q$ | d轴、q轴电感 |
| $\omega_e$ | 电角速度 |
| $\Phi$ | 转子磁链 |
| $\lambda, \rho, r, k$ | 控制器设计参数 |



## 多电机同步控制

### `sync_baseline.slx` --- 最基本的同步控制

### `ET_fix_FOC_sync.slx` --- 外环固定时间事件触发同步控制，内环FOC控制

### `ET_fix_Current_sync.slx` --- 外环事件触发固定时间同步控制 + 内环速度PI控制 + 电流环固定时间动态面控制

### `ET_fix_all_sync.slx` --- 外环固定时间事件触发同步控制，内环固定时间动态面控制

### `/final/` --- 带有机械转矩耦合的外环固定时间事件触发同步控制，内环固定时间动态面控制




