# Multi-motor-Synchronous-Control
Simulink simulation of synchronous control of multiple motors based on PMSM for FOC inner loop.

### 版本说明
请使用'MATLAB 2025b' 之后的版本

### 运行说明
先运行 `.m` 文件，然后运行任意 `.slx` 文件即可

### 文件介绍
FOC_driver.epro --- 电机驱动电路

single_motor.slx --- 单个电机的foc控制

sync_baseline.slx --- 最基本的同步控制

Position_ET_fix_sync.slx --- 外环事件触发固定时间同步控制 + 内环foc控制

Position_ET_fix_sync1.slx --- 外环事件触发固定时间同步控制 + 内环固定时间动态面控制

