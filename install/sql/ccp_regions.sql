
DROP TABLE IF EXISTS `ccp_regions`;
CREATE TABLE `ccp_regions` (
  `regionID` int(11) NOT NULL,
  `regionName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `xMin` double DEFAULT NULL,
  `xMax` double DEFAULT NULL,
  `yMin` double DEFAULT NULL,
  `yMax` double DEFAULT NULL,
  `zMin` double DEFAULT NULL,
  `zMax` double DEFAULT NULL,
  `factionID` int(11) DEFAULT NULL,
  `radius` double DEFAULT NULL,
  PRIMARY KEY (`regionID`),
  KEY `factionID` (`factionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


LOCK TABLES `ccp_regions` WRITE;
INSERT INTO `ccp_regions` VALUES (10000001,'Derelik',-7.73619519227769e16,5.08780326643019e16,-6.44331012661154e16,-1.05549987563848e17,-4.91739162817057e16,2.7128553877044e16,7.46275114515598e16,2.64233605110287e16,1.02442842021202e17,500007,3.80097407550867e16),(10000002,'The Forge',-9.64203296646176e16,6.40270758377404e16,1.12539817132904e17,-1.43645654698282e17,-4.9195004630953e16,3.51545563967551e16,9.28995952787257e16,-1.44452603161759e17,-8.06270311040498e16,500001,4.72253250336646e16),(10000003,'Vale of the Silent',-4.40693233378379e16,9.47294441524583e16,1.81384695885577e17,-9.92337602607694e16,1.10951135850936e16,5.82041704075143e16,1.31254717897402e17,-2.18879593357516e17,-1.43889798413638e17,NULL,5.51644369229315e16),(10000004,'UUA-F4',8.98680042578759e16,5.47800960067285e16,2.72575750367217e17,6.73908273200137e16,1.12345181195738e17,1.38650391165171e16,9.569515289694e16,-3.8077417785062e17,-1.64377322883813e17,NULL,1.08198427483404e17),(10000005,'Detorid',1.33540404993619e17,-3.13915018760047e16,-1.96392258478522e17,5.80859178076883e16,2.0899489217955e17,-5.07203320489026e16,-1.20626717031067e16,1.64748864800978e17,2.28035652156066e17,NULL,7.5454487185931e16),(10000006,'Wicked Creek',9.62325935132744e16,2.54172264031303e15,-1.62683939101785e17,5.50942891882897e16,1.37370897838259e17,-1.67797177739814e16,2.18631630546075e16,1.42341340477442e17,1.83026537726129e17,NULL,4.11383043249847e16),(10000007,'Cache',2.44727810799539e17,-1.61851294435097e16,-8.50732831493953e16,1.83951658928238e17,3.05503962670839e17,-4.21314900311268e16,9.76123114410739e15,4.99181459418285e16,1.20228420356962e17,NULL,6.07761518713004e16),(10000008,'Scalding Pass',6.41368176370205e16,5.11467958470643e15,-1.38210100477706e17,1.86366608740231e16,1.09636974400018e17,-2.14856603573735e16,3.17150195267864e16,1.03993036168969e17,1.72427164786443e17,NULL,4.55001567629974e16),(10000009,'Insmother',1.54196834892712e17,2.83511117926583e15,-1.45389178945985e17,1.08381641944456e17,2.00012027840969e17,-4.12171001792075e16,4.68873225377392e16,9.83663313091254e16,1.92412026582845e17,NULL,4.70228476368598e16),(10000010,'Tribute',-1.20113706247411e17,1.00251692022651e17,2.24257843400491e17,-1.80136061822225e17,-6.00913506725963e16,8.17445109258689e16,1.18758873119434e17,-2.48701329588798e17,-1.99814357212184e17,NULL,6.00223555748146e16),(10000011,'Great Wildlands',5.25138376302241e16,2.90566275938602e16,-7.27592077175993e16,1.57875781665387e16,8.92400970939095e16,-4.41701945232586e15,6.25302746400463e16,3.77244332844532e16,1.07793982150745e17,500015,3.67262594636854e16),(10000012,'Curse',1.3928759309586e16,-1.279955725086e15,-1.51114759582865e17,-1.71649024744228e16,4.50224210935949e16,-3.02658596278698e16,2.77059481776978e16,1.35105384527697e17,1.67124134638034e17,500011,3.10936617840089e16),(10000013,'Malpais',1.75707909414576e17,6.84868679773345e16,9.14413531042616e16,1.46522777958075e17,2.04893040871076e17,4.3221875094774e16,9.37518608598951e16,-1.36571342987508e17,-4.63113632210148e16,NULL,4.51299898832468e16),(10000014,'Catch',-1.13595452153499e17,2.1828796395059e16,-2.00997188121673e17,-1.76804941309964e17,-5.03859629970339e16,-1.06431528139274e16,5.43007456040453e16,1.39121469927841e17,2.62872906315506e17,NULL,6.32094891564649e16),(10000015,'Venal',-1.23149072132624e17,1.11405178366885e17,3.08325578657564e17,-1.74025244531813e17,-7.22728997334341e16,9.24544399875372e16,1.30355916746234e17,-3.6182206030276e17,-2.54829097012368e17,500010,5.34964816451961e16),(10000016,'Lonetrek',-1.89171222177239e17,9.45524633509496e16,1.5569612898227e17,-2.33466109933311e17,-1.44876334421167e17,6.99908433405749e16,1.19114083361324e17,-1.93878176320107e17,-1.17514081644434e17,500001,4.4294887756072e16),(10000017,'J7HZ-F',9.26204495038799e15,8.14430314284755e16,2.31053798464132e17,-3.09904199591223e16,4.95145098598983e16,5.98749125846423e16,1.03011150272309e17,-2.78250620384738e17,-1.83856976543526e17,500005,4.71968219206059e16),(10000018,'The Spire',2.32956156642256e17,3.1778178062885e16,2.33673656185098e16,2.02456187021459e17,2.63456126263052e17,-2.64509410030193e15,6.62014502260719e16,-7.00181972826575e16,2.32834660456378e16,NULL,4.66508316641476e16),(10000019,'A821-A',1.36806722191089e16,7.06814661355099e16,2.84135649247806e17,-6.9809772349774e15,3.43423216731951e16,5.66671873025769e16,8.46957449684428e16,-3.33999270054647e17,-2.34272028440965e17,500005,4.98636208068409e16),(10000020,'Tash-Murkon',-2.11753371863879e17,6.2838705971068e16,-1.23934814537664e17,-2.39002211770169e17,-1.8450453195759e17,3.36472743599677e16,9.20301375821683e16,8.85444905536914e16,1.59325138521638e17,500003,3.53903239839731e16),(10000021,'Outer Passage',2.91498150006239e17,4.08628362683461e15,8.03076834578899e16,2.53707828044976e17,3.29288471967503e17,-5.7431940876101e16,6.56045081297702e16,-1.47627280712887e17,-1.29880862028926e16,NULL,6.73195972549974e16),(10000022,'Stain',-1.58827678964844e17,5.86911904756425e16,-3.09223961465603e17,-2.20896070661677e17,-9.67592872680104e16,1.64015339885485e16,1.00980846962736e17,2.54043792338772e17,3.64404130592435e17,500019,6.20683916968335e16),(10000023,'Pure Blind',-2.60921882715692e17,7.89792661914274e16,2.20225532514732e17,-3.19394067132735e17,-2.02449698298649e17,3.65273054064862e16,1.21431226976369e17,-2.38553930773527e17,-2.01897134255937e17,NULL,5.8472184417043e16),(10000025,'Immensea',2.18929141598659e16,-3.0178289457794e15,-2.05784180881658e17,-2.28953868973768e16,6.66812152171086e16,-2.35303393969113e16,1.74946815053525e16,1.65767307374258e17,2.45801054389059e17,NULL,4.47883010572427e16),(10000027,'Etherium Reach',1.28382041362752e17,5.63771470967499e16,3.78681983031999e16,6.79555705924636e16,1.8880851213304e17,2.90848064204492e16,8.36694877730506e16,-7.99584057326113e16,4.22200912621145e15,NULL,6.04264707702884e16),(10000028,'Molden Heath',-3.57221136222882e16,4.35032539761976e15,-5.3761035732505e15,-5.71246322750231e16,-1.43195949695533e16,-1.10255693317814e16,1.97262201270209e16,-7.29743765632795e15,1.8049644802829e16,500002,2.14025186527349e16),(10000029,'Geminate',-1.58339265318656e16,5.9778184289369e16,1.15546529090021e17,-4.51374800544612e16,1.34696269907301e16,2.35419857795319e16,9.6014382799206e16,-1.37261979990137e17,-9.38310781899044e16,NULL,3.62361985098371e16),(10000030,'Heimatar',-9.29292854916007e16,3.21243916270895e16,2.41487213993692e16,-1.28269338426337e17,-5.7589232556864e16,5.11770923668872e15,5.91310740174903e16,-5.15767742261278e16,3.27933142738942e15,500002,3.53400529347367e16),(10000031,'Impass',-3.86061671297053e16,-1.84003793729434e15,-3.34948558437469e17,-4.62721531634544e16,-3.09401810959562e16,-3.05280484810207e16,2.68479726064321e16,3.05300973053793e17,3.64596143821145e17,NULL,2.96475853836758e16),(10000032,'Sinq Laison',-1.8191288307648e17,4.16995387869047e16,3.97807386770742e16,-2.1861963981745e17,-1.4520612633551e17,1.48380410116087e16,6.85610365622007e16,-8.52575992950059e16,5.69612194085744e15,500004,4.54768606179316e16),(10000033,'The Citadel',-1.54620630524369e17,7.85949741104122e16,1.04821797629467e17,-1.87991094902498e17,-1.21250166146241e17,4.73322945841131e16,1.09857653636711e17,-1.48876595282702e17,-6.07669999762324e16,500001,4.40547976532346e16),(10000034,'The Kalevala Expanse',1.33941223410126e17,5.48098880590211e16,9.49795793781928e16,1.10709276315877e17,1.57173170504376e17,2.82901795268722e16,8.132959659117e16,-1.3003897205883e17,-5.99201866975554e16,NULL,3.50593926806374e16),(10000035,'Deklein',-2.76352540202201e17,8.97693275886591e16,3.10283495605706e17,-3.57288458792002e17,-1.954166216124e17,5.18059655119402e16,1.27732689665378e17,-3.52811725566156e17,-2.67755265645256e17,NULL,8.09359185898008e16),(10000036,'Devoid',-1.41697960063521e17,5.84415722744845e16,-6.33341101553482e16,-1.69282385386756e17,-1.14113534740286e17,2.20565223655273e16,9.48266221834416e16,3.03229716804472e16,9.63452486302492e16,500003,3.63850499089572e16),(10000037,'Everyshore',-1.9482201329428e17,8.82766302928309e15,2.02559538049208e16,-2.15583579631562e17,-1.74060446956999e17,-1.25330145532052e16,3.01883406117714e16,-3.12152391248727e16,-9.29666848496889e15,500004,2.13606775824883e16),(10000038,'The Bleak Lands',-1.59172230516598e17,3.1388510588133e16,-5.09367503653776e16,-1.7483440740064e17,-1.43510053632557e17,1.70381991240675e15,6.10732012638592e16,3.28615815053855e16,6.90119192253696e16,500003,2.96846906757262e16),(10000039,'Esoteria',-8.67878647136856e16,-1.69771319821958e16,-4.17232597484758e17,-1.21897659027506e17,-5.16780703998651e16,-6.01297519478345e16,2.61754879834429e16,3.62533200787439e17,4.71931994182076e17,NULL,5.46993966973185e16),(10000040,'Oasa',2.33391636757061e17,6.33356815054524e16,1.22542259755245e17,1.94254750307969e17,2.72528523206153e17,3.54992761639762e16,9.11720868469286e16,-1.74387649267655e17,-7.06968702428351e16,NULL,5.184538951241e16),(10000041,'Syndicate',-3.21246237025975e17,1.94581306252099e16,7.41640134588306e16,-3.62419022806808e17,-2.80073451245142e17,-7.41201724670466e15,4.63282784971244e16,-1.11626842054837e17,-3.67011848628242e16,500009,4.11727857808327e16),(10000042,'Metropolis',-7.4267055557312e16,3.57986387205552e16,4.5153300095399e16,-1.37997971841353e17,-1.05361392732709e16,-6.95309320897108e15,7.85503706500816e16,-7.9085709291585e16,-1.1220890899213e16,500002,6.37309162840411e16),(10000043,'Domain',-2.00437833726153e17,5.35617009322068e16,-8.13552390856334e16,-2.5404992057699e17,-1.46825746875317e17,1.29994217837693e16,9.41239800806443e16,1.82037728918344e16,1.44506705279432e17,500003,6.3151466193799e16),(10000044,'Solitude',-3.21931746318951e17,2.82563292166004e16,1.92761063328414e16,-3.39484138934816e17,-3.04379353703085e17,4.65055463885324e15,5.18621037943476e16,-4.41186420514449e16,5.56642938576211e15,500004,2.48425357186035e16),(10000045,'Tenal',-7.22878851336202e16,5.83402765876594e16,4.33602446107849e17,-1.16748577875113e17,-2.78271923921271e16,1.51079457624212e16,1.01572607412898e17,-4.58300452818907e17,-4.08904439396791e17,NULL,4.44606927414931e16),(10000046,'Fade',-2.93951880420984e17,5.87388643638547e16,2.57748117411352e17,-3.21962586144748e17,-2.6594117469722e17,3.46631658809204e16,8.28145628467889e16,-2.62210335614023e17,-2.53285899208681e17,NULL,2.80107057237639e16),(10000047,'Providence',-1.21750759712201e17,5.84956514023328e16,-1.51515874111716e17,-1.47682648205223e17,-9.58188712191787e16,3.11091127245759e16,8.58821900800897e16,1.04761552559676e17,1.98270195663755e17,NULL,4.67543215520394e16),(10000048,'Placid',-2.70798690016689e17,7.37017968120536e16,9.54644596776992e16,-2.95050806700007e17,-2.46546573333371e17,3.36872926317309e16,1.13716300992376e17,-1.35456400892811e17,-5.54725184625871e16,500004,4.00145041803227e16),(10000049,'Khanid',-3.18287416184579e17,2.04194140942048e16,-1.33487524109219e17,-3.64404836850034e17,-2.72169995519124e17,-2.33759555544046e16,6.42147837428142e16,9.43131932414724e16,1.72661854976965e17,500008,4.61174206654551e16),(10000050,'Querious',-3.63413099563972e17,5.32206504463178e16,-2.40706130531269e17,-4.21044001198138e17,-3.05782197929807e17,1.70995639818707e16,8.93417369107648e16,1.78498284629578e17,3.0291397643296e17,NULL,6.2207845901691e16),(10000051,'Cloud Ring',-3.20933851367644e17,7.44221973684437e16,1.46459468769175e17,-3.34343216505568e17,-3.0752448622972e17,5.45042517911353e16,9.43401429457521e16,-1.76405700933117e17,-1.16513236605233e17,NULL,2.9946232163942e16),(10000052,'Kador',-2.37297480079981e17,4.06803388298497e16,-7.68309672978193e16,-2.65099009094967e17,-2.09495951064995e17,1.42393603640819e16,6.71213172956175e16,2.19472682490724e16,1.31714666346566e17,500003,5.48836990487469e16),(10000053,'Cobalt Edge',2.92184365554962e17,5.3493388123815e16,2.04625108850392e17,2.73407634801881e17,3.10961096308044e17,3.33471404002244e16,7.36396358474057e16,-2.6495783155322e17,-1.44292386147564e17,NULL,6.03327227028279e16),(10000054,'Aridia',-3.68177411221382e17,1.8612570807884e16,-7.77703156867333e16,-4.13892030804226e17,-3.22462791638538e17,-5.88318298373161e15,4.31083245994996e16,3.85104046706074e16,1.17030226702859e17,500003,4.57146195828439e16),(10000055,'Branch',-1.45831957034714e17,6.69152473299556e16,4.12717925093977e17,-1.92334882877541e17,-9.93290311918867e16,4.58998266984162e16,8.79306679614949e16,-4.68006802398913e17,-3.57429047789041e17,NULL,5.5288877304936e16),(10000056,'Feythabolis',3.06473180472628e16,-1.60973888340617e16,-4.03080457499606e17,-1.34273592513705e16,7.47219953458962e16,-4.75388413079439e16,1.53440636398205e16,3.38718234219339e17,4.67442680779874e17,NULL,6.43622232802675e16),(10000057,'Outer Ring',-3.92563738530011e17,2.16719327072278e16,8.63772810266471e16,-4.40630233235487e17,-3.44497243824534e17,8.45468549621117e15,3.48891799182445e16,-1.14159691483192e17,-5.85948705701025e16,500014,4.80664947054762e16),(10000058,'Fountain',-4.49013589606488e17,3.72273790653831e16,-6.02436903624757e15,-5.03218614776421e17,-3.94808564436556e17,1.2825904470868e16,6.16288536598981e16,-5.2236755323923e16,6.42854933964182e16,NULL,5.82611243601706e16),(10000059,'Paragon Soul',-1.13652861165762e17,-2.63610116407273e16,-4.71184672814804e17,-1.47103312663208e17,-8.02024096683158e16,-4.78847916401597e16,-4.83723164129496e15,4.62265945308572e17,4.80103400321037e17,NULL,3.34504514974463e16),(10000060,'Delve',-4.29369275408752e17,5.14261210036259e16,-2.56560110972769e17,-4.65524711410822e17,-3.93213839406682e17,2.07843019851014e16,8.20679400221505e16,1.87448411080601e17,3.25671810864938e17,NULL,6.91116998921684e16),(10000061,'Tenerifis',4.73954351430703e16,-1.20252783045126e16,-2.85986932642694e17,-3.11422520279319e16,1.25933122314073e17,-4.1257255525995e16,1.72066989169697e16,2.42460862907173e17,3.29513002378215e17,NULL,7.85376871710022e16),(10000062,'Omist',1.00319291593819e17,-2.74861101664417e16,-3.89560313235004e17,5.24683243798056e16,1.48170258807832e17,-4.64264150594276e16,-8.54580527345574e15,3.68934289108777e17,4.10186337361231e17,NULL,4.78509672140133e16),(10000063,'Period Basis',-4.14504229299553e17,8.37884856539599e16,-3.86878506419457e17,-4.40202713206804e17,-3.88805745392302e17,6.61060451659501e16,1.0147092614197e17,3.55667366886337e17,4.18089645952577e17,NULL,3.12111395331198e16),(10000064,'Essence',-2.18476380293209e17,3.60796913432749e16,5.374393363481e16,-2.37409458368698e17,-1.99543302217719e17,7.63359742440284e15,6.4525785262147e16,-7.96099900064932e16,-2.78778772631268e16,500004,2.84460939188721e16),(10000065,'Kor-Azor',-2.96212317520309e17,4.16186484702717e16,-1.04651247949499e17,-3.58902782416633e17,-2.33521852623984e17,-1.01508065143189e15,8.42523775919754e16,7.28202220358183e16,1.3648227386318e17,500003,6.26904648963246e16),(10000066,'Perrigen Falls',2.11874376981372e17,2.59047481640165e16,1.0710786683887e17,1.76484345431306e17,2.47264408531438e17,-5.43419127781609e15,5.7243687605849e16,-1.65684697545403e17,-4.85310361323373e16,NULL,5.85768307065329e16),(10000067,'Genesis',-2.60029907705174e17,1.48896484523138e16,-1.54319941304413e16,-2.99197792151819e17,-2.20862023258529e17,-1.97626992750815e16,4.95419961797091e16,-2.32802124881732e16,5.41442007490558e16,500003,3.91678844466449e16),(10000068,'Verge Vendor',-2.4249831284325e17,4.11701036114539e16,5.15574510559666e16,-2.58065601351461e17,-2.26931024335039e17,3.15825336093158e16,5.0757673613592e16,-6.5212930160258e16,-3.79019719516752e16,500004,1.55672885082112e16),(10000069,'Black Rise',-2.22687068034734e17,7.75594106422084e16,1.36029596082308e17,-3.03606258828316e17,-1.41767877241152e17,-3.35978015137349e15,1.5847860143579e17,-2.1694878687589e17,-5.51104052887266e16,500001,8.09191907935819e16),(11000001,'A-R00001',7.6376170763493e18,1.53938548528604e18,-9.49761120633649e18,7.62372970580783e18,7.66515729534589e18,1.51867169051701e18,1.56009928005507e18,9.47793351789179e18,9.51936110742985e18,NULL,2.07137947690292e16),(11000002,'A-R00002',7.60093452720375e18,1.53937228994168e18,-9.43050266383318e18,7.54791022224037e18,7.6606644918872e18,1.48299515511827e18,1.59574942476509e18,9.37369281178424e18,9.48644708143106e18,NULL,5.63771348234115e16),(11000003,'A-R00003',7.66138628000036e18,1.53936778897025e18,-9.33859380181365e18,7.60993163074189e18,7.71285837914485e18,1.48790441476877e18,1.59083116317173e18,9.28512427019715e18,9.38805101860011e18,NULL,5.14633742014793e16),(11000004,'B-R00004',7.76033681841794e18,1.53934949521826e18,-9.34005958951567e18,7.73712696111448e18,7.7932804103653e18,1.51127277059285e18,1.56742621984368e18,9.31008265934467e18,9.3662361085955e18,NULL,2.8076724625412e16),(11000005,'B-R00005',7.87407952364896e18,1.53937548374647e18,-9.50307128858908e18,7.83828528059015e18,7.92769229280426e18,1.49467197763941e18,1.58407898985352e18,9.45711810540402e18,9.54652511761814e18,NULL,4.47035061070555e16),(11000006,'B-R00006',7.83104454414719e18,1.53938267375931e18,-9.65985350373619e18,7.79994882705669e18,7.86546701886105e18,1.50662357785713e18,1.57214176966149e18,9.62724856472384e18,9.6927667565282e18,NULL,3.27590959021796e16),(11000007,'B-R00007',7.634045819572e18,1.53936591888914e18,-9.73238855564729e18,7.58213191849959e18,7.67956658609747e18,1.4906485850902e18,1.58808325268809e18,9.67403431968661e18,9.7714689872845e18,NULL,4.87173337989423e16),(11000008,'B-R00008',7.50509863182053e18,1.53934455171856e18,-9.63712977069197e18,7.46253099555506e18,7.54254331247867e18,1.49933839325675e18,1.57935071018036e18,9.59611621761083e18,9.67612853453444e18,NULL,4.00061584618046e16),(11000009,'C-R00009',7.75699845847083e18,1.53936284785932e18,-9.83833510697693e18,7.73389261027392e18,7.79243065915667e18,1.51009382341794e18,1.56863187230069e18,9.80832498880011e18,9.86686303768287e18,NULL,2.92690244413742e16),(11000010,'C-R00010',7.4580208974422e18,1.53938684407856e18,-9.70053875668015e18,7.42573545603561e18,7.4906177570058e18,1.50694569359346e18,1.57182799456366e18,9.66471986025467e18,9.72960216122487e18,NULL,3.24411504850982e16),(11000011,'C-R00011',7.40480108808294e18,1.53941550326979e18,-9.45356649904654e18,7.36124648528109e18,7.44416028674046e18,1.4979586025401e18,1.58087240399947e18,9.41240985656068e18,9.49532365802006e18,NULL,4.1456900729688e16),(11000012,'C-R00012',7.46732745097755e18,1.53941094882098e18,-9.32407984332594e18,7.42513594855905e18,7.50780366644981e18,1.4980770898756e18,1.58074480776636e18,9.28122547524785e18,9.3638931931386e18,NULL,4.13338589453785e16),(11000013,'C-R00013',7.70433183253458e18,1.53943519529185e18,-9.21917794935557e18,7.63056680875309e18,7.74579437149411e18,1.48182141392134e18,1.59704897666236e18,9.16952753637057e18,9.2847550991116e18,NULL,5.76137813705106e16),(11000014,'C-R00014',7.91323176406101e18,1.5394119054189e18,-9.30406974807733e18,7.89183589905819e18,7.93325947584566e18,1.51870011702516e18,1.56012369381264e18,9.28869607876491e18,9.33011965555239e18,NULL,2.07117883937359e16),(11000015,'C-R00015',7.97427471745672e18,1.53940596743392e18,-9.45075602574961e18,7.93734376064457e18,8.01908660356709e18,1.49853454597265e18,1.58027738889518e18,9.41015348901336e18,9.49189633193589e18,NULL,4.08714214612627e16),(11000016,'D-R00016',7.95041209925582e18,1.53941718859128e18,-9.6454735723554e18,7.90177932973846e18,7.98120156374385e18,1.49970607158859e18,1.57912830559398e18,9.59732328186493e18,9.67674551587033e18,NULL,3.97111170026985e16),(11000017,'D-R00017',7.7519840753406e18,1.53942297029686e18,-9.78070882037282e18,7.74253205069414e18,7.78656702700429e18,1.51740548214179e18,1.56144045845193e18,9.74799164759289e18,9.79202662390304e18,NULL,2.20174881550739e16),(11000018,'D-R00018',7.56842521209659e18,1.53942275948411e18,-9.70516175784687e18,7.52486968352331e18,7.59782827491401e18,1.50294346378876e18,1.57590205517946e18,9.67740970341119e18,9.75036829480189e18,NULL,3.64792956953487e16),(11000019,'D-R00019',7.44636914443112e18,1.53941344668532e18,-9.56413578288673e18,7.40523802999379e18,7.4893487881372e18,1.49735806761361e18,1.58146882575702e18,9.51969654196901e18,9.60380730011242e18,NULL,4.20553790717047e16),(11000020,'D-R00020',7.38687628605459e18,1.53943665746912e18,-9.25846082480078e18,7.33651803899941e18,7.45065162067399e18,1.48236986663183e18,1.5965034483064e18,9.19870982711003e18,9.31284340878461e18,NULL,5.70667908372876e16),(11000021,'D-R00021',7.57566761441511e18,1.53942079142861e18,-9.12118297000297e18,7.53140303095667e18,7.63573967496599e18,1.48725246942394e18,1.59158911343327e18,9.07455130578647e18,9.1788879497958e18,NULL,5.2168322004663e16),(11000022,'D-R00022',7.97989002792439e18,1.53942341490048e18,-9.21142180614625e18,7.92964286500324e18,8.02579218314387e18,1.49134875583016e18,1.58749807397079e18,9.16616767002207e18,9.2623169881627e18,NULL,4.80746590703154e16),(11000023,'D-R00023',8.08432384198008e18,1.53940109532268e18,-9.71301020294385e18,8.03696747446985e18,8.14337437973661e18,1.48619764268931e18,1.59260454795606e18,9.65341878332365e18,9.75982568859041e18,NULL,5.32034526333779e16),(11000024,'E-R00024',7.17196241286489e18,1.5393641347901e18,-9.35081170884114e18,7.11560708039207e18,7.22923483798357e18,1.48255025599435e18,1.59617801358585e18,9.29387514449117e18,9.40750290208267e18,NULL,5.68138787957499e16),(11000025,'E-R00025',7.33482171042828e18,1.53937635072987e18,-9.11037866197497e18,7.30478471586241e18,7.3523971245121e18,1.51557014640503e18,1.56318255505472e18,9.08184117812085e18,9.12945358677054e18,NULL,2.3806204324844e16),(11000026,'E-R00026',7.70970984920561e18,1.53935180604977e18,-8.98396003844671e18,7.64854375745104e18,7.76794044000599e18,1.4796534647723e18,1.59905014732724e18,8.92201229959521e18,9.04140898215016e18,NULL,5.96983412774739e16),(11000027,'E-R00027',8.17759165515952e18,1.53936193256599e18,-9.31126461189726e18,8.13097315019258e18,8.23328624361724e18,1.48820538585366e18,1.59051847927832e18,9.26182363391695e18,9.36413672734161e18,NULL,5.11565467123302e16),(11000028,'E-R00028',8.05051276327506e18,1.53938700010354e18,-9.89276475978326e18,8.00428938667613e18,8.09610445747903e18,1.49347946470209e18,1.58529453550499e18,9.84934544495731e18,9.94116051576021e18,NULL,4.59075354014499e16),(11000029,'E-R00029',7.59330303106683e18,1.53936695954349e18,-1.00130722972537e19,7.56367192536078e18,7.61213428230879e18,1.51513578106949e18,1.5635981380175e18,9.9834305480215e18,1.00318929049695e19,NULL,2.42311784740034e16),(11000030,'F-R00030',7.3055329070805e18,1.53938852874337e18,-9.83844840594143e18,7.24186951008628e18,7.36032502533014e18,1.48016077112144e18,1.5986162863653e18,9.77764227783185e18,9.89609779307571e18,NULL,5.92277576219281e16);
UNLOCK TABLES;

