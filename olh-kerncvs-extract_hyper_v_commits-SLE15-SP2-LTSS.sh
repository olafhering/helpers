#!/bin/bash
set -e
#set -x
#
ignore_revspecs=(
009a3a52791f31c57d755a73f6bc66fbdd8bd76c
017e42540639a46fdf7c7f5ee647e0b7806c9013
01ed100276bdac259f1b418b998904a7486b0b68
039642574cc4ff77b1c8ca042c879fa6995ce154
0469f2f7ab4c6a6cae4b74c4f981c4da6d909411
046f5756c49106471bc98bd32b87a62d0717ddda
05f04ae4ffcc77cfcda86adc4e2c13aa72143c03
060f2b979c4e0e894c381c76a4dcad24376feddd
062a5c4260cdb734a4727230c58e38accf413315
066f3377fb663f839a961cd66e71fc1a36437657
068c38ad88ccb09e5e966d4db5cedab0e02b3b95
0719881bf891cc72bf4375a9f4849d52772c80c6
07ffaf343e34b555c9e7ea39a9c81c439a706f13
0823570f01989d3703751f66534a138d4fae062e
0854fa82c96ca37a35e954b7079c0bfd795affb1
089fe572a2e0a89e36a455d299d801770293d08f
08e9d12077fcc7c4c4579d7dcd8093b59b01369e
0a19c8992db834c9c9e28c5633720d994629539d
0ba2fa8cbd29278a180ac90bd66b2c0bbdeacc89
0baedd792713063213f1e2060dc6a5d536638f0a
0c31fa0e66195bc2aacd90fbfc9fac75d0abada3
0cc4f6d9f0b9f20f3f1e1149bdb6737c0b4e134a
0f250a646382e017725001a552624be0c86527bf
106b98a5181c1a5831f1fe31d33d17dd1f0e7ae1
10d7bf1e46dc19d964f0f67d2a6d20df907742d1
12cc1c7345b6bf34c45ccaa75393e2d6eb707d7b
154fb14df7a3c81dea82eca7c0c46590f5ffc3d2
1561c2cb87ab39400d76998bf7be581c1e57f108
16d083e28f1a4f6deef82be92d6a0f5aa2fe7e08
17b6d51771a15c7d8552c3e855b5862b3dce0977
185c8f33a048bd04fdedd08e7bd7861a85158834
187c8833def8a191c7f01d7932eac1bd2ab84af1
193061ea0a50c13f72b907e6fa7befa6e15a4302
1982afd6c0582c523970f5426cc1f11ef8ead7bd
19b5e6659eaf537ebeac90ae30c7df0296fe5ab9
1a9df3262a632020071327abf56e9243e4dd7bde
1aa8a4184dbde5f50b70b2c706bcfb6b57da9ea7
1c5fae9c9a092574398a17facc31c533791ef232
1c9de08f7f952b4101f092802581344033d84429
1cac8d9f6bd25df3713103e44e2d9ca0c2e03c33
1d044ca035dc22df0d3b39e56f2881071d9118bd
1dc2f2b81a6a9895da59f3915760f6c0c3074492
202818e1c8519ee301e930484707d7ddace639e0
20c89a559e00dfe352b73e867211a669113ae881
20cf6616ccd50256a14fb2a7a3cc730080c90cd0
2194c2eb6717f2ea7dc793ad9cbf44d359a3f696
22ef7ee3eeb2a41e07f611754ab9a2663232fedf
23378295042a4bcaeec350733a4771678e7a1f3a
234d01baec5b216b60b560672957470f773ecf78
23baf831a32c04f9a968812511540b1b3e648bf5
24764f8d3c316a3c58b51140d8e489e98e7ffdcc
25af9081189b91df003be7e8acbe9b05f9a58c93
25bfa956561fb47141b8cc382e69a1f674a27eb0
26011267e1a7ddaab50b5f81b402ca3e7fc2887c
260970862c88b4130e9e12be023c7e2c2d37a966
26b516bb39215cf60aa1fb55d0a6fd73058698fa
2744a7ce34a776444225f20ae11ead6e980a129a
277ad7d58611b455662f2e3f7bd24ce5bfeb2fdc
27bd66dd6419c45e320f34ed419cd80833de1161
28b8235238fa39a1b5c5820e7f5b14e7f104aac0
2a81ada32f0e584fc0c943e0d3a8c9f4fae411d6
2be1bd3a70c81835b8969216ceedbd017fea732d
2c76e7f6c42bcee0e25194b54140cbce866d191a
2e2f1e8d0450c561c0c936b4b67e8b5a95975fb7
2f23e5cef31414156c24b90e56dedc118feb9bf3
3019270282a175defc02c8331786c73e082cd2a8
30a9c246b9f6fe0591e8afb05758a3e3b096fabe
320af55a930f30ba49d7cd663280d46705e11383
3244867af8c065e51969f1bffe732d3ebfd9a7d2
33b22172452f05c351fd2fa24c28d2e76c7b0692
34ef7d7b9c0422316ee2c34c564b222255c91532
381cecc5d7b777ada7cdf12f5b0bf4caf43bf7aa
3ae0ed376d1c2981715c540ba7ad3bf43fec244c
3b80b73a4b3de38f72cd79e1a157449917f2bcb5
3be29eb7b5251a772e2033761a9b67981fdfb0f7
3c37f3573508937475d62396149df93ec24e71eb
3d91c537296794d5d0773f61abbe7b63f2f132d8
3f4a812edf5cb0a50e65fbdfafdb3e688da18f16
3f74957fcbeab703297ed0f135430414ed7e0dd0
40421f38f63764cd41b01c17e2a1fbbe08a1515a
413af6601f7613c07d8c36b57e184d7841ace43a
42dcbe7d8bac997eef4c379e61d9121a15ed4e36
43c075959de3c45608636d9d80ff9e61d166fb21
445caed0213acef29b9d3822b6906f99860ca9ab
44676bb9d566ce2bfbd132f9745eb7eb2d784476
450bdf5bd6c6b78372620da2c32c5a58ab0f124e
4592b7eaa87d3525825d4ab2a35308bcec9e5ff9
45b64fd9f7ae2cce27f85f7f0a7b1fcdd08d06b4
45c38973ed1868b8448079edd48bf24ab8b326fa
45f46b1ac95ea34cc6e81739a64cb6bec28f1185
46808a4cb89708c2e5b264eb9d1035762581921b
4754ec7f202003ef3a307bc59779efdd312a876e
47d3e5cdfe607ec6883eb0faa7acf05b8cb3f92a
48b1f68372ca93ff67812d99c8d7351aaee62a2a
49d6a3c062a1026a5ba957c46f3603c372288ab6
4ad81a91119df7c0e868f9e4c82b9159645bc906
4bf07f6562a01a488877e05267808da7147f44a5
4c3386f64a432b3697fede579d06f9c1058043ad
4d0b8298818b623f5fa51d5c49e1a142d3618ac9
4da77090b0fcec1aa430e67631a1474343a33738
4e62aa96d6e55c1b2a4e841f1f8601eae81e81ae
4eeef2424153e79910d65248b5e1abf137d050e9
4f532b7f969fcba010703fe21e0a85f662373041
502d2bf5f2fd7c05adc2d4f057910bd5d4c4c63e
50e523dd79f6a856d793ce5711719abe27cffbf2
512c1117fb2eeb944df1b88bff6e0c002990b369
5182fecc4be8e4ae2e3a3d744b5562a3e74bf2b4
53ca765a041d5a24650d3f01bced791be5d72df7
54163a346d4a0a1b93f2ff6dc1f488419a605fa9
542f25a94471570e2594be5b422b9ca572cf88a1
56b5354fd8f9173de2e1614864e5fb7bec8c50c4
56c134f7f1b58be08bdb0ca8372474a4a5165f31
57d276bbbd322409bb6f7c6446187a29953f8ded
5905585103276b7c14bb9a7de4b575216cb6dac4
59508b303e4e35de9dd708ec87b1e89b1f3c1616
5974565bc26d6a599189db7c0b1f79eaa9af8eb9
5c8166419acf468b5bc3e48f928a040485d3e0c2
5ef384a60f22f70a99b45f769144761de37b037c
5f825973b491a457c7233e808ecf64726abbeb86
5fbcc6708fe32ef80122cd2a59ddca9d18b24d6e
611d4c716db0141cfc436994dc5aff1d69c924ad
620b2438abf98f09e19802cbc3bc2e98179cdbe2
62aeaeaa1b267c5149abee6b45967a5df3feed58
62fcb99bdf10fed34b4fe6e225489fe4be2d0536
644f706719f0297bc5f65c8891de1c32f042eae5
6470accc7ba948b0b3aca22b273fe84ec638a116
655a0fa34b4f7ac6e2b1406fab15e52a7b6accb1
66c03a926f18529c7a404901289e36efed5c0b1e
66c0e13ad236c74ea88c7c1518f3cef7f372e3da
670c04add6e1a22de7c59e282c138ddcf6c9e5a2
6733dd4af7818559114e2a4771363dd6239297f6
679008e4bbeb12f4905ee0820cd2d0b9d4a21dbb
67b0ae43df179fb095f32a011446e7a883758877
67ff3d0a49f3d445c3922e30a54e03c161da561e
68f2f2bc163d4427b04f0fb6421f091f948175fe
6a27e396ebb149fc47baccc1957a7a9dd70049a7
6a2c0962105ae8ceba182c4f616e0e41d7755591
6bf625a4140f24b490766043b307f8252519578b
6c0eb5ba3500f6da367351ff3c4452c029cb72fa
703f7066f40599c290babdb79dd61319264987e9
70594e8bed7f1fc53c52ee639ce60c4ba4dd2ecc
71abb94ff63063f0cb303ac7860568639c10f42e
72167a9d7da2c295caf1d4a2d58128406786505d
7321f47eada53a395fb3086d49297eebb19e8e58
73aa29a2b119619bbc1db87e8a8103f4b7e5a5db
743b237c3a7b0f5b44aa704aae8a1058877b6322
7462494408cd3de8b0bc1e79670bf213288501d0
75cff725d9566699a670a02b3cfd1c6e9e9ed53e
765da7fe0e76ed41eea9514433f4ca8cdb5312b1
76c56a5affeba1e163b66b9d8cc192e6154466f0
77c3323f487512fd587074280e7fb46089cb50b4
77ffe33363c02c51c70303d6b79bab70451ba83e
78bb17f76edc3959152334947deec4dcb56e3764
79033bebf6fa3045bfa9bbe543c0eb7b43a0f4a3
7938f4218168ae9fc4bdddb15976f9ebbae41999
79519528a180c64a90863db2ce70887de6c49d16
79661c3766f878aa9b4e20b4f2f8683431e5ec01
7aff79e297ee1aa0126924921fd87a4ae59d2467
7c4e983c4f3cf94fcd879730c6caa877e0768a4d
7d5e88d301f84a7b64602dbe3640f288223095ea
800e26b81311dcc0080b8784f80620bb8f2baaa5
810a521265023a1d5c6c081ea2d216bc63d422f5
81d2393485f0990cf6566b0c9e0697c199f68ae5
82c1ead0d678af31e5d883656c12096a0004178b
8387ce06d70bbbb97a0c168a52b68268ae0da075
846da38de0e8224f2f94b885125cf1fd2d7b0d39
86c8fb4d228ed8dbe17b1abd664888bc7ee0052a
86e619c922e616d8780833562a14a5bda329f0c3
88dca4ca5a93d2c09e5bbc6a62fbfc3af83c4fca
8ab59da26bc0ae0abfcaabc4218c74827d154256
8afdae83e318f3cfb6eb1ee2ce289356936a663c
8b9e13d2de73b5513c2ceffe0f62eab40206a126
8d1077cf2e43b15fefd76ebec2b71541eb27ef2c
8d20bd6381670382669d9bb39b5fd566a84cdbef
8d69d008f44cb96050c35e64fe940a22dd6b0113
8f014550dfb114cc7f42a517d20d2cf887a0b771
9167fd5d5549bcea6d4735a270908da2a3475f3a
919f4ebc598701670e80e31573a58f1f2d2bf918
92272ec4107ef4f826b694a1338562c007e09821
9442f3bd9012f37ba2b4ec3ab2d7c248b137391c
96ec2939620c48a503d9c89865c0c230d6f955e4
978b57475c7795824676122acb75a1dea264b6d1
97c9bfe3f6605d41eb8f1206e6e0f62b31ba15d6
99b48ecc8e800983b6e00a2350daaeceba1f7406
99f1c46011cc0feb47d4f4f7bee70a0341442d14
9a8797722e4239242d0cb4cc4baa805df6ac979e
9bbb888824e38cc2e9118ed351fe3d22403a73e1
9c52f6b3d8c09df75b72dab9a0e6eb2b70435ae1
9e2715ca20d7b540a271464b3ac862cf387935c1
9e2d0c336524706fb327e9b87477f5f3337ad7a6
9eb41c521465f62332dfddcd399412fdff9c062b
9f8b577f7b43b2170628d6c537252785dcc2dcea
9ff5e0304e949a8a4e584c8c2b11fad9b2e0b133
a0ab5abced550ddeefddb06055ed60779a54eb79
a0ae00e71e3e652c3bde8dcb61b4c1718618192e
a0dd008fe9b2f536aabb1ac2cfa4eee44734beab
a0e2bf7cb7006b5a58ee81f4da4fe575875f2781
a16be368dd3fb695077cc9bc59c988b548955eec
a1ec661c3fdc8177a8789a9528d5bcfe0d9fc8a8
a3a66c3822e03692ed7c5888e8f2d384cc698d34
a3e230926708125205ffd06d3dc2175a8263ae7e
a539cc86a1cb688df24d9cff17d946a8c0b94b38
a60b3c594ef3221275d4fa8aa94e206607ea66f3
a67f6b60d6ed953d5b23a22f26fc916aab630aaa
a6b94c6b49198266eaf78095a632df7245ef5196
a6fe043880820981f6e4918240f967ea79bb063e
a7ef9b455c7ca8f07a5b4bd967a3c39c7434d43f
a8c3209998afb5c4941b49e35b513cea9050cb4a
a921cf83cc4c927f29eef1e7a17bff176c74b886
a9ca9f9ceff382b58b488248f0c0da9e157f5d06
a9f08ad7adb3d2f90e11efbb40a1246ef95b0c04
aafa97fd1c01bc82c1f288bf1f27e8e1bdc36a3e
ac6811a9b36f3ceb549d8b84bd8aeedf6026df02
adc43caa0a25746e1a9dabbab241abd01120dbfe
aee738236dca0d0870789138ec494e15d6303566
af788f355e343373490b7d2e361016e7c24a0ffa
afaf0b2f9b801c6eb2278b52d49e6a7d7b659cf1
b02e5a0ebb172c8276cea3151942aac681f7a4a6
b0a4ab7ca4ce993d1cc51cbc85e9f341c729a3d4
b0cce4f6fe6633546bbe5ca04f965f76948e2f34
b13103559dddbc64330c2e63ebf7342e70fbab4e
b187038b5e3f8404dbafce89fd169e66fe604df4
b253c3026c29d4231099d3cf8d984d25787793af
b3646477d458fbe7694a15b9c78fbe2fa426b703
b3e148d730b7255dfcfb080c8633146e44b83b0c
b4128000e2c9b176a449d748dcb083c61d61cc6e
b415d8d417bbe5403626b74e1041101ac23d602f
b48b89f9c189d24eb5e2b4a0ac067da5a24ee86d
b539324f6fe798bdb186e4e91eafb37dd851db2a
b5aead0064f33ae5e693a364e3204fe1c0ac9af2
b6117199787c60539105d2de0d010146e8396fc3
b6c2c22fa7012616b3039c9f559bf01195137b9d
b707b89f7be36147187ebc52d91c085040c26de9
b80a92ff81587c556da740e9073821b5c3c23b72
b95a8a27c300d1a39a4e36f63a518ef36e4b966c
b9b4fe3a72b60c8d74a9ffb61aa778f04eaddd87
b9ca2f5ff7784d46285a8f1b14419ac4645096f7
b9f2b0ffde0c9b666b2b1672eb468b8f805a9b97
bb53ecb4d6ea453e55a971295e55dbf76adc0f8c
bb9b0e46b84c19d3dd7d453a2da71a0fdc172b31
bc58ebd506c369c26337cf6b1a400af1a25c989c
bd1ba5732bb954c31e2be07e8ee1397a910835e4
bd38b32053eb1c53ddb7030cf0fc6d700f7f1d82
be4017cea0aec6369275df7eafbb09682f810e7e
bf348f667ed36c0799dd6d10adb7be9cdfea48c3
c0cfa2d8a788fcf45df5bf4070ab2474c88d543a
c0e084e342a8046d06c4172b6ccb4db5d7633156
c21d54f0307ff42a346294899107b570b98c47b5
c26e0527aaf84a34b4774d80c9a9baa65f4d77f2
c2b32867f2e7bfa7e7521e417ab8bbd586ac6bcc
c30e9bc8b606077142969a807ada42ca921e605a
c4b4d7047f16a8d138ce76da65faefb7165736f2
c58a318f6090efe06e6702b8882e2026f44f620e
c6aa9d3b43cd11ac13a8220368a3b0483c6751d4
c742c59e1fbd022b64d91aa9a0092b3a699d653c
c8064e5b4adac5e1255cf4f3b374e75b5376e7ca
ca5f13a21404f5496bcc006d9416c8bef21b227d
ca7372aca7f4b2f1b29a9941053999d224d1e7c7
cc69837fcaf467426ca19e5790085c26146a2300
cc9cfddb0433961107bb156fa769fdd7eb6718de
cceb4e0810b61c7f5837c17e966b9b718dd62d22
ce103204cbe61f8d5d995f7a09a6b18e6b6ac3c4
ce2196b831b1e9f8982b2904fc3e8658cc0e6573
ce3859172ce09e6ff495290d8ba1d6c7f1a7b207
d2547cf59793168b564372d75620897416cbaf87
d264eb3c14d0e5df49ecab3e8b51caadf78abefa
d29b4295c325a0214d51b82fdc929d330e20979c
d2ac25d4196da2ff404c88bec480c835995ea69c
d38213a911c5a5eacd7cc5854c0477d308bef0cb
d3a9d7e49d15316f68f4347f48adcd1665834980
d474d92d70250d43e7ce0c7cb8623f31ee7c40f6
d4dccf353db80e209f262e3973c834e6e48ba9a9
d5ace2a776442d80674eff9ed42e737f7dd95056
d5ebde1e2b46154d7e03efb1ae3039a304e5386d
d603fd8dd35f6028bb09cd2e9ec6557c4bc0dd95
d66bfa36f9edc5ca8c83206ab39d09091623104e
d6e0228d265f29348a01780ff306321c399d8b95
d6e2d652443751e290b2edb70173ec3c22f78fbe
d6f361ea706710f8d582bb176793b779a3b8b2ca
d786e00d19f9fc80c2239a07643b08ea75b8b364
d8f5537a8816c8f00ea3103e74b65987963a56c6
d9932b46915664c88709d59927fa67e797adec56
d9f6e12fb0b7fcded0bac34b8293ec46f80dfc33
da6d63a0062a3ee721b84123b83ec093f25759b0
db9cf24cea69773410f0049bdfa795d7c2bd0ea9
dbde6d0c7a5a462a1767a07c28eadd2c3dd08fb2
dc2b453290c471266a2d56d7ead981e3c5cea05e
dea6e140d927b8d9b299f972eac5574de71bc75f
dee7121e8c0a3ce41af2b02d516f54eaec32abcd
e0121fa29a7f4fc56cf75f5c6a80c41c7c73f593
e048834c209a02e3776bcc47d43c6d863e3a67ca
e1878402ab2dca12d1426f2fea39757943f3332c
e2d8b4289c937447ab710052f15a18f686db73dc
e3131f1c81448a87e08dffd21867312a5ce563d9
e5dfd093eca01a5d8d967f959a2372d7d82eb59c
e76ae52747a82a548742107b4100e90da41a624d
e80eec1b871a2acb8f5c92db4c237e9ae6dd322b
e8407fdeb9a6866784e249881f6c786a0835faba
e880c6ea55b9805294ecc100ee95e0c9860ae90e
ea8c66fe8d8f4f93df941e52120a3512d7bf5128
ea9da788a61e47e7ab9cbad397453e51cd82ac0d
eba60ddae794bdefb9531cb08e30c19a0bc53c15
edbe262acf92c986ad9a1f594ae3b4f3d3373133
ee8b7a1156f357613646d6c69d07ac5a087a1071
eeb85a14ee3494febb85ccfbee0772eda0823b13
eec399dd862762b9594df3659f15839a4e12f17a
ef3f3980dedffe124727f7baa1932c8491a911e4
f0a3d1de89876f4ca54fccb4103b504d50a8347f
f0d2f5c2c000c03aa6b6a29954042174b59a0d1c
f15756428ded1ee01d95934057a6e89c2d450bbb
f1b215fdcd01ff3cc74f1e4194c866573af8034b
f1f63cbb705dc38826369496c6fc12c1b8db1324
f2bc14b69c38b60f201fdf90c08cb2dc8966f331
f2f136c05fb6093818a3b3fefcba46231ac66a62
f3956ebb3bf06ab2266ad5ee2214aed46405810c
f39650de687e35766572ac89dbcd16a5911e2f0a
f4de6a1fa3ee81197239603756fc5c4259e5ef1b
f4fdc0a2edf48f16f7b10cceaf4781fc56ab7fd9
f5714bbb5b3120b33dfbf3d81ffc0b98ae4cd4c1
f5f93d7f5a5cbfef02609dead21e7056e83f4fab
f69b55efef8406113c52f7494d2669ba9d4958c8
f83705a51275ed29117d46e1d68e8b16dcb40507
f84fcb66568c0b00626f7f03e28db7d0dcba8098
f97f5a56f5977311f3833056a73cdbb0ee56cb1e
f9f3f02db98bbe678a8e57fe9432b196174744a3
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
