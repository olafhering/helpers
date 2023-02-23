#!/bin/bash
set -e
#set -x
#
ignore_revspecs=(
009a3a52791f31c57d755a73f6bc66fbdd8bd76c
017e42540639a46fdf7c7f5ee647e0b7806c9013
01ed100276bdac259f1b418b998904a7486b0b68
0469f2f7ab4c6a6cae4b74c4f981c4da6d909411
046f5756c49106471bc98bd32b87a62d0717ddda
05f04ae4ffcc77cfcda86adc4e2c13aa72143c03
068c38ad88ccb09e5e966d4db5cedab0e02b3b95
07ffaf343e34b555c9e7ea39a9c81c439a706f13
0823570f01989d3703751f66534a138d4fae062e
089fe572a2e0a89e36a455d299d801770293d08f
0a19c8992db834c9c9e28c5633720d994629539d
0ba2fa8cbd29278a180ac90bd66b2c0bbdeacc89
0baedd792713063213f1e2060dc6a5d536638f0a
0c31fa0e66195bc2aacd90fbfc9fac75d0abada3
0f250a646382e017725001a552624be0c86527bf
106b98a5181c1a5831f1fe31d33d17dd1f0e7ae1
10d7bf1e46dc19d964f0f67d2a6d20df907742d1
154fb14df7a3c81dea82eca7c0c46590f5ffc3d2
1561c2cb87ab39400d76998bf7be581c1e57f108
16d083e28f1a4f6deef82be92d6a0f5aa2fe7e08
17b6d51771a15c7d8552c3e855b5862b3dce0977
187c8833def8a191c7f01d7932eac1bd2ab84af1
1982afd6c0582c523970f5426cc1f11ef8ead7bd
1aa8a4184dbde5f50b70b2c706bcfb6b57da9ea7
1c9de08f7f952b4101f092802581344033d84429
1cac8d9f6bd25df3713103e44e2d9ca0c2e03c33
1d044ca035dc22df0d3b39e56f2881071d9118bd
234d01baec5b216b60b560672957470f773ecf78
24764f8d3c316a3c58b51140d8e489e98e7ffdcc
25af9081189b91df003be7e8acbe9b05f9a58c93
260970862c88b4130e9e12be023c7e2c2d37a966
26b516bb39215cf60aa1fb55d0a6fd73058698fa
277ad7d58611b455662f2e3f7bd24ce5bfeb2fdc
27bd66dd6419c45e320f34ed419cd80833de1161
2e2f1e8d0450c561c0c936b4b67e8b5a95975fb7
320af55a930f30ba49d7cd663280d46705e11383
3244867af8c065e51969f1bffe732d3ebfd9a7d2
33b22172452f05c351fd2fa24c28d2e76c7b0692
34ef7d7b9c0422316ee2c34c564b222255c91532
381cecc5d7b777ada7cdf12f5b0bf4caf43bf7aa
3b80b73a4b3de38f72cd79e1a157449917f2bcb5
3be29eb7b5251a772e2033761a9b67981fdfb0f7
3f4a812edf5cb0a50e65fbdfafdb3e688da18f16
40421f38f63764cd41b01c17e2a1fbbe08a1515a
413af6601f7613c07d8c36b57e184d7841ace43a
42dcbe7d8bac997eef4c379e61d9121a15ed4e36
43c075959de3c45608636d9d80ff9e61d166fb21
445caed0213acef29b9d3822b6906f99860ca9ab
4592b7eaa87d3525825d4ab2a35308bcec9e5ff9
45b64fd9f7ae2cce27f85f7f0a7b1fcdd08d06b4
45c38973ed1868b8448079edd48bf24ab8b326fa
46808a4cb89708c2e5b264eb9d1035762581921b
47d3e5cdfe607ec6883eb0faa7acf05b8cb3f92a
4ad81a91119df7c0e868f9e4c82b9159645bc906
4d0b8298818b623f5fa51d5c49e1a142d3618ac9
4da77090b0fcec1aa430e67631a1474343a33738
4e62aa96d6e55c1b2a4e841f1f8601eae81e81ae
4eeef2424153e79910d65248b5e1abf137d050e9
4f532b7f969fcba010703fe21e0a85f662373041
502d2bf5f2fd7c05adc2d4f057910bd5d4c4c63e
50e523dd79f6a856d793ce5711719abe27cffbf2
5182fecc4be8e4ae2e3a3d744b5562a3e74bf2b4
53ca765a041d5a24650d3f01bced791be5d72df7
54163a346d4a0a1b93f2ff6dc1f488419a605fa9
542f25a94471570e2594be5b422b9ca572cf88a1
56b5354fd8f9173de2e1614864e5fb7bec8c50c4
56c134f7f1b58be08bdb0ca8372474a4a5165f31
5905585103276b7c14bb9a7de4b575216cb6dac4
59508b303e4e35de9dd708ec87b1e89b1f3c1616
5974565bc26d6a599189db7c0b1f79eaa9af8eb9
5c8166419acf468b5bc3e48f928a040485d3e0c2
620b2438abf98f09e19802cbc3bc2e98179cdbe2
62fcb99bdf10fed34b4fe6e225489fe4be2d0536
644f706719f0297bc5f65c8891de1c32f042eae5
6470accc7ba948b0b3aca22b273fe84ec638a116
66c03a926f18529c7a404901289e36efed5c0b1e
679008e4bbeb12f4905ee0820cd2d0b9d4a21dbb
67b0ae43df179fb095f32a011446e7a883758877
6bf625a4140f24b490766043b307f8252519578b
6c0eb5ba3500f6da367351ff3c4452c029cb72fa
703f7066f40599c290babdb79dd61319264987e9
70594e8bed7f1fc53c52ee639ce60c4ba4dd2ecc
72167a9d7da2c295caf1d4a2d58128406786505d
7321f47eada53a395fb3086d49297eebb19e8e58
73aa29a2b119619bbc1db87e8a8103f4b7e5a5db
7462494408cd3de8b0bc1e79670bf213288501d0
77c3323f487512fd587074280e7fb46089cb50b4
79033bebf6fa3045bfa9bbe543c0eb7b43a0f4a3
7938f4218168ae9fc4bdddb15976f9ebbae41999
79661c3766f878aa9b4e20b4f2f8683431e5ec01
7c4e983c4f3cf94fcd879730c6caa877e0768a4d
7d5e88d301f84a7b64602dbe3640f288223095ea
82c1ead0d678af31e5d883656c12096a0004178b
86c8fb4d228ed8dbe17b1abd664888bc7ee0052a
8ab59da26bc0ae0abfcaabc4218c74827d154256
8b9e13d2de73b5513c2ceffe0f62eab40206a126
8d69d008f44cb96050c35e64fe940a22dd6b0113
8f014550dfb114cc7f42a517d20d2cf887a0b771
9167fd5d5549bcea6d4735a270908da2a3475f3a
919f4ebc598701670e80e31573a58f1f2d2bf918
9442f3bd9012f37ba2b4ec3ab2d7c248b137391c
978b57475c7795824676122acb75a1dea264b6d1
99b48ecc8e800983b6e00a2350daaeceba1f7406
9c52f6b3d8c09df75b72dab9a0e6eb2b70435ae1
9e2715ca20d7b540a271464b3ac862cf387935c1
9eb41c521465f62332dfddcd399412fdff9c062b
9ff5e0304e949a8a4e584c8c2b11fad9b2e0b133
a0ab5abced550ddeefddb06055ed60779a54eb79
a0dd008fe9b2f536aabb1ac2cfa4eee44734beab
a1ec661c3fdc8177a8789a9528d5bcfe0d9fc8a8
a3e230926708125205ffd06d3dc2175a8263ae7e
a60b3c594ef3221275d4fa8aa94e206607ea66f3
a6b94c6b49198266eaf78095a632df7245ef5196
a7ef9b455c7ca8f07a5b4bd967a3c39c7434d43f
a921cf83cc4c927f29eef1e7a17bff176c74b886
a9f08ad7adb3d2f90e11efbb40a1246ef95b0c04
aafa97fd1c01bc82c1f288bf1f27e8e1bdc36a3e
ac6811a9b36f3ceb549d8b84bd8aeedf6026df02
adc43caa0a25746e1a9dabbab241abd01120dbfe
aee738236dca0d0870789138ec494e15d6303566
afaf0b2f9b801c6eb2278b52d49e6a7d7b659cf1
b0a4ab7ca4ce993d1cc51cbc85e9f341c729a3d4
b0cce4f6fe6633546bbe5ca04f965f76948e2f34
b187038b5e3f8404dbafce89fd169e66fe604df4
b3646477d458fbe7694a15b9c78fbe2fa426b703
b4128000e2c9b176a449d748dcb083c61d61cc6e
b415d8d417bbe5403626b74e1041101ac23d602f
b48b89f9c189d24eb5e2b4a0ac067da5a24ee86d
b5aead0064f33ae5e693a364e3204fe1c0ac9af2
b6c2c22fa7012616b3039c9f559bf01195137b9d
b707b89f7be36147187ebc52d91c085040c26de9
b80a92ff81587c556da740e9073821b5c3c23b72
bb53ecb4d6ea453e55a971295e55dbf76adc0f8c
bd1ba5732bb954c31e2be07e8ee1397a910835e4
bd38b32053eb1c53ddb7030cf0fc6d700f7f1d82
bf348f667ed36c0799dd6d10adb7be9cdfea48c3
c21d54f0307ff42a346294899107b570b98c47b5
c2b32867f2e7bfa7e7521e417ab8bbd586ac6bcc
c30e9bc8b606077142969a807ada42ca921e605a
c4b4d7047f16a8d138ce76da65faefb7165736f2
c58a318f6090efe06e6702b8882e2026f44f620e
c8064e5b4adac5e1255cf4f3b374e75b5376e7ca
ca5f13a21404f5496bcc006d9416c8bef21b227d
ca7372aca7f4b2f1b29a9941053999d224d1e7c7
cc9cfddb0433961107bb156fa769fdd7eb6718de
ce2196b831b1e9f8982b2904fc3e8658cc0e6573
ce3859172ce09e6ff495290d8ba1d6c7f1a7b207
d2547cf59793168b564372d75620897416cbaf87
d264eb3c14d0e5df49ecab3e8b51caadf78abefa
d2ac25d4196da2ff404c88bec480c835995ea69c
d474d92d70250d43e7ce0c7cb8623f31ee7c40f6
d5ebde1e2b46154d7e03efb1ae3039a304e5386d
d603fd8dd35f6028bb09cd2e9ec6557c4bc0dd95
d66bfa36f9edc5ca8c83206ab39d09091623104e
d786e00d19f9fc80c2239a07643b08ea75b8b364
d8f5537a8816c8f00ea3103e74b65987963a56c6
da6d63a0062a3ee721b84123b83ec093f25759b0
dc2b453290c471266a2d56d7ead981e3c5cea05e
dea6e140d927b8d9b299f972eac5574de71bc75f
dee7121e8c0a3ce41af2b02d516f54eaec32abcd
e0121fa29a7f4fc56cf75f5c6a80c41c7c73f593
e2d8b4289c937447ab710052f15a18f686db73dc
e5dfd093eca01a5d8d967f959a2372d7d82eb59c
e80eec1b871a2acb8f5c92db4c237e9ae6dd322b
e880c6ea55b9805294ecc100ee95e0c9860ae90e
ea8c66fe8d8f4f93df941e52120a3512d7bf5128
eba60ddae794bdefb9531cb08e30c19a0bc53c15
edbe262acf92c986ad9a1f594ae3b4f3d3373133
ee8b7a1156f357613646d6c69d07ac5a087a1071
ef3f3980dedffe124727f7baa1932c8491a911e4
f15756428ded1ee01d95934057a6e89c2d450bbb
f2bc14b69c38b60f201fdf90c08cb2dc8966f331
f4de6a1fa3ee81197239603756fc5c4259e5ef1b
f4fdc0a2edf48f16f7b10cceaf4781fc56ab7fd9
f5714bbb5b3120b33dfbf3d81ffc0b98ae4cd4c1
f69b55efef8406113c52f7494d2669ba9d4958c8
f84fcb66568c0b00626f7f03e28db7d0dcba8098
f97f5a56f5977311f3833056a73cdbb0ee56cb1e
fb2d14add4f813c73bd9d28b750315ccb3f5f0ea
fb3ceec187e8bca474340e361a18163a2e79c0a2
fc08b628d7c96d9a6d6bca488c3fa9c92bee6cc8
fe06a0c09b47ea58ba2b01c8941af16bd45c02df
ffbe17cadaf564b5da0e4eabdcff1b719e184a76
)
trap "echo $0 <opts>" EXIT
unset LANG
unset ${!LC_*}
maj_tag=5
min_tag=3
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
