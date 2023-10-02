#!/bin/bash
set -e
#set -x
#
ignore_revspecs=(
79519528a180c64a90863db2ce70887de6c49d16
017e42540639a46fdf7c7f5ee647e0b7806c9013
046f5756c49106471bc98bd32b87a62d0717ddda
068c38ad88ccb09e5e966d4db5cedab0e02b3b95
0823570f01989d3703751f66534a138d4fae062e
089fe572a2e0a89e36a455d299d801770293d08f
0ba2fa8cbd29278a180ac90bd66b2c0bbdeacc89
0f250a646382e017725001a552624be0c86527bf
106b98a5181c1a5831f1fe31d33d17dd1f0e7ae1
187c8833def8a191c7f01d7932eac1bd2ab84af1
1982afd6c0582c523970f5426cc1f11ef8ead7bd
1a9df3262a632020071327abf56e9243e4dd7bde
1d044ca035dc22df0d3b39e56f2881071d9118bd
23baf831a32c04f9a968812511540b1b3e648bf5
24764f8d3c316a3c58b51140d8e489e98e7ffdcc
25af9081189b91df003be7e8acbe9b05f9a58c93
260970862c88b4130e9e12be023c7e2c2d37a966
26b516bb39215cf60aa1fb55d0a6fd73058698fa
277ad7d58611b455662f2e3f7bd24ce5bfeb2fdc
2a81ada32f0e584fc0c943e0d3a8c9f4fae411d6
2be1bd3a70c81835b8969216ceedbd017fea732d
320af55a930f30ba49d7cd663280d46705e11383
381cecc5d7b777ada7cdf12f5b0bf4caf43bf7aa
3f4a812edf5cb0a50e65fbdfafdb3e688da18f16
40421f38f63764cd41b01c17e2a1fbbe08a1515a
42dcbe7d8bac997eef4c379e61d9121a15ed4e36
450bdf5bd6c6b78372620da2c32c5a58ab0f124e
45b64fd9f7ae2cce27f85f7f0a7b1fcdd08d06b4
46808a4cb89708c2e5b264eb9d1035762581921b
4d0b8298818b623f5fa51d5c49e1a142d3618ac9
4da77090b0fcec1aa430e67631a1474343a33738
4eeef2424153e79910d65248b5e1abf137d050e9
502d2bf5f2fd7c05adc2d4f057910bd5d4c4c63e
5182fecc4be8e4ae2e3a3d744b5562a3e74bf2b4
53ca765a041d5a24650d3f01bced791be5d72df7
542f25a94471570e2594be5b422b9ca572cf88a1
56b5354fd8f9173de2e1614864e5fb7bec8c50c4
5c8166419acf468b5bc3e48f928a040485d3e0c2
5fbcc6708fe32ef80122cd2a59ddca9d18b24d6e
620b2438abf98f09e19802cbc3bc2e98179cdbe2
62aeaeaa1b267c5149abee6b45967a5df3feed58
62fcb99bdf10fed34b4fe6e225489fe4be2d0536
6470accc7ba948b0b3aca22b273fe84ec638a116
66c03a926f18529c7a404901289e36efed5c0b1e
66c0e13ad236c74ea88c7c1518f3cef7f372e3da
6c0eb5ba3500f6da367351ff3c4452c029cb72fa
703f7066f40599c290babdb79dd61319264987e9
73aa29a2b119619bbc1db87e8a8103f4b7e5a5db
75cff725d9566699a670a02b3cfd1c6e9e9ed53e
77c3323f487512fd587074280e7fb46089cb50b4
79661c3766f878aa9b4e20b4f2f8683431e5ec01
7c4e983c4f3cf94fcd879730c6caa877e0768a4d
7d5e88d301f84a7b64602dbe3640f288223095ea
81d2393485f0990cf6566b0c9e0697c199f68ae5
86c8fb4d228ed8dbe17b1abd664888bc7ee0052a
8ab59da26bc0ae0abfcaabc4218c74827d154256
8afdae83e318f3cfb6eb1ee2ce289356936a663c
8b9e13d2de73b5513c2ceffe0f62eab40206a126
8d20bd6381670382669d9bb39b5fd566a84cdbef
8d69d008f44cb96050c35e64fe940a22dd6b0113
9167fd5d5549bcea6d4735a270908da2a3475f3a
96ec2939620c48a503d9c89865c0c230d6f955e4
9c52f6b3d8c09df75b72dab9a0e6eb2b70435ae1
a0dd008fe9b2f536aabb1ac2cfa4eee44734beab
a6b94c6b49198266eaf78095a632df7245ef5196
a7ef9b455c7ca8f07a5b4bd967a3c39c7434d43f
a9f08ad7adb3d2f90e11efbb40a1246ef95b0c04
adc43caa0a25746e1a9dabbab241abd01120dbfe
aee738236dca0d0870789138ec494e15d6303566
b0a4ab7ca4ce993d1cc51cbc85e9f341c729a3d4
b415d8d417bbe5403626b74e1041101ac23d602f
b48b89f9c189d24eb5e2b4a0ac067da5a24ee86d
b6c2c22fa7012616b3039c9f559bf01195137b9d
b707b89f7be36147187ebc52d91c085040c26de9
bf348f667ed36c0799dd6d10adb7be9cdfea48c3
c30e9bc8b606077142969a807ada42ca921e605a
c58a318f6090efe06e6702b8882e2026f44f620e
ca5f13a21404f5496bcc006d9416c8bef21b227d
ca7372aca7f4b2f1b29a9941053999d224d1e7c7
ce2196b831b1e9f8982b2904fc3e8658cc0e6573
ce3859172ce09e6ff495290d8ba1d6c7f1a7b207
d38213a911c5a5eacd7cc5854c0477d308bef0cb
d474d92d70250d43e7ce0c7cb8623f31ee7c40f6
d603fd8dd35f6028bb09cd2e9ec6557c4bc0dd95
d786e00d19f9fc80c2239a07643b08ea75b8b364
db9cf24cea69773410f0049bdfa795d7c2bd0ea9
dc2b453290c471266a2d56d7ead981e3c5cea05e
dea6e140d927b8d9b299f972eac5574de71bc75f
dee7121e8c0a3ce41af2b02d516f54eaec32abcd
e5dfd093eca01a5d8d967f959a2372d7d82eb59c
e76ae52747a82a548742107b4100e90da41a624d
ea8c66fe8d8f4f93df941e52120a3512d7bf5128
edbe262acf92c986ad9a1f594ae3b4f3d3373133
f15756428ded1ee01d95934057a6e89c2d450bbb
f4de6a1fa3ee81197239603756fc5c4259e5ef1b
f83705a51275ed29117d46e1d68e8b16dcb40507
f84fcb66568c0b00626f7f03e28db7d0dcba8098
fb2d14add4f813c73bd9d28b750315ccb3f5f0ea
fb3ceec187e8bca474340e361a18163a2e79c0a2
fe06a0c09b47ea58ba2b01c8941af16bd45c02df
)
trap "echo $0 <opts>" EXIT
unset LANG
unset ${!LC_*}
maj_tag=5
min_tag=14
kerncvs_branch_script="olh-kerncvs-extract_hyper_v_commits-kerncvs_branch"
tmpdir=
topdir=
kerncvs_branch=
kerncvs_dir=
script_dir=
upstream_git=
upstream_remote=
upstream_branch=
hv_dir=
#
while test $# -gt 0
do
	case "$1" in
		--tmpdir)
		tmpdir=$2
		shift
		;;
		--topdir)
		topdir=$2
		shift
		;;
		--upstream_git)
		upstream_git=$2
		shift
		;;
		--upstream_remote)
		upstream_remote=$2
		shift
		;;
		--upstream_branch)
		upstream_branch=$2
		shift
		;;
		--hv_dir)
		hv_dir=$2
		shift
		;;
		--kerncvs_branch)
		kerncvs_branch=$2
		shift
		;;
		--kerncvs_dir)
		kerncvs_dir=$2
		shift
		;;
		--script_dir)
		script_dir=$2
		shift
		;;
	esac
	shift
done
#
test -n "${tmpdir}"
test -n "${topdir}"
test -n "${upstream_git}"
test -n "${upstream_remote}"
test -n "${upstream_branch}"
test -n "${kerncvs_dir}"
test -n "${kerncvs_branch}"
test -n "${hv_dir}"
test -n "${script_dir}"
#
ignore_revspec="${tmpdir}/.ignore_revspec"
for revspec in ${ignore_revspecs[@]}
do	
	echo "${revspec}"
done > "${ignore_revspec}"
#
exec \
	bash "${script_dir}/${kerncvs_branch_script}" \
		--maj_tag "${maj_tag}" \
		--min_tag "${min_tag}" \
		--topdir "${topdir}" \
		--upstream_git "${upstream_git}" \
		--upstream_remote "${upstream_remote}" \
		--upstream_branch "${upstream_branch}" \
		--kerncvs_dir "${kerncvs_dir}" \
		--kerncvs_branch "${kerncvs_branch}" \
		--hv_dir "${hv_dir}" \
		--script_dir "${script_dir}" \
		--ignore_revspec "${ignore_revspec}" \
		--tmpdir "${tmpdir}"
exit 1
