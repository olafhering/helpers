#!/bin/bash
set -e
#set -x
#
ignore_revspecs=(
009a3a52791f31c57d755a73f6bc66fbdd8bd76c
00f54e68924eaf075f3f24be18557899d347bc4a
013cc6ebbf41496ce4badedd71ea6d4a6d198c14
017e42540639a46fdf7c7f5ee647e0b7806c9013
019b9781ccd667d4160f3636c8735e3baa085555
01ed100276bdac259f1b418b998904a7486b0b68
039642574cc4ff77b1c8ca042c879fa6995ce154
03b2a320b19f1424e9ac9c21696be9c60b6d0d93
0469f2f7ab4c6a6cae4b74c4f981c4da6d909411
046f5756c49106471bc98bd32b87a62d0717ddda
05f04ae4ffcc77cfcda86adc4e2c13aa72143c03
06028d15177a1b406b7b075ea47c6a352732f23a
062a5c4260cdb734a4727230c58e38accf413315
066f3377fb663f839a961cd66e71fc1a36437657
068c38ad88ccb09e5e966d4db5cedab0e02b3b95
07136793ccad877727afada2b0c926031f10cf52
07ffaf343e34b555c9e7ea39a9c81c439a706f13
0807892ecb35734b7ce6f7c29b078f1b60151c94
0823570f01989d3703751f66534a138d4fae062e
0854fa82c96ca37a35e954b7079c0bfd795affb1
089fe572a2e0a89e36a455d299d801770293d08f
08a800ac257a2eeed1fad34b55ed55b2578e9b4e
095cf55df715d14d5dad75326faf5984e7fc0b3a
0a19c8992db834c9c9e28c5633720d994629539d
0adcdbcb179624d7b3677264f2cd228e7d89eea9
0b0226be3a52dadd965644bc52a807961c2c26df
0b0a31badb2d98967175c6812ac81db20f9a67fc
0ba2fa8cbd29278a180ac90bd66b2c0bbdeacc89
0baedd792713063213f1e2060dc6a5d536638f0a
0c31fa0e66195bc2aacd90fbfc9fac75d0abada3
0cc4f6d9f0b9f20f3f1e1149bdb6737c0b4e134a
0cdeabb1186fc3a6c7854f05cec7c99e32935ebc
0d9138ffac24cf8b75366ede3a68c951e6dcc575
0d9c055eaaf41bebb0e6b095fff447523121fad3
0f250a646382e017725001a552624be0c86527bf
106b98a5181c1a5831f1fe31d33d17dd1f0e7ae1
108b249c453dd7132599ab6dc7e435a7036c193f
108ddb8fa1fc310be4a6bd1e308bca62821ee8b5
10d7bf1e46dc19d964f0f67d2a6d20df907742d1
10f91c73cc41ceead210a905dbd196398e99c7d2
12aa7469d101e139b3728e540884bc7d72dca70a
12cc1c7345b6bf34c45ccaa75393e2d6eb707d7b
12e0c6186ba44bb6194cf5d2eda8f46880126587
1330fc35327f3ecdfa1aa645e7321ced7349b2cd
135db384a2efde3718fd551e3968e97fcb400c84
142c95da92e847312f4d32cc8870719fe335d121
14a1eaa8820e8f3715f0cb3c1790edab67a751e9
154fb14df7a3c81dea82eca7c0c46590f5ffc3d2
1561c2cb87ab39400d76998bf7be581c1e57f108
16d083e28f1a4f6deef82be92d6a0f5aa2fe7e08
1779a39f786397760ae7a7cc03cf37697d8ae58d
17b6d51771a15c7d8552c3e855b5862b3dce0977
183b8021fc0a5fadecdf9c0ccac1f48b5c326278
18659a9cb1885d00dd428f8857f7f628e54a45ee
186f43608a5c827f8284fe4559225b4dccaa49ef
187c8833def8a191c7f01d7932eac1bd2ab84af1
1982afd6c0582c523970f5426cc1f11ef8ead7bd
1998fd32aa62fbf22cd1d8258e6a9deffd6bc466
199b5763d329b43c88f6ad539db8a6c6b42f8edb
19b5e6659eaf537ebeac90ae30c7df0296fe5ab9
1a33e10e4a95cb109ff1145098175df3113313ef
1a9df3262a632020071327abf56e9243e4dd7bde
1aa8a4184dbde5f50b70b2c706bcfb6b57da9ea7
1ac1b65ac199205724a8077d37ba7e64a1b7e77c
1b74dde7c47c19a73ea3e9fac95ac27b5d3d50c5
1c3a044c6013b7fcf4738129a1141c9c1994bb86
1c5fae9c9a092574398a17facc31c533791ef232
1c9de08f7f952b4101f092802581344033d84429
1cac8d9f6bd25df3713103e44e2d9ca0c2e03c33
1d044ca035dc22df0d3b39e56f2881071d9118bd
1d3c9c075462e9c5a474248e4b433861572f33e9
1dc2f2b81a6a9895da59f3915760f6c0c3074492
1f4b34f825e8cef6f493d06b46605384785b3d16
2025cf9e193de05b0654570dd639acb49ebd3adf
202818e1c8519ee301e930484707d7ddace639e0
20c89a559e00dfe352b73e867211a669113ae881
20c8ccb1975b8d5639789d1025ad6ada38bd6f48
20cf6616ccd50256a14fb2a7a3cc730080c90cd0
213ff44ae4eb5224010166db2f851e4eea068268
2141a8457f16bac72ef4b4c38885612d1f2232cb
214ff83d4473a7757fa18a64dc7efe3b0e158486
2194c2eb6717f2ea7dc793ad9cbf44d359a3f696
2258954234db7530e9d86bb32cd6ad54485ff926
22ef7ee3eeb2a41e07f611754ab9a2663232fedf
234d01baec5b216b60b560672957470f773ecf78
23a3b201fd187f1e7af573b3794c3c5ebf7d2c06
24196f0c7d4bba093dfa8074507f31509970319f
24764f8d3c316a3c58b51140d8e489e98e7ffdcc
254272ce6505948ecc0b4bf5cd0aa61cdd815994
25af9081189b91df003be7e8acbe9b05f9a58c93
25bfa956561fb47141b8cc382e69a1f674a27eb0
26011267e1a7ddaab50b5f81b402ca3e7fc2887c
260970862c88b4130e9e12be023c7e2c2d37a966
26b516bb39215cf60aa1fb55d0a6fd73058698fa
277ad7d58611b455662f2e3f7bd24ce5bfeb2fdc
27bd66dd6419c45e320f34ed419cd80833de1161
2a3d4eb8e228061c09d5ca8bf39e7f00c2091213
2a81ada32f0e584fc0c943e0d3a8c9f4fae411d6
2bc39970e9327ceb06cb210f86ba35f81d00e350
2be1bd3a70c81835b8969216ceedbd017fea732d
2c76e7f6c42bcee0e25194b54140cbce866d191a
2cefc5feb80cf4237890a6a4582a0d20e50d9ced
2d35c66036b2494c329a32468c85405493370e75
2e2f1e8d0450c561c0c936b4b67e8b5a95975fb7
2f23e5cef31414156c24b90e56dedc118feb9bf3
2f9f5cddb29b4fbdf2d328c7a6326d53227e6329
3019270282a175defc02c8331786c73e082cd2a8
30a9c246b9f6fe0591e8afb05758a3e3b096fabe
320af55a930f30ba49d7cd663280d46705e11383
3244867af8c065e51969f1bffe732d3ebfd9a7d2
32ef5517c298042ed58408545f475df43afe1f24
33a65ba470c2b7031e513f7b165e68f51cfc55eb
33b22172452f05c351fd2fa24c28d2e76c7b0692
341b4a7211b6ba3a7089e1dc09ac4bd576dfb05f
345f0254e5b2f4090e4a00ebc996e07e9bdcd070
34bc3560c657d3d4fb17367ed9bfda803166dce0
34ef7d7b9c0422316ee2c34c564b222255c91532
3619350cf0d630d83dedd9c0d7d297da211f5ff0
366c5aa18c128966b1768805cb69e40bb92e9664
37b96a4931dba07cebbf07092e55d1562155412b
37df9f3fedb6aeaff5564145e8162aab912c9284
381cecc5d7b777ada7cdf12f5b0bf4caf43bf7aa
382a46221757250966621f046e91d8c05adac12b
39b759cad5da88ee8ac55e186a00da4692b44e17
3a025de64bf89c84a79909069e3c24ad9e710d27
3a0e7731724f6ac684129f1763eef4d2d3e7dec7
3a37a9636cf3a1af2621a33f7eef8a2a3da81030
3ae0ed376d1c2981715c540ba7ad3bf43fec244c
3b20eb23724d493eca79f02b1e062bd5432e29d0
3b4477d2dcf2709d0be89e2a8dced3d0f4a017f2
3b80b73a4b3de38f72cd79e1a157449917f2bcb5
3b9c1d377d67072d1d8a2373b4969103cca00dab
3be29eb7b5251a772e2033761a9b67981fdfb0f7
3c37f3573508937475d62396149df93ec24e71eb
3d6357de8aa09e1966770dc1171c72679946464f
3ee098f96b8b6c1a98f7f97915f8873164e6af9d
3f2baa8a7d2efaa836f1dc4b8ee8c3ca4ba9e101
3f4a812edf5cb0a50e65fbdfafdb3e688da18f16
3f5ad8be3713572f3946b69eb376206153d0ea2d
3f74957fcbeab703297ed0f135430414ed7e0dd0
40421f38f63764cd41b01c17e2a1fbbe08a1515a
413af6601f7613c07d8c36b57e184d7841ace43a
4289696863cc320e5fe573df5ad7800701751599
42ab19ee90292993370a30ad242599d75a3b749e
42dcbe7d8bac997eef4c379e61d9121a15ed4e36
43aa31327bb36002f52026b13d5f1bde35a1fc14
43b5169d8355ccf26d726fbc75f083b2429113e4
43c075959de3c45608636d9d80ff9e61d166fb21
4447ac1195a845b18f2f427686f116ab77c5b268
445caed0213acef29b9d3822b6906f99860ca9ab
447ae316670230d7d29430e2cbf1f5db4f49d14c
44883f01fe6ae436a8604c47d8435276fef369b0
450bdf5bd6c6b78372620da2c32c5a58ab0f124e
452a68d0ef341c4d544757e02154788227b2a08b
458c4475be9ae42e248963b2db732266d40408b7
4592b7eaa87d3525825d4ab2a35308bcec9e5ff9
45b64fd9f7ae2cce27f85f7f0a7b1fcdd08d06b4
45c38973ed1868b8448079edd48bf24ab8b326fa
45ea83f02dc090c477261ac6c93aa2097edca601
46808a4cb89708c2e5b264eb9d1035762581921b
47d3e5cdfe607ec6883eb0faa7acf05b8cb3f92a
481d2bcc8454a44811db2bb68ac216fc6c5a23db
48a8b97cfd804a965fbbe7be2d56a7984ef6bdb1
49d6a3c062a1026a5ba957c46f3603c372288ab6
4ad81a91119df7c0e868f9e4c82b9159645bc906
4ba6341286f20d3b300a8f159aa2a61eca0f4b17
4bf07f6562a01a488877e05267808da7147f44a5
4c3386f64a432b3697fede579d06f9c1058043ad
4ce94eabac16b1d2c95762b40f49e5654ab288d7
4d0b8298818b623f5fa51d5c49e1a142d3618ac9
4da77090b0fcec1aa430e67631a1474343a33738
4e62aa96d6e55c1b2a4e841f1f8601eae81e81ae
4eeef2424153e79910d65248b5e1abf137d050e9
4f49dec9075aa0277b8c9c657ec31e6361f88724
4f532b7f969fcba010703fe21e0a85f662373041
4fcba7802c3e15a6e56e255871d6c72f829b9dd8
502d2bf5f2fd7c05adc2d4f057910bd5d4c4c63e
50597970aa84cc087424ef8d3bc430665aebcece
50e523dd79f6a856d793ce5711719abe27cffbf2
512c1117fb2eeb944df1b88bff6e0c002990b369
5182fecc4be8e4ae2e3a3d744b5562a3e74bf2b4
52ae346bd26c7a8b17ea82e9a09671e98c5402b7
5313b2a58ef02e2b077d7ae8088043609e3155b0
53ca765a041d5a24650d3f01bced791be5d72df7
54163a346d4a0a1b93f2ff6dc1f488419a605fa9
542f25a94471570e2594be5b422b9ca572cf88a1
5613fda9a503cd6137b120298902a34a1386b2c1
567c5e13be5cc74d24f5eb54cf353c2e2277189b
56b5354fd8f9173de2e1614864e5fb7bec8c50c4
56b9ae78303a963dc7ea85b20e99379efb346cd8
56c134f7f1b58be08bdb0ca8372474a4a5165f31
57d276bbbd322409bb6f7c6446187a29953f8ded
5905585103276b7c14bb9a7de4b575216cb6dac4
5912e791f3018de0a007c8cfa9cb38c97d3e5f5c
59508b303e4e35de9dd708ec87b1e89b1f3c1616
5974565bc26d6a599189db7c0b1f79eaa9af8eb9
59ae1d127ac0ae404baf414c434ba2651b793f46
5c8166419acf468b5bc3e48f928a040485d3e0c2
5c83511bdb9832c86be20fb86b783356e2f58062
5d5a97133887b2dfd8e2ad0347c3a02cc7aaa0cb
5e3c420dcca53766dec57d5bf4df8eecdb953c03
5ef384a60f22f70a99b45f769144761de37b037c
5f1251a48c17b54939d7477305e39679a565382c
5f825973b491a457c7233e808ecf64726abbeb86
61e0f39105b7926a41bc03158eccf5ed13207ebd
620b2438abf98f09e19802cbc3bc2e98179cdbe2
62fcb99bdf10fed34b4fe6e225489fe4be2d0536
6356ee0c9602004e0a3b4b2dad68ee2ee9385b17
6396bb221514d2876fd6dc0aa2a1f240d99b37bb
644f706719f0297bc5f65c8891de1c32f042eae5
6470accc7ba948b0b3aca22b273fe84ec638a116
64caea53e07f0a3bc4af74f4123b258c1ceb4d67
655a0fa34b4f7ac6e2b1406fab15e52a7b6accb1
66c03a926f18529c7a404901289e36efed5c0b1e
66c0e13ad236c74ea88c7c1518f3cef7f372e3da
6733dd4af7818559114e2a4771363dd6239297f6
679008e4bbeb12f4905ee0820cd2d0b9d4a21dbb
67b0ae43df179fb095f32a011446e7a883758877
67ff3d0a49f3d445c3922e30a54e03c161da561e
685703b497bacea8765bb409d6b73455b73c540e
687a3e4d8e6129f064711291f1564d95472dba3e
68db0cf10678630d286f4bbbbdfa102951a35faa
696ca779a928d0e93d61c38ffc3a4d8914a9b9a0
69f57058badded5c523871bbaaaf60b637bcf623
6a058a1eadc3882eff6efaa757f2c71a31fe9906
6a27e396ebb149fc47baccc1957a7a9dd70049a7
6a2c0962105ae8ceba182c4f616e0e41d7755591
6a4628997cfcc1eb1e34943f011d85bae36eadbc
6b16f9ee89b8d5709f24bc3ac89ae8b5452c0d7c
6b6256e616f7e10c4434cfcd32371fc33ca94e48
6bf625a4140f24b490766043b307f8252519578b
6c0eb5ba3500f6da367351ff3c4452c029cb72fa
6e0832fa432ec99c94caee733c8f5851cf85560b
6e3d66b80f670fdc64b9a120362a9f94b0494621
6f52b16c5b29b89d92c0e7236f4655dc8491ad70
6f6a657c99980485c265363447b269083dd1dc3a
703f7066f40599c290babdb79dd61319264987e9
70594e8bed7f1fc53c52ee639ce60c4ba4dd2ecc
7066c2f61ce49b131026fec68ed1c9b0d0d9a05a
71abb94ff63063f0cb303ac7860568639c10f42e
721612994f53ed600b39a80d912b10f51960e2e3
72167a9d7da2c295caf1d4a2d58128406786505d
72bbf9358c3676bd89dc4bd8fb0b1f2a11c288fc
72c139bacfa386145d7bbb68c47c8824716153b6
72d1465789506cdc441cb85271d993aee4ae79fe
7321f47eada53a395fb3086d49297eebb19e8e58
7357b1df744c2a3bcbe00cea0eef1509d004f488
73aa29a2b119619bbc1db87e8a8103f4b7e5a5db
743b237c3a7b0f5b44aa704aae8a1058877b6322
7462494408cd3de8b0bc1e79670bf213288501d0
74e71964b1a9ffd34fa4b6ec8f2fa13e7cf0ac7a
76241271aaf73c683da6f103e9b5722db3122392
765eaa0f70eaa274ec8b815d8c210c20cf7b6dbc
76c56a5affeba1e163b66b9d8cc192e6154466f0
77c3323f487512fd587074280e7fb46089cb50b4
77ffe33363c02c51c70303d6b79bab70451ba83e
78bb17f76edc3959152334947deec4dcb56e3764
79033bebf6fa3045bfa9bbe543c0eb7b43a0f4a3
7938f4218168ae9fc4bdddb15976f9ebbae41999
79661c3766f878aa9b4e20b4f2f8683431e5ec01
7976a11b30929871a4c84c3c406d7681a3dbcc10
7aff79e297ee1aa0126924921fd87a4ae59d2467
7be58a6488a9d36886d9423a1ed54fe104c7b182
7c4e983c4f3cf94fcd879730c6caa877e0768a4d
7d5e88d301f84a7b64602dbe3640f288223095ea
7deec5e0df741102c9b54156c88cd1476d272ae5
7ec37d1cbe17d8189d9562178d8b29167fe1c31a
7ed1c1901fe52e6c5828deb155920b44b0adabb1
800e26b81311dcc0080b8784f80620bb8f2baaa5
810a521265023a1d5c6c081ea2d216bc63d422f5
81d2393485f0990cf6566b0c9e0697c199f68ae5
82c1ead0d678af31e5d883656c12096a0004178b
83326e43f27e9a8a501427a0060f8af519a39bb2
846da38de0e8224f2f94b885125cf1fd2d7b0d39
8618793750071d66028584a83ed0b4fa7eb4f607
8644f771e07c52617627dffa4c67ba0ea120fd13
86c8fb4d228ed8dbe17b1abd664888bc7ee0052a
87ee613d076351950b74383215437f841ebbeb75
886e44c9298a6b428ae046e2fa092ca52e822e6a
88dca4ca5a93d2c09e5bbc6a62fbfc3af83c4fca
88f28e95e72eebecce5ba6944adffdf3654f626c
89eb4d8d25722a0a0194cf7fa47ba602e32a6da7
8a1115ff6b6d90cf1066ec3a0c4e51276553eebe
8a48ac339398f21282985bff16552447d41dcfb2
8a99c920092f444cf9f1d737ae76527102886d8e
8ab59da26bc0ae0abfcaabc4218c74827d154256
8afdae83e318f3cfb6eb1ee2ce289356936a663c
8b9e13d2de73b5513c2ceffe0f62eab40206a126
8cfab3cf63cfe5a53e2e566b3b86b30c187edf3a
8d20bd6381670382669d9bb39b5fd566a84cdbef
8d69d008f44cb96050c35e64fe940a22dd6b0113
8e6925631aae550bdaea4c442e8ecbab4a9685d2
8ec56fc3c5ee6f9700adac190e9ce5b8859a58b6
8f014550dfb114cc7f42a517d20d2cf887a0b771
9006c133a422f474d7d8e10a8baae179f70c22f5
915e6f78bd0641da692ffa7e0b766e633e12e628
9167fd5d5549bcea6d4735a270908da2a3475f3a
9170200ec0ebad70e5b9902bc93e2b1b11456a3b
919f4ebc598701670e80e31573a58f1f2d2bf918
93bf4172481c4b2a8544c83a687946252563edd0
9442f3bd9012f37ba2b4ec3ab2d7c248b137391c
9699f970de84292a766709029e5135ea0b6c9aa9
96ec2939620c48a503d9c89865c0c230d6f955e4
978b57475c7795824676122acb75a1dea264b6d1
97c9bfe3f6605d41eb8f1206e6e0f62b31ba15d6
98f65ad458441ea3a243395345811132ee850093
9952f6918daa4ab5fc81307a9f90e31a4df3b200
99b48ecc8e800983b6e00a2350daaeceba1f7406
99f1c46011cc0feb47d4f4f7bee70a0341442d14
9a8797722e4239242d0cb4cc4baa805df6ac979e
9ab877a6ccf820483d79602bede0c1aa1da4d26a
9aedc6e2f1c6708120b80748556fb6ad0567d15d
9b543419652917f048310d0863c47c107c26fb0c
9bbb888824e38cc2e9118ed351fe3d22403a73e1
9c40546c012c8d98e88be38c650e66203cb2f1a8
9c52f6b3d8c09df75b72dab9a0e6eb2b70435ae1
9da197f1df40c838f0f06abf94cd23b4ed81e522
9e2715ca20d7b540a271464b3ac862cf387935c1
9eb41c521465f62332dfddcd399412fdff9c062b
9f510d1e4299169e01efeac2275d0792850db956
9f8b577f7b43b2170628d6c537252785dcc2dcea
9fc3c01a1fae669a2ef9f13ee1e1a26e057d79f8
9ff5549b1d1d3c3a9d71220d44bd246586160f1d
9ff5e0304e949a8a4e584c8c2b11fad9b2e0b133
a073d7e3ad687a7ef32b65affe80faa7ce89bf92
a0ab5abced550ddeefddb06055ed60779a54eb79
a0dd008fe9b2f536aabb1ac2cfa4eee44734beab
a0e2bf7cb7006b5a58ee81f4da4fe575875f2781
a16be368dd3fb695077cc9bc59c988b548955eec
a1ec661c3fdc8177a8789a9528d5bcfe0d9fc8a8
a2b5c3c0c8eea2d5d0eefcfc0fc0bdf386daa260
a2e164e7f45ab21742b2e32c0195b699ae2ebfc0
a31e58e129f73ab5b04016330b13ed51fde7a961
a350eccee5830d9a1f29e393a88dc05a15326d44
a3a66c3822e03692ed7c5888e8f2d384cc698d34
a3e230926708125205ffd06d3dc2175a8263ae7e
a60b3c594ef3221275d4fa8aa94e206607ea66f3
a6b94c6b49198266eaf78095a632df7245ef5196
a7ef9b455c7ca8f07a5b4bd967a3c39c7434d43f
a812297c4fd9c2c9337b451ad8d66083c5b24ceb
a8c3209998afb5c4941b49e35b513cea9050cb4a
a921cf83cc4c927f29eef1e7a17bff176c74b886
a9a08845e9acbd224e4ee466f5c1275ed50054e8
a9cd410a3d296846a8125aa43d97a573a354c472
a9eeb998c28d5506616426bd3a216bd5735a18b8
a9f08ad7adb3d2f90e11efbb40a1246ef95b0c04
aafa97fd1c01bc82c1f288bf1f27e8e1bdc36a3e
ab92d68fc22f9afab480153bd82a20f6e2533769
aba8a53264963514917e462f3fbbb66b3de79951
ac383f58f3c98de37fa67452acc5bd677396e9f3
ac3e5fcae8ca658e7dcc3fdcd50af7e4779f58c1
ac6811a9b36f3ceb549d8b84bd8aeedf6026df02
adc43caa0a25746e1a9dabbab241abd01120dbfe
ae0078fcf0a5eb3a8623bfb5f988262e0911fdb9
aee738236dca0d0870789138ec494e15d6303566
af42377978852234974c26efcca3d70eb86bd349
af788f355e343373490b7d2e361016e7c24a0ffa
afaf0b2f9b801c6eb2278b52d49e6a7d7b659cf1
afc9a42b7464f76e1388cad87d8543c69f6f74ed
b02e5a0ebb172c8276cea3151942aac681f7a4a6
b0995156071b0ff29a5902964a9dc8cfad6f81c0
b0a4ab7ca4ce993d1cc51cbc85e9f341c729a3d4
b0cce4f6fe6633546bbe5ca04f965f76948e2f34
b187038b5e3f8404dbafce89fd169e66fe604df4
b1e34d325397a33d97d845e312d7cf2a8b646b44
b24413180f5600bcb3bb70fbed5cf186b60864bd
b253c3026c29d4231099d3cf8d984d25787793af
b2869f28e1476cd705bb28c58fd01b0bd661bb99
b2d8b167e15bb5ec2691d1119c025630a247f649
b2fdc2570a6c4b1fe950c11a2e9ce949f5190765
b3646477d458fbe7694a15b9c78fbe2fa426b703
b4128000e2c9b176a449d748dcb083c61d61cc6e
b415d8d417bbe5403626b74e1041101ac23d602f
b4562ca7925a3bedada87a3dd072dd5bad043288
b48b89f9c189d24eb5e2b4a0ac067da5a24ee86d
b4c364da32cf3b85297648ff5563de2c47d9e32f
b539324f6fe798bdb186e4e91eafb37dd851db2a
b54c9d5bd6e38edac9ce3a3f95f14a1292b5268d
b5aead0064f33ae5e693a364e3204fe1c0ac9af2
b5bcb94b0954a026bbd671741fdb00e7141f9c91
b6117199787c60539105d2de0d010146e8396fc3
b6a05c823fc573a65efc4466f174abf05f922e0f
b6c2c22fa7012616b3039c9f559bf01195137b9d
b707b89f7be36147187ebc52d91c085040c26de9
b80a92ff81587c556da740e9073821b5c3c23b72
b886d83c5b621abc84ff9616f14c529be3f6b147
b95a8a27c300d1a39a4e36f63a518ef36e4b966c
b9ca2f5ff7784d46285a8f1b14419ac4645096f7
b9f2b0ffde0c9b666b2b1672eb468b8f805a9b97
bb53ecb4d6ea453e55a971295e55dbf76adc0f8c
bc58ebd506c369c26337cf6b1a400af1a25c989c
bce5c2ea350f5a57353295534faba00b28cadf14
bd1ba5732bb954c31e2be07e8ee1397a910835e4
bd38b32053eb1c53ddb7030cf0fc6d700f7f1d82
be4017cea0aec6369275df7eafbb09682f810e7e
be9df4aff65f18caa79b35f88f42c3d5a43af14f
bf28462e20b56c1d7c8dbf82367cd43ffbc8a1f1
bf348f667ed36c0799dd6d10adb7be9cdfea48c3
c0cfa2d8a788fcf45df5bf4070ab2474c88d543a
c0e084e342a8046d06c4172b6ccb4db5d7633156
c21d54f0307ff42a346294899107b570b98c47b5
c2b32867f2e7bfa7e7521e417ab8bbd586ac6bcc
c2d68afba86d1ff01e7300c68bc16a9234dcd8e9
c30e9bc8b606077142969a807ada42ca921e605a
c48d8b04893afe35fd6f5ccbf339493bba277d43
c4b4d7047f16a8d138ce76da65faefb7165736f2
c58a318f6090efe06e6702b8882e2026f44f620e
c593642c8be046915ca3a4a300243a68077cd207
c5bf198c5edcf279313948029527a755732cd753
c6aa9d3b43cd11ac13a8220368a3b0483c6751d4
c70126764bf09c5dd95527808b647ec347b8a822
c742c59e1fbd022b64d91aa9a0092b3a699d653c
c8064e5b4adac5e1255cf4f3b374e75b5376e7ca
c9c13ba428ef90a9b408a6cdf874e14ab5754516
c9d3fe9da094a9a7a3d3cd365b334b822e05f5e8
ca3cda6fcf1e922213a0cc58e708ffb999151db3
ca5f13a21404f5496bcc006d9416c8bef21b227d
ca7372aca7f4b2f1b29a9941053999d224d1e7c7
ca79b0c211af63fa3276f0e3fd7dd9ada2439839
cb359b60416701c8bed82fec79de25a144beb893
cbc0236a4b3e6a64f5b8bee27b530c7f8bee8d56
cc69837fcaf467426ca19e5790085c26146a2300
cc9cfddb0433961107bb156fa769fdd7eb6718de
cdfa835c6e5e87d145f9f632b58843de97509f2b
ce103204cbe61f8d5d995f7a09a6b18e6b6ac3c4
ce2196b831b1e9f8982b2904fc3e8658cc0e6573
ce3859172ce09e6ff495290d8ba1d6c7f1a7b207
ce3d1536acabbdcdc3c945c3c078dd4ed1b8edfa
ceef7d10dfb6284d512c499292e6daa35ea83f90
d02a26991ecee772f8e510ce46ccac87ce480554
d09bc83640d524b8467a660db7b1d15e6562a1de
d2547cf59793168b564372d75620897416cbaf87
d264eb3c14d0e5df49ecab3e8b51caadf78abefa
d29b4295c325a0214d51b82fdc929d330e20979c
d2ac25d4196da2ff404c88bec480c835995ea69c
d32ef547fdbbeb9c4351f9d3bc84dec998a3be8c
d3457c877b14aaee8c52923eedf05a3b78af0476
d38213a911c5a5eacd7cc5854c0477d308bef0cb
d424a2afd7da136a98e9485bfd6c5d5506bd77f8
d474d92d70250d43e7ce0c7cb8623f31ee7c40f6
d4dccf353db80e209f262e3973c834e6e48ba9a9
d5ebde1e2b46154d7e03efb1ae3039a304e5386d
d603fd8dd35f6028bb09cd2e9ec6557c4bc0dd95
d6088e9a89f7c6fe9720978196c4d9799fd16c29
d61e40385655fbba659fc3d81df9bdf1b848e263
d66bfa36f9edc5ca8c83206ab39d09091623104e
d786e00d19f9fc80c2239a07643b08ea75b8b364
d8f5537a8816c8f00ea3103e74b65987963a56c6
d9932b46915664c88709d59927fa67e797adec56
d9f6e12fb0b7fcded0bac34b8293ec46f80dfc33
da66761c2d93a46270d69001abb5692717495a68
da6d63a0062a3ee721b84123b83ec093f25759b0
db3975717ac5e2c2761bae7b90c4f2e0abb5ef22
db9cf24cea69773410f0049bdfa795d7c2bd0ea9
dbcf3f96fa662bd5e1f93ea7c10a8dd0dce180ae
dbde6d0c7a5a462a1767a07c28eadd2c3dd08fb2
dc2b453290c471266a2d56d7ead981e3c5cea05e
de3cd117ed2f6cb3317212f242a87ffca56c27ac
de63ad4cf4973462953c29c363f3cfa7117c2b2d
dea6e140d927b8d9b299f972eac5574de71bc75f
dee7121e8c0a3ce41af2b02d516f54eaec32abcd
df561f6688fef775baa341a0f5d960becd248b11
e0121fa29a7f4fc56cf75f5c6a80c41c7c73f593
e048834c209a02e3776bcc47d43c6d863e3a67ca
e1878402ab2dca12d1426f2fea39757943f3332c
e2be04c7f9958dde770eeb8b30e829ca969b37bb
e2d8b4289c937447ab710052f15a18f686db73dc
e2f11f42824bf2d906468a94888718ae24bf0270
e3beca48a45b5e0e6e6a4e0124276b8248dcc9bb
e5dfd093eca01a5d8d967f959a2372d7d82eb59c
e6b6c483ebe9b3f82710fc39eff5531b4d80b089
e76ae52747a82a548742107b4100e90da41a624d
e7d214642a19b8e0e7ecda39184c2ab98ba4801f
e80eec1b871a2acb8f5c92db4c237e9ae6dd322b
e8407fdeb9a6866784e249881f6c786a0835faba
e880c6ea55b9805294ecc100ee95e0c9860ae90e
e9a7fda29a5620d9ac2a750d8e35f5d270096321
ea1529873ab18c204688cf31746df851c098cbea
ea81fdf0981d9a4a998a015d325bed67624811f7
ea8c66fe8d8f4f93df941e52120a3512d7bf5128
ea9da788a61e47e7ab9cbad397453e51cd82ac0d
eba60ddae794bdefb9531cb08e30c19a0bc53c15
ec8f24b7faaf3d4799a7c3f4c1b87f6b02778ad1
ecca25029473bee6e98ce062e76b7310904bbdd1
ecd8a8c2b406c5cc9e1e39a7194eb5da4b110c5d
ed381fca47122f0787ee53b97e5f9d562eec7237
edbe262acf92c986ad9a1f594ae3b4f3d3373133
ee8b7a1156f357613646d6c69d07ac5a087a1071
eeb85a14ee3494febb85ccfbee0772eda0823b13
eec399dd862762b9594df3659f15839a4e12f17a
eec4844fae7c033a0c1fc1eb3b8517aeb8b6cc49
ef3f3980dedffe124727f7baa1932c8491a911e4
efc479e6900c22bad9a2b649d13405ed9cde2d53
f0d2f5c2c000c03aa6b6a29954042174b59a0d1c
f15756428ded1ee01d95934057a6e89c2d450bbb
f1adceaf01f0446e69c15b32f24ce98e3c3623f1
f1f63cbb705dc38826369496c6fc12c1b8db1324
f1ff89ec4447c4e39d275a1ca3de43eed2a92745
f21dd494506ad002a5b6b32e50a5d4ccac6929fe
f2bc14b69c38b60f201fdf90c08cb2dc8966f331
f2f136c05fb6093818a3b3fefcba46231ac66a62
f3956ebb3bf06ab2266ad5ee2214aed46405810c
f39650de687e35766572ac89dbcd16a5911e2f0a
f3b138c5d89a1f74a2b46adaa1067aea9a7e3cbb
f4de6a1fa3ee81197239603756fc5c4259e5ef1b
f4e4805e4bf7a06235d2aa216e1d00cb1f3bd0c1
f4fdc0a2edf48f16f7b10cceaf4781fc56ab7fd9
f5714bbb5b3120b33dfbf3d81ffc0b98ae4cd4c1
f5caf621ee357279e759c0911daf6d55c7d36f03
f5f93d7f5a5cbfef02609dead21e7056e83f4fab
f69b55efef8406113c52f7494d2669ba9d4958c8
f72e38e8ec8869ac0ba5a75d7d2f897d98a1454e
f808495da56f28e94c6448125158f1175009fcfc
f83705a51275ed29117d46e1d68e8b16dcb40507
f84fcb66568c0b00626f7f03e28db7d0dcba8098
f97f5a56f5977311f3833056a73cdbb0ee56cb1e
f98a3efb284a7950745d6c95be489193e6d4c657
f9f3f02db98bbe678a8e57fe9432b196174744a3
fa52a4b2d0ab416508538bb47a95167d4c94caac
fae42c4d522b9b9c9de21a5cade162f2e7eaf644
faeb7833eee0d6afe0ecb6bdfa6042556c2c352e
faff44069ff538ccdfef187c4d7ec83d22dfb3a4
fb2d14add4f813c73bd9d28b750315ccb3f5f0ea
fb3ceec187e8bca474340e361a18163a2e79c0a2
fc08b628d7c96d9a6d6bca488c3fa9c92bee6cc8
fc7a6209d5710618eb4f72a77cd81b8d694ecf89
fe06a0c09b47ea58ba2b01c8941af16bd45c02df
ffbe17cadaf564b5da0e4eabdcff1b719e184a76
)
trap "echo $0 <opts>" EXIT
unset LANG
unset ${!LC_*}
maj_tag=4
min_tag=4
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
