#!/bin/bash
set -e
unset LANG
unset ${!LC_*}
read td < <(mktemp --directory --tmpdir=/dev/shm .XXX)
trap "rm -rf '${td}'" EXIT
export TMPDIR="${td}"
list_of_verified_commits=(
009ad22ebdaea2d14f8ecd95672dbc2517d28126
00ddf7311089ec0e51e393f30a76d0f42c4eced7
0287437b6a2009c9e93c585e56e7d58604ec7f32
05cfb85431568c859a08c58dcb952c7222934283
05d5af7a6c0cb2ae4c0f335296e3ae1d8c28f6d0
0669e11edfca78e8e0c7c6d1238fa00503433f1b
0679ad86df7f92597a3097027cace1a6a516bb55
0aa51320894f8c0a0f8974a115eb0aa043d22249
0cd221a24d9035f1254d76db40b3426cb6ee7d6d
0f290e026b5da1628c1c8330afcc729422b4c48a
0fc0d89662492b1a03c9ab647c6b3530b781721a
138c3b28771cfb08fa89babc2bba283f59d69fc6
14dd5e4d31ce7856409eddc74aec48cadfc1da3a
15d605fee8bc9355d9cc0fb2f0dea9851058d7ea
166ccfae3c6347bae780c5d1e80cd27a7871df8d
167a7e6a373a2be149720f3c62ebec966f92a075
1e2e8f43ffbcab484cd101753e70e52b66283bc5
1f6e38cb0edb0d4a3099f10f07921bbc306c6291
21b286ddb645d311996db968478abadbc285b10e
229b28a333fc00ed9fc0e01845a176d44c676886
239c678f535ade6b0ffdbce66480e981961992db
25014fdcfbf95eb8b7bbfbd4175b7991c8af7a13
27ef00b3dfce4a3ce869e486d7ad21e08d722045
29026399e3ed328aa076de3805c731104c6879db
2a402dfd7eba330d6c63ca488f87e3606e5e013a
2cc0f4326165995caf15eb4612311ba5f329f40b
2ef640cc9efa91c4575974f4fbad70945459ee30
2ff37453528c69868e0daff714a1b314b0b86572
33f1501fcd54175b908dff9ccd477573b80461e3
349448487d694f78228c187da683c5d921cf4fba
3537befd232498b14e9caef9b403be7730453454
353c81dcdbdaf374e2a049b1d16735fc1a56a4bd
354ad99bc468a8115dba83f3064f376347d9cfb3
384e5dd814223de41bb72d1552a55b47965b8ad9
3a507b26dc45e93c5d5b90e1979067b4f51d8e39
3aa747020089c5b81f6f26e8c15490f71a580421
3b337ac5599456eac3eb3cfc4070cb76f29fd49e
3b8ce704bb1b0b486ea2ae6e758346938060b731
3baab0f4a7fc974e673d6c7bc36f261b7b3d20b3
3f5628587659dc0e1457876aac451e019853265d
41306525d0ee81e294c730056310f4f3ff5da852
42410b3106954b309b30192171d183270a6400e6
43a4c0ffa299b1071f9d26e743524d9d8a841973
43afe7ad6651cb5e2beff94ad943710bd17ab6d0
445f0dbc125c5ef2f3784d29a6f764f251ceb57d
45dce7b6599733a5c00bbcae0d729848fd3ee131
47becc8140306eb1e75bbfe88b48c7ed5cb483e3
48423a6a3600589c30c5653df9a533d158aa1006
4885a5356ac5a054ffa9c612de30a2e20dd44ba5
4957527300b50ff82cc84e5e777be4fd0837e294
51e18b8b16b81a6cf0845fbb6bfe7b566588fc72
55f9e30663704306698c66437e7dbb2386b5d9e4
5621bfb492b339984ebae2db70aa93cb7c27628a
56e8327bac3f5af08a687f39b633ee0843601683
57586e63b7f7f1f91c3b5e41483bbbb6b2ee04d7
57b4f6f9220efe8710f88ae5f667bcd73ce47b1d
586602b6319f37754ed75adb608c42c95171b0b6
590a26521179b1ca08a1f05bebec0aee9f04c917
59f8b791d882dcf931cee4ae6b30a2275be8f5e5
5f593c2004ec7d3ab7a3e996eae956fcc0ea3891
5f5fb55d9500123c4c31bbe499bfc82a74a2049d
60319685a78fdb533e9edf42e409f281675eead4
60ca8fc65300aa9e76ee15d55475a9ef9443f516
61daaca19342993172dc6c36e1b806cf1152d613
65bfeef7b758f17561394418e7870d7befa1dabe
669f38b23578f530954a66c79ca149dd01f2a1ea
670d05cd81afdee92af5e0463e0ef95e06baf9f8
67ef5e4955cfee8a0fe4a445600706c58861ccf4
6bc52f13e7fc4cd8d63dbdb694719d34684e46eb
6d6451af2bd13aa684971cb689cb5f20728b3fba
6e96a7de2900c315457b0836691c6673dccdd171
712844db2ba361b161bafb02d92e974d764c9b5e
73d49c79026b9253a134b94e9964f16ddc2cabb3
745e1f508d5b991e41a17a1cda879068194d1921
7572520bad3671c819b7f95b82635554dd929aa2
75fb32d34ca56ba53167edb44ce439cfe4ba8a03
76879bd32002bd20c5f2fe8dd280142c182e049e
78ce6d46d607d591735d6e64ad3561d93e6374f1
794b18b1adbcd143a82702892bd2816f163eeb2e
7b0f6c81da9a5bf788a350e12955c20c93a9db44
7e8de6e0c259613e111deb6c57d34448569e3c5b
7ee5d893801250375f23f6e07f63dfc2378b5dc4
81484a797f72d687802058b43636fda3503d839c
83c0c6b51d512e935b9a7a2d3142b856d48b2e82
85e7716e0aa3d0cc65f1a050a87dc8c80a55ec09
8638283570e3409279f443994b03e923dffe0dc7
880c76899eacc36ce2f3c22d75c7e0098fc26f18
883f3483e08e6dbe7f9a83c2008c6ec609275c09
88959bd396700d2f9ac02686920dd98962cf7f05
8a5b04f3f5b1d8d68bf8b5dbb232ccfce5ec3842
8fa306690f3a2397a832d25fcbdfefa7d1f3b4a0
901d628c47dd14ef5e071914a28cceb49b842bb1
91405b382c4e8d434fc807658d7ef9c0374875ba
97743902235a4df3adcdc5d58e0681bd263c50b1
97a1c36179922941a3d6e6ade7d2e11a0705518d
97f5298e096e16cbfecc2f572238f4f8fef3a330
9877b47b4a7ba002a3476265ed481c0b7cf1b3e9
9987210eb51275a2b6b2999a1842bbc96fdc758e
9b5c31876c5ad1f72d25896d902664beba18e032
9b7b5dae6cc6f01fe62fb31b94e9be3963bb04e7
9d2baa3db68c394241e9dfabdfb59b22f3341a94
9e0897f67f98606dbdc7e5c056f39714e5903365
9e8ff3ae18a6939f83aead79db932dd7870c8cb4
a12d3b0a62595ce8248ef1bd294c9d39872a3685
a671036a7ea3de8986b1d1bd5102e29501b633ce
aa6f7bbcc412ef5cf47d9ef9fc07172e9f06d7fb
aab2ec8bfa47426e6e7fef243d66f841d6b9f2f6
ac2f01a699bb4089c65f90caca945ec30cd3ef61
acbcd1421d9960aa7d01f84a9ebd658d0f0d473d
aebc07ddc33ed248aaee11040c862895722f86fe
af404ab3427e4ad38dd1000635e3684b1b748bb2
af543c566d675002399dbdcf4b3976e0e9c975ba
b15cab4d1f098b9fd695eba5de31a12ef3413cce
b1baa10b7107b365ca0869f4fbedb356967d2a42
b2334d0738c141fba3cf6fb9fa0b62e585fd6df4
b235394bf2037df9f56f6607125209ebbd355c7c
b7c2e538450c401e3a7e36418e9ca456b7780898
b8e12e82848e6c93bdf2b437f0ae0accce35e2da
b9e921214168506333dd81b0d917211f4058181e
ba2f81d0ba1ad117dc6a5494a21d358f354126d7
ba310f40eda6a244194ba368e9c52020721fbb53
bb7931078a2e6f1c2e353e287c303be9f11d7f52
bc0282d9aa356bc81c2b252b4467ac067c9bd335
bc461638753d74105a5e7ee71e91e74957f2d398
be60ac842907c5353f0049b1dc467b7d307df07d
be9646a98f6872fbb501a14ddd161dad7d7735df
bec00bad9ae1e7ec3cfbc9c69a335ed3cc9ca6e8
bfe7b8a9cb0c739683fabed8820fbfdb2af64191
c10ad793c83fd41fe56a384dc95927280f5c4846
c1ad4698610f10b6be46a5ce4e73daffcc01ae13
c24b756f413d72f12dadc7035f0ac298a62ae4cd
c37fb9c42d0826fe6f8be7629accfa2a316b9735
c52ca0cea83b0583726da8729abcf8efc2d22694
c60a6f929eda77004fdb9f32b0719b8b35e15e61
c6756d62c295698b961534419377cda21633b5f9
ca5e532d4b30d016cbb8c37e46af719d171ba455
cbefee994c9296e01b58158c28e1fbf8fcfba2d5
cd464d4f8407e717c24991f3a089852de58a4ace
cea9fda0711acba1a80cb41ba308ad8e02367c38
cf3087512c483533aeea4bc2d99dbbd801ccbf19
cf6f2e886125df53d775ef7641fdaac62e46a31c
cf7ca2b152116cc8fda646ef88dfd9153dce4ae2
d1df83c4ec783b8836eb12cc3460b7435de4c3d9
d1e91629623c4c70d937f694447aaa2472e46c24
d2024566ca6c5fd36e83f2ae23233e163caab825
d3ae0faaf53291c1898553fc6758d1411a509a46
d3c568d028e5a2fb5523fad3152c5f80a4c32926
d4184eae67e57c8f26069c94b18e69afc47b8882
d6941da504df6c49e4ca97da668eeb0f673e7d36
d89bf70101caec5b39b757bbd95d005a7fd60a4c
d8a72f0491de73e32cb6dcfedb1980f466f34955
dacd37346f370b885318db6fa6b00b7d629ffdc8
dad4f98c10051691aabcacb1f42c02685a0c7105
e0e4e52d8ffc81017e5c85b47a74824216759e7d
e29eea4ce38ccb4baedea00e0564fef3c7c6ca7a
e2bff589a18b69ab1f06ce194ec03d7dbef65555
e33600536945cf6015ab20a58b8c578fe836b3f3
e379993ea5ac1e3dad6a489cbcbba8e186c23a0c
ed4beb83eadb88ca454d9b3941e47a421eace28e
ed8f9b8456d8ae32f273800456f8fa8b8fcf8187
ef9d4ad90d8b97301f60ae51312e44e64f409646
f261726a184ff30cbcd8b25bb30400aace2c8255
f30b8bc5dbe63827598d96fea82cdbb8c635f9a5
f3a9e005e4c1db6e2fc78cf96ebf9d87a8733ad2
f41e597c805dd5e38b05d1d8f8d024a008a6a221
f4ed3d1dd0f504a52ca7d78bc4370e4cecc0b190
f518dc2030edfebe496f591a92436b2b34b8243b
f81196ef395533acca027003b83a0e0b794b3c51
f8319f5923b6b1fd35fe3ae565b60cbbfb2eff77
fadb057a04698d9f3ec176385a09b83ad9208970
fc1ced001356e4a237e74fb95c2629be92f47776
ff47b5d77f6a8c1c2ec1fb4f31915b62dea4d3dc
)
declare -A already_verified_commits
declare -a tags
declare -a top_dirs
declare -a rpm_dirs
top_dirs=(
SUSE/Products/SLE-Module-Development-Tools-OBS
SUSE/Products/SLE-Module-Public-Cloud
SUSE/Updates/SLE-Module-Development-Tools-OBS
SUSE/Updates/SLE-Module-Public-Cloud
SUSE/Updates/SLE-SERVER
)
updates_suse_com_dir=$1
kernel_source_git_dir=$2
verified_commits_output=$3
list_kernel_binaries="${td}/list_kernel_binaries"
list_git_revision_kernel_binary="${td}/list_git_revision_kernel_binary"
list_verified_commits="${td}/list_verified_commits"
err_exit() {
	echo "$@"
	cat <<_EOH_
Usage: $0 <updates.suse.com-dir> <kernel-source.git-dir> <output-file>

${0##*/} /RMTData/repo ~/work/src/kernel/kerncvs.kernel-source.bare.mirror /dev/shm/\$\$
_EOH_
	exit 1
}
if test -e "${verified_commits_output}"
then
	err_exit "output file exists: ${verified_commits_output}"
fi
if test -z "${verified_commits_output}"
then
	err_exit "output file for verified commits missing"
fi
>> "${list_verified_commits}"
>> "${verified_commits_output}"
#
for rev in ${list_of_verified_commits[@]}
do
	already_verified_commits[${rev}]="${rev}"
done
#
pushd "${kernel_source_git_dir}" > /dev/null
popd > /dev/null
pushd "${updates_suse_com_dir}" > /dev/null
for i in ${top_dirs[@]}
do
	rpm_dirs+=( $(ls -1d "${i}"/{12-SP5,15*}/*/product/{aarch64,x86_64} "${i}"/{12-SP5,15*}/*/update/{aarch64,x86_64} 2>/dev/null || :) )
done
#
echo "Searching in ${#rpm_dirs[@]} directories ..."
test ${#rpm_dirs[@]} -gt 0
find "${rpm_dirs[@]}" -xdev -name 'kernel-azure-?.*64.rpm' -exec /usr/bin/readlink -f '{}' + > "${list_kernel_binaries}"
wc -l "${list_kernel_binaries}"
popd > /dev/null
#
while read
do
	read rev < <(rpm -qpi "${REPLY}" | awk '/^GIT Revision:/{print $3}')
	echo "${rev} ${REPLY}" >> "${list_git_revision_kernel_binary}"
done < <(sort "${list_kernel_binaries}")
wc -l "${list_git_revision_kernel_binary}"
#
pushd "${kernel_source_git_dir}" > /dev/null
#
while read rev filename
do
	test -n "${already_verified_commits[${rev}]}" && continue
	rev_has_tag=
	rev_merged_into_azure=
	tags=( $(git --no-pager tag --points-at "${rev}") )
	if test ${#tags[@]} -gt 0
	then
		rev_has_tag='rev_has_tag'
	else
		echo "NO_TAGS: ${rev} ${filename}"
	fi
	in_embargo=
	in_azure=
	branches=( $(git --no-pager branch --all --contains "${rev}" | sed 's@^[^/]\+/[^/]\+/@@' | sort -u ) )
	for branch in ${branches[@]}
	do
		case "${branch}" in
		users/*) ;;
		*-AZURE_EMBARGO) in_embargo='in_embargo' ;;
		*-AZURE) in_azure='in_azure' ;;
		*) echo "UNKNOWN_BRANCH: ${branch} ${rev} ${filename}" ;;
		esac
	done
	if test -n "${in_azure}"
	then
		: good
		rev_merged_into_azure='rev_merged_into_azure'
	elif test -n "${in_embargo}"
	then
		echo "ONLY_EMBARGO: ${rev} ${branches[@]} ${filename}"
	fi
	if test -n "${rev_has_tag}"
	then
		echo "${rev}" >> "${list_verified_commits}"
	fi
done < "${list_git_revision_kernel_binary}"
while read
do
	test -n "${REPLY}" && git --no-pager log --oneline "${REPLY}^!"
done < <(sort -u "${list_verified_commits}" | tee "${verified_commits_output}")
#
wc -l "${verified_commits_output}"
