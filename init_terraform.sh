task=$1
workspace=$2
work_dir=$3
# tfplanfile=$task.$workspace.tfplan
now=`date "+%Y-%m-%d.%H.%M.%S"`
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
log_dir=$work_dir/logs

echo $script_dir
echo $log_dir

# Prepare log folder
if [ ! -d "${log_dir}" ]
then
    mkdir -p $log_dir
fi
log=$log_dir/$task.$workspace.$now.log

if [ ! -d ~/.kube ]
then
    mkdir -p ~/.kube
fi


# Initialize submodule only if directory is empty


cd $script_dir/../kubespray
find `pwd` -maxdepth 0 -empty -exec git submodule update --init --recursive \;
cd $script_dir

# Provision the KVM via Terraform
export TF_LOG="INFO"
export TF_LOG_PATH=$log

cd $work_dir
now=`date "+%Y-%m-%d.%H.%M.%S"`
echo "[$now] Target TF Workspace is: $workspace"
# terraform workspace list
terraform workspace select $workspace
terraform init