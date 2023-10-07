function bytecode_misc ()
  % Assure "set_internal_variable" are reset properly
  max_stack = max_stack_depth;
  set_max_stack_depth_1p (max_stack + 1);
  assert (max_stack_depth == max_stack);

  % Check that the WIDE opcode extension works
  wide_sub();

  % Try to run out of allowed number of stack frames
  threw_up = false;
  try
    stack_overflow (max_stack * 2); % Should hit the limit
  catch
    threw_up = true;
  end

  assert (threw_up);

  % Try to run out of VM stack space
  % Assure that the VM is running, since we will disable the tree_evaluators
  % stack limit mechanism.
  if __vm_is_executing__ ()
    absurd_frame_limit = max_stack_depth * 10000;
    max_stack_depth (absurd_frame_limit, "local");

    threw_up = false;
    try
      stack_overflow (absurd_frame_limit); % Should hit the VM limit
    catch
      threw_up = true;
    end
    assert (threw_up);
  end
end

function set_max_stack_depth_1p (x)
  max_stack_depth (x + 1, "local");
  assert (max_stack_depth == x + 1);
end

function stack_overflow (n)
  if n != 0
    stack_overflow (n - 1);
  end
end

function wide_sub ()
  % 512 locals
  a001=1; a002=2; a003=3; a004=4; a005=5; a006=6; a007=7; a008=8; a009=9; a010=10; a011=11; a012=12; a013=13; a014=14; a015=15; a016=16; a017=17; a018=18; a019=19; a020=20; a021=21; a022=22; a023=23; a024=24; a025=25; a026=26; a027=27; a028=28; a029=29; a030=30; a031=31; a032=32; a033=33; a034=34; a035=35; a036=36; a037=37; a038=38; a039=39; a040=40; a041=41; a042=42; a043=43; a044=44; a045=45; a046=46; a047=47; a048=48; a049=49; a050=50; a051=51; a052=52; a053=53; a054=54; a055=55; a056=56; a057=57; a058=58; a059=59; a060=60; a061=61; a062=62; a063=63; a064=64; a065=65; a066=66; a067=67; a068=68; a069=69; a070=70; a071=71; a072=72; a073=73; a074=74; a075=75; a076=76; a077=77; a078=78; a079=79; a080=80; a081=81; a082=82; a083=83; a084=84; a085=85; a086=86; a087=87; a088=88; a089=89; a090=90; a091=91; a092=92; a093=93; a094=94; a095=95; a096=96; a097=97; a098=98; a099=99; a100=100; a101=101; a102=102; a103=103; a104=104; a105=105; a106=106; a107=107; a108=108; a109=109; a110=110; a111=111; a112=112; a113=113; a114=114; a115=115; a116=116; a117=117; a118=118; a119=119; a120=120; a121=121; a122=122; a123=123; a124=124; a125=125; a126=126; a127=127; a128=128; a129=129; a130=130; a131=131; a132=132; a133=133; a134=134; a135=135; a136=136; a137=137; a138=138; a139=139; a140=140; a141=141; a142=142; a143=143; a144=144; a145=145; a146=146; a147=147; a148=148; a149=149; a150=150; a151=151; a152=152; a153=153; a154=154; a155=155; a156=156; a157=157; a158=158; a159=159; a160=160; a161=161; a162=162; a163=163; a164=164; a165=165; a166=166; a167=167; a168=168; a169=169; a170=170; a171=171; a172=172; a173=173; a174=174; a175=175; a176=176; a177=177; a178=178; a179=179; a180=180; a181=181; a182=182; a183=183; a184=184; a185=185; a186=186; a187=187; a188=188; a189=189; a190=190; a191=191; a192=192; a193=193; a194=194; a195=195; a196=196; a197=197; a198=198; a199=199; a200=200; a201=201; a202=202; a203=203; a204=204; a205=205; a206=206; a207=207; a208=208; a209=209; a210=210; a211=211; a212=212; a213=213; a214=214; a215=215; a216=216; a217=217; a218=218; a219=219; a220=220; a221=221; a222=222; a223=223; a224=224; a225=225; a226=226; a227=227; a228=228; a229=229; a230=230; a231=231; a232=232; a233=233; a234=234; a235=235; a236=236; a237=237; a238=238; a239=239; a240=240; a241=241; a242=242; a243=243; a244=244; a245=245; a246=246; a247=247; a248=248; a249=249; a250=250; a251=251; a252=252; a253=253; a254=254; a255=255; a256=256; a257=257; a258=258; a259=259; a260=260; a261=261; a262=262; a263=263; a264=264; a265=265; a266=266; a267=267; a268=268; a269=269; a270=270; a271=271; a272=272; a273=273; a274=274; a275=275; a276=276; a277=277; a278=278; a279=279; a280=280; a281=281; a282=282; a283=283; a284=284; a285=285; a286=286; a287=287; a288=288; a289=289; a290=290; a291=291; a292=292; a293=293; a294=294; a295=295; a296=296; a297=297; a298=298; a299=299; a300=300; a301=301; a302=302; a303=303; a304=304; a305=305; a306=306; a307=307; a308=308; a309=309; a310=310; a311=311; a312=312; a313=313; a314=314; a315=315; a316=316; a317=317; a318=318; a319=319; a320=320; a321=321; a322=322; a323=323; a324=324; a325=325; a326=326; a327=327; a328=328; a329=329; a330=330; a331=331; a332=332; a333=333; a334=334; a335=335; a336=336; a337=337; a338=338; a339=339; a340=340; a341=341; a342=342; a343=343; a344=344; a345=345; a346=346; a347=347; a348=348; a349=349; a350=350; a351=351; a352=352; a353=353; a354=354; a355=355; a356=356; a357=357; a358=358; a359=359; a360=360; a361=361; a362=362; a363=363; a364=364; a365=365; a366=366; a367=367; a368=368; a369=369; a370=370; a371=371; a372=372; a373=373; a374=374; a375=375; a376=376; a377=377; a378=378; a379=379; a380=380; a381=381; a382=382; a383=383; a384=384; a385=385; a386=386; a387=387; a388=388; a389=389; a390=390; a391=391; a392=392; a393=393; a394=394; a395=395; a396=396; a397=397; a398=398; a399=399; a400=400; a401=401; a402=402; a403=403; a404=404; a405=405; a406=406; a407=407; a408=408; a409=409; a410=410; a411=411; a412=412; a413=413; a414=414; a415=415; a416=416; a417=417; a418=418; a419=419; a420=420; a421=421; a422=422; a423=423; a424=424; a425=425; a426=426; a427=427; a428=428; a429=429; a430=430; a431=431; a432=432; a433=433; a434=434; a435=435; a436=436; a437=437; a438=438; a439=439; a440=440; a441=441; a442=442; a443=443; a444=444; a445=445; a446=446; a447=447; a448=448; a449=449; a450=450; a451=451; a452=452; a453=453; a454=454; a455=455; a456=456; a457=457; a458=458; a459=459; a460=460; a461=461; a462=462; a463=463; a464=464; a465=465; a466=466; a467=467; a468=468; a469=469; a470=470; a471=471; a472=472; a473=473; a474=474; a475=475; a476=476; a477=477; a478=478; a479=479; a480=480; a481=481; a482=482; a483=483; a484=484; a485=485; a486=486; a487=487; a488=488; a489=489; a490=490; a491=491; a492=492; a493=493; a494=494; a495=495; a496=496; a497=497; a498=498; a499=499; a500=500; a501=501; a502=502; a503=503; a504=504; a505=505; a506=506; a507=507; a508=508; a509=509; a510=510; a511=511; a512=512;

  assert (a511 == 511);
  assert (a512 == 512);
  assert (a400 + a500 == 900);

  % Do some ops to check that WIDE does not mess things up

  % Loop to test specializations and despecializations
  for j = 1:4
    b = 3;
    c = 4;
    d = b * c;
    assert (d == 12);

    e = [1 2 3 4];
    two = 2;
    if (j == 3)
      e = single (e); % despecialization
      two = single (two);
    end

    assert (e(2) == 2);
    assert (e(2) == two);
    e(3) = 11;
    assert (e(3) == 11);

    assert (e(end) == 4);
    assert (e(end - 1) == 11);

    f = [5 6 7 8; 9 10 11 12];
    six = 6;
    if (j == 3)
      f = single (f); % despecialization
      six = single (six);
    end
    assert (f(1,2) == 6);
    assert (f(1,2) == six);
    f(1,2) = 7;
    assert (f(1,2) == 7);

    g = 0;
    if (j == 3)
      g = single (g); % despecialization
    end

    g++;
    assert (g == 1);
    ++g;
    assert (g == 2);
    g += 3;
    assert (g == 5);
    eval ("assert (g == 5);")

    sum = 0;
    for i = 1:3 % WIDE FOR_COND
      sum += i;
    end
    assert (sum == 6);

    s.s = 2;
    assert (s.s == 2);
    s.w.s = 3;
    assert (s.w.s == 3);

    % Test command function calling
    pi; % WIDE PUSH_PI
    assert (round (100 * pi) == 314)

    suby1;
    assert (suby1 == 1);
    suby2;
    [a, b] = suby2;
    assert (a == 1)
    assert (b == 2)
    [a, b] = suby2 ();
    assert (a == 1)
    assert (b == 2)
  end


  % Check that a001 to a512 have to correct values
  for i = 1:512
    eval (sprintf ("assert (a%03d == %d);", i, i));
  end
end

function ret = suby1
  ret = 1;
end

function [a, b] = suby2
  a = 1; b = 2;
end