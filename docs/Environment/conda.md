# Conda

Conda是一个包和环境管理工具。包管理工具是一个用来自动化安装、升级、删除packages的工具。

# Miniconda 安装
Miniconda本质上是一个用来安装空的conda环境的安装器，它仅包含Conda和Conda的依赖。
[Quick command line install](https://docs.conda.io/projects/miniconda/en/latest/)
## Linux
```
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
```
## MacOS
```
mkdir -p ~/miniconda3
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
```

# 常用命令
```shell
# 创建环境
conda create --name llm
conda create --name llm python=3.11
# 查看环境
conda env list 
conda info --envs
# 激活环境
conda activate <env_name>
# 退出环境
conda deactivate
# 导出环境安装包列表
conda list --explicit > requirements.txt
# 
conda create --name <env_name> --file requirements.txt
# 安装软件包
conda install <package_name>
conda install curl=8.4.0
# 查看已安装包
conda list
# 搜索包
conda search <package_name>
# 更新包
conda update <package_name>

# 删除环境
conda remove --name env_name --all
```
