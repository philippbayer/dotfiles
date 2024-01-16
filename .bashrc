
# test if the prompt var is not set and also to prevent failures
# # when `$PS1` is unset and `set -u` is used
if [ -z "${PS1:-}" ]; then
  # prompt var is not set, so this is *not* an interactive shell
  return
fi

test -s ~/.alias && . ~/.alias || true
alias ls='ls --color'
alias less='less -n'
alias cp="cp -i"
alias ll='ls -lahtr'
alias topme="squeue -u pbayer | tr -s ' ' | sed 's/ /\t/g'"
alias topme2="sacct -u pbayer |  tr -s ' ' | sed 's/ /\t/g'"
alias topmelong="squeue -u pbayer -o '%.18i %.9P %.70j %.8u %.2t %.10M %.6D %R' |  tr -s ' ' | sed 's/ /\t/g'"
alias qstat='scontrol show job'
alias cdebi='cd /scratch/pawsey0390/pbayer'

export GEM_HOME='/home/pbayer/.gem/'
export PATH="$GEM_HOME/bin:$PATH"

#export PERLPATH=$PERLPATH:/home/pbayer/perl5/lib/perl5/x86_64-linux-thread-multi/

function topme3() {
    if [ ! -z "$@" ];
    then
       export arg="$@"
    else
       export arg='last month'
    fi
    sacct -S `date --date "$arg" +%Y-%m-%d` -o "Submit,JobID,JobName,Partition,NCPUS,State,ExitCode,Elapsed,CPUTime,MaxRSS"
}


function curlUp() {
    curl -T "$@"  --user 'philipp.bayer@uwa.edu.au' https://cloudstor.aarnet.edu.au/plus/remote.php/webdav/
}

function curlList() {
 curl -X PROPFIND --user "philipp.bayer@uwa.edu.au" https://cloudstor.aarnet.edu.au/plus/remote.php/webdav/ | grep -Po '(?<=/plus/remote.php/webdav/).+?(?=<)'
 }

function touchAll() {
    for l in $(find . -printf "%T@ %Tc %p\n" | sort -n | cut -f 7 -d ' '); do touch $l; sleep 0.1; done
}


source /software/projects/pawsey0149/groupEnv/ivec/myProfile.txt

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/software/projects/pawsey0390/pbayer/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/software/projects/pawsey0390/pbayer/conda/etc/profile.d/conda.sh" ]; then
        . "/software/projects/pawsey0390/pbayer/conda/etc/profile.d/conda.sh"
    else
        export PATH="/software/projects/pawsey0390/pbayer/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=/software/projects/pawsey0390/pbayer/screen/bin:$PATH

alias getnode='salloc -p debug --nodes=1 --ntasks=32 --cpus-per-task=1 --mem=58G'
alias getgpunode='salloc -p gpu-dev --nodes=1 --gpus-per-node=1 --account=pawsey0812-gpu'

module load singularity/3.11.4-nompi
