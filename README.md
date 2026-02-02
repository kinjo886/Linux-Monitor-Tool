# 🐧 Linux 系统资源监控工具 (System Monitor Tool)

> 一个基于 Shell 脚本开发的轻量级 Linux 系统运维工具。
> 用于实时监控服务器资源（CPU、内存、磁盘）及关键业务进程的运行状态。

![Shell](https://img.shields.io/badge/Language-Bash_Shell-4EAA25?style=flat-square&logo=gnu-bash)
![Linux](https://img.shields.io/badge/Platform-Linux-FCC624?style=flat-square&logo=linux)
![Ops](https://img.shields.io/badge/Field-DevOps-blue?style=flat-square)

## 📖 项目简介

本项目是一个用于 Linux 服务器日常运维的 Shell 脚本工具。它能够对系统核心指标和指定进程进行健康检查，并以可视化的形式（✅/⚠️）输出检测结果。

该脚本主要解决了人工巡检效率低的问题，能够快速定位 CPU 飙高、内存泄漏、磁盘满载或关键进程挂掉等常见故障。

## ✨ 核心功能 (Features)

根据作业报告设计，本工具实现了以下 **7 大监控模块**：

| 功能模块 | 说明 |
| :--- | :--- |
| **🔍 进程存在性检查** | 根据用户名和进程名，判断业务进程是否存活 (Running)。 |
| **🧠 进程 CPU 监控** | 实时获取指定进程的 CPU 占用率，超过阈值 (80%) 告警。 |
| **💾 进程内存监控** | 监控进程物理内存占用，超过阈值 (1.6GB) 告警。 |
| **📂 句柄数监控** | 统计进程打开的文件描述符 (FD) 数量，防止资源耗尽。 |
| **🔌 端口监听监控** | 检查指定的 TCP/UDP 端口是否处于 `LISTEN` 状态。 |
| **📈 系统 CPU 负载** | 获取整个操作系统的 CPU 使用率，超过 90% 告警。 |
| **💿 磁盘空间监控** | 检查指定目录所在磁盘的使用率，防止磁盘写满。 |

## 🛠️ 技术实现

* **语言**: Bash Shell
* **核心命令**: `ps`, `netstat`, `vmstat`, `df`, `awk`, `sed`, `grep`
* **逻辑实现**: 
    * 封装了 `GetPID`, `GetCpu`, `CheckDisk` 等独立函数，模块化程度高。
    * 使用 `awk` 进行文本处理与数值计算。
    * 使用 ANSI 颜色代码或 Emoji 区分正常与异常状态。

## 🚀 如何使用 (How to Use)

1.  **下载脚本**：
    ```bash
    git clone [https://github.com/kinjo886/Linux-Monitor-Tool.git](https://github.com/kinjo886/Linux-Monitor-Tool.git)
    cd Linux-Monitor-Tool
    ```

2.  **赋予执行权限**：
    ```bash
    chmod +x monitor.sh
    ```

3.  **运行脚本**：
    ```bash
    ./monitor.sh
    ```

## 📊 运行结果示例

脚本运行后，将在终端输出如下格式的检测报告：

```text
=== System Monitor Report ===

1. SSH 服务进程状态
✅ Process [sshd] running. PID=7087

2. 进程 CPU 使用率
CPU usage: 0%
✅ CPU usage is normal.

3. 进程内存使用量
Memory usage: 112M
✅ Memory usage is normal.

4. 文件描述符数量
Descriptor count: 64
✅ Descriptor usage is normal.

5. 端口监听状态 (Port 22)
✅ Port 22 is listening.

6. 系统 CPU 负载
System CPU Usage: 5%
✅ System CPU usage is normal.

7. 磁盘空间监控 (/)
Disk usage on /: 45%
✅ Disk usage is normal.

```
## 👨‍💻 作者信息

吴俊 (Wu Jun)

 - Role: C++ Developer / Game Planner

 - Email: 23jwu2@stu.edu.cn

 - More Projects: [访问我的简历主页](https://github.com/kinjo886/JIANLI_CV)

感谢您的观看！如果觉得项目不错，欢迎点一个 Star ⭐️
