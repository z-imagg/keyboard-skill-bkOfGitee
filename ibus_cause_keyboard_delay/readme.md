
来自: [ubuntu22.04 ibus导致键盘延时卡顿解决](https://blog.csdn.net/hfcaoguilin/article/details/136247714)


重启ibus-daemon只能暂时解决， ```ibus-daemon -r -d -x ```


重装ibus才能彻底解决: 
```shell
sudo apt purge  ibus -y
sudo apt install -y ibus ibus-pinyin unity-control-center
```


