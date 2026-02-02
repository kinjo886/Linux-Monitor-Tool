# 获取指定用户的指定进程PID
function GetPID() {
    PsUser=$1
    PsName=$2
    pid=$(ps -u $PsUser | grep $PsName | grep -v grep | sed -n 1p | awk '{print $1}')
    echo $pid
}

# 获取进程CPU使用率
function GetCpu() {
    CpuValue=$(ps -p $1 -o pcpu | grep -v CPU | awk '{print $1}' | awk -F. '{print $1}')
    echo $CpuValue
}

# 检查进程CPU是否超80%
function CheckCpu() {
    PID=$1
    cpu=$(GetCpu $PID)
    echo "CPU usage: $cpu%"
    if [ "$cpu" -gt 80 ]; then
        echo "⚠️ CPU usage is high!"
    else
        echo "✅ CPU usage is normal."
    fi
}

# 获取进程内存使用量（单位MB）
function GetMem() {
    MEMUsage=$(ps -o vsz -p $1 | grep -v VSZ)
    (( MEMUsage /= 1000 ))
    echo $MEMUsage
}

# 检查进程内存是否超1.6GB
function CheckMem() {
    PID=$1
    mem=$(GetMem $PID)
    echo "Memory usage: ${mem}M"
    if [ "$mem" -gt 1600 ]; then
        echo "⚠️ Memory usage is high!"
    else
        echo "✅ Memory usage is normal."
    fi
}

# 获取进程句柄数
function GetDes() {
    DES=$(ls /proc/$1/fd 2>/dev/null | wc -l)
    echo $DES
}

# 检查句柄是否超900
function CheckDes() {
    PID=$1
    des=$(GetDes $PID)
    echo "Descriptor count: $des"
    if [ "$des" -gt 900 ]; then
        echo "⚠️ Descriptor usage is high!"
    else
        echo "✅ Descriptor usage is normal."
    fi
}

# 检查端口是否监听
function Listening() {
    port=$1
    TCPListeningnum=$(netstat -an | grep ":$port " | awk '$1=="tcp" && $NF=="LISTEN"' | wc -l)
    UDPListeningnum=$(netstat -an | grep ":$port " | awk '$1=="udp" && $NF=="0.0.0.0:*"' | wc -l)
    (( Listeningnum = TCPListeningnum + UDPListeningnum ))
    if [ "$Listeningnum" -eq 0 ]; then
        echo "❌ Port $port is NOT listening."
    else
        echo "✅ Port $port is listening."
    fi
}

# 获取系统CPU占用率
function GetSysCPU() {
    CpuIdle=$(vmstat 1 5 | sed -n '3,$p' | awk '{x += $15} END {print x/5}' | awk -F. '{print $1}')
    CpuUsage=$(echo "100 - $CpuIdle" | bc)
    echo $CpuUsage
}

# 检查系统CPU占用率
function CheckSysCPU() {
    cpu=$(GetSysCPU)
    echo "System CPU Usage: ${cpu}%"
    if [ "$cpu" -gt 90 ]; then
        echo "⚠️ System CPU usage is high!"
    else
        echo "✅ System CPU usage is normal."
    fi
}

# 检查指定目录磁盘空间
function CheckDisk() {
    Folder=$1
    DiskSpace=$(df -h "$Folder" | awk 'NR==2 {print $5}' | awk -F% '{print $1}')
    echo "Disk usage on $Folder: $DiskSpace%"
    if [ "$DiskSpace" -gt 90 ]; then
        echo "⚠️ Disk usage is high!"
    else
        echo "✅ Disk usage is normal."
    fi
}

# 主程序入口示例
echo "========= System Monitor ========="
USERNAME="root"
PROCNAME="sshd"
PORT=22
CHECK_DIR="/boot"

PID=$(GetPID $USERNAME $PROCNAME)

if [ "-$PID" == "-" ]; then
    echo "❌ Process [$PROCNAME] not found for user [$USERNAME]"
else
    echo "✅ Process [$PROCNAME] running. PID=$PID"
    CheckCpu $PID
    CheckMem $PID
    CheckDes $PID
fi

Listening $PORT
CheckSysCPU
CheckDisk $CHECK_DIR
echo "========= Done ========="

