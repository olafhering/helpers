# used by olh-kerncvs-clone_kerncvs_kernel*.sh
# used by olh-kerncvs-prepare-new-workstation.sh
kerncvs_git_srv=kerncvs.nue.suse.com
kerncvs_git_user=ohering
# prevent dirtying the work tree with __pycache__ directories
export PYTHONDONTWRITEBYTECODE=1
# used by sequence-patch.sh
export SCRATCH_AREA=/dev/shm/SCRATCH_AREA
# used by sequence-patch.sh and tar-up.sh, but extracting from git appears to be faster
export MIRROR=~/work/src/kernel/MIRROR
# used by git_sort
export LINUX_GIT=~/work/src/kernel/LINUX_GIT
# used helpers.rpm
export UPSTREAM_REPOS=~/work/src/kernel/upstream.linux
# used helpers.rpm
export WORK_KERNEL=~/work/src/kernel
# list of branches which still receive updates
kerncvs_active_branches_base=(
SLE12-SP3-TD
SLE12-SP5
SLE15-SP2-LTSS
SLE15-SP3-LTSS
SLE15-SP4-LTSS
SLE15-SP5
SLE15-SP6
SLE15-SP7
)
# list of branches for kernel-azure, which still receive updates
kerncvs_active_branches_azure=(
SLE12-SP5-AZURE
SLE15-SP5-AZURE
SLE15-SP6-AZURE
SLE15-SP7-AZURE
)
