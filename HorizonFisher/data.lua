--[[
Copyright 2019-2020 Seth VanHeulen

This file is part of a fork of fisher, modified by Bee.

fisher is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

fisher is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with fisher.  If not, see <https://www.gnu.org/licenses/>.
--]]

-- luacheck: std lua51, no max line length

local data = {}

data.item_fishing_parameters = {
    -- fish items
    {name='bibiki urchin', id=4318, stamina=19, arrow_duration=15, arrow_frequency=1, stamina_depletion=20},
    {name='lamp marimo', id=2216, stamina=19, arrow_duration=15, arrow_frequency=1, stamina_depletion=26},
    {name='phanauet newt', id=5125, stamina=20, arrow_duration=12, arrow_frequency=12, stamina_depletion=13},
    {name='cobalt jellyfish', id=4443, stamina=20, arrow_duration=15, arrow_frequency=1, stamina_depletion=28, continent=5},
    {name='denizanasi', id=5447, stamina=20, arrow_duration=15, arrow_frequency=1, stamina_depletion=28, continent=2},
    {name='crayfish', id=4472, stamina=21, arrow_duration=15, arrow_frequency=7, stamina_depletion=24},
    {name='ulbukan lobster', id=5960, stamina=21, arrow_duration=15, arrow_frequency=7, stamina_depletion=24, continent=4},
    {name='bibikibo', id=4314, stamina=22, arrow_duration=14, arrow_frequency=4, stamina_depletion=22},
    {name='bastore sardine', id=4360, stamina=22, arrow_duration=13, arrow_frequency=7, stamina_depletion=21, continent=1},
    {name='bastore sardine', id=4360, stamina=22, arrow_duration=13, arrow_frequency=7, stamina_depletion=21, count=2, continent=1},
    {name='bastore sardine', id=4360, stamina=22, arrow_duration=13, arrow_frequency=7, stamina_depletion=21, count=3, continent=1},
    {name='hamsi', id=5449, stamina=22, arrow_duration=13, arrow_frequency=7, stamina_depletion=21, continent=2},
    {name='hamsi', id=5449, stamina=22, arrow_duration=13, arrow_frequency=7, stamina_depletion=21, count=2, continent=2},
    {name='hamsi', id=5449, stamina=22, arrow_duration=13, arrow_frequency=7, stamina_depletion=21, count=3, continent=2},
    {name='senroh sardine', id=5963, stamina=22, arrow_duration=13, arrow_frequency=7, stamina_depletion=21, continent=4},
    {name='senroh sardine', id=5963, stamina=22, arrow_duration=13, arrow_frequency=7, stamina_depletion=21, count=2, continent=4},
    {name='senroh sardine', id=5963, stamina=22, arrow_duration=13, arrow_frequency=7, stamina_depletion=21, count=3, continent=4},
    {name='moat carp', id=4401, stamina=23, arrow_duration=12, arrow_frequency=10, stamina_depletion=16},
    {name='bastore sweeper', id=5473, stamina=24, arrow_duration=6, arrow_frequency=3, stamina_depletion=17},
    {name="ra'kaznar shellfish", id=6334, stamina=24, arrow_duration=14, arrow_frequency=4, stamina_depletion=17},
    {name='mackerel', id=5950, stamina=24, arrow_duration=11, arrow_frequency=9, stamina_depletion=18},
    {name='greedie', id=4500, stamina=25, arrow_duration=9, arrow_frequency=15, stamina_depletion=10},
    {name='copper frog', id=4515, stamina=26, arrow_duration=10, arrow_frequency=5, stamina_depletion=22, continent=3},
    {name='senroh frog', id=5993, stamina=26, arrow_duration=10, arrow_frequency=5, stamina_depletion=22, continent=4},
    {name='yellow globe', id=4403, stamina=26, arrow_duration=10, arrow_frequency=9, stamina_depletion=17},
    {name='yellow globe', id=4403, stamina=26, arrow_duration=10, arrow_frequency=9, stamina_depletion=17, count=2},
    {name='yellow globe', id=4403, stamina=26, arrow_duration=10, arrow_frequency=9, stamina_depletion=17, count=3},
    {name='muddy siredon', id=5126, stamina=27, arrow_duration=14, arrow_frequency=12, stamina_depletion=23},
    {name='istavrit', id=5136, stamina=27, arrow_duration=8, arrow_frequency=12, stamina_depletion=13, size=1},
    {name='translucent salpa', id=6333, stamina=27, arrow_duration=8, arrow_frequency=8, stamina_depletion=14},
    {name='quus', id=4514, stamina=27, arrow_duration=9, arrow_frequency=12, stamina_depletion=12},
    {name='quus', id=4514, stamina=27, arrow_duration=9, arrow_frequency=12, stamina_depletion=12, count=2},
    {name='quus', id=4514, stamina=27, arrow_duration=9, arrow_frequency=12, stamina_depletion=12, count=3},
    {name='tiny goldfish', id=4310, stamina=28, arrow_duration=2, arrow_frequency=15, stamina_depletion=22},
    {name='tiny goldfish', id=4310, stamina=28, arrow_duration=2, arrow_frequency=15, stamina_depletion=22, count=2},
    {name='tiny goldfish', id=4310, stamina=28, arrow_duration=2, arrow_frequency=15, stamina_depletion=22, count=3},
    {name='forest carp', id=4289, stamina=28, arrow_duration=11, arrow_frequency=12, stamina_depletion=11},
    {name='cheval salmon', id=4379, stamina=28, arrow_duration=9, arrow_frequency=8, stamina_depletion=21},
    {name='contortopus', id=5961, stamina=29, arrow_duration=9, arrow_frequency=13, stamina_depletion=16},
    {name='yorchete', id=5536, stamina=29, arrow_duration=11, arrow_frequency=10, stamina_depletion=15},
    {name='white lobster', id=6335, stamina=29, arrow_duration=9, arrow_frequency=11, stamina_depletion=15},
    {name='fat greedie', id=4501, stamina=30, arrow_duration=12, arrow_frequency=9, stamina_depletion=30},
    {name='moorish idol', id=5121, stamina=31, arrow_duration=8, arrow_frequency=12, stamina_depletion=18},
    {name='gurnard', id=5132, stamina=31, arrow_duration=5, arrow_frequency=12, stamina_depletion=13},
    {name='tricolored carp', id=4426, stamina=31, arrow_duration=14, arrow_frequency=13, stamina_depletion=19},
    {name='nebimonite', id=4361, stamina=31, arrow_duration=11, arrow_frequency=6, stamina_depletion=30},
    {name='blindfish', id=4313, stamina=31, arrow_duration=8, arrow_frequency=9, stamina_depletion=18},
    {name='pipira', id=4464, stamina=32, arrow_duration=8, arrow_frequency=15, stamina_depletion=11},
    {name='tiger cod', id=4483, stamina=32, arrow_duration=11, arrow_frequency=10, stamina_depletion=23},
    {name='elshimo frog', id=4290, stamina=33, arrow_duration=9, arrow_frequency=6, stamina_depletion=25, continent=5},
    {name='caedarva frog', id=5465, stamina=33, arrow_duration=9, arrow_frequency=6, stamina_depletion=25, continent=2},
    {name='bonefish', id=6336, stamina=33, arrow_duration=8, arrow_frequency=6, stamina_depletion=6, size=1},
    {name='giant catfish', id=4469, stamina=33, arrow_duration=7, arrow_frequency=12, stamina_depletion=13, size=1, continent=5},
    {name='yayinbaligi', id=5463, stamina=33, arrow_duration=7, arrow_frequency=12, stamina_depletion=13, size=1, continent=2},
    {name='deademoiselle', id=5535, stamina=33, arrow_duration=6, arrow_frequency=11, stamina_depletion=15},
    {name='deademoiselle', id=5535, stamina=33, arrow_duration=6, arrow_frequency=11, stamina_depletion=15, count=2},
    {name='deademoiselle', id=5535, stamina=33, arrow_duration=6, arrow_frequency=11, stamina_depletion=15, count=3},
    {name='lungfish', id=4315, stamina=34, arrow_duration=6, arrow_frequency=9, stamina_depletion=16},
    {name='gigant octopus', id=5475, stamina=34, arrow_duration=4, arrow_frequency=11, stamina_depletion=18, size=1, legendary=1},
    {name='dark bass', id=4428, stamina=34, arrow_duration=9, arrow_frequency=9, stamina_depletion=23},
    {name='crystal bass', id=4528, stamina=35, arrow_duration=9, arrow_frequency=9, stamina_depletion=24},
    {name='ogre eel', id=4481, stamina=35, arrow_duration=15, arrow_frequency=12, stamina_depletion=29},
    {name='mussel', id=5949, stamina=36, arrow_duration=14, arrow_frequency=3, stamina_depletion=21},
    {name='shining trout', id=4354, stamina=36, arrow_duration=7, arrow_frequency=12, stamina_depletion=16, continent=5},
    {name='alabaligi', id=5461, stamina=36, arrow_duration=7, arrow_frequency=12, stamina_depletion=16, continent=2},
    {name='veydal wrasse', id=5141, stamina=36, arrow_duration=6, arrow_frequency=13, stamina_depletion=13, size=1},
    {name='blowfish', id=5812, stamina=37, arrow_duration=9, arrow_frequency=9, stamina_depletion=25},
    {name='nosteau herring', id=4482, stamina=37, arrow_duration=9, arrow_frequency=9, stamina_depletion=21},
    {name='coral butterfly', id=4580, stamina=38, arrow_duration=7, arrow_frequency=10, stamina_depletion=26},
    {name='gugru tuna', id=4480, stamina=38, arrow_duration=7, arrow_frequency=13, stamina_depletion=16, size=1, continent=5},
    {name='lakerda', id=5450, stamina=38, arrow_duration=7, arrow_frequency=13, stamina_depletion=16, size=1, continent=2},
    {name='brass loach', id=5469, stamina=39, arrow_duration=6, arrow_frequency=4, stamina_depletion=27},
    {name='zafmlug bass', id=4385, stamina=39, arrow_duration=8, arrow_frequency=8, stamina_depletion=27},
    {name='ruddy seema', id=5952, stamina=40, arrow_duration=6, arrow_frequency=7, stamina_depletion=22},
    {name='gold lobster', id=4383, stamina=41, arrow_duration=6, arrow_frequency=4, stamina_depletion=35, continent=5},
    {name='istakoz', id=5453, stamina=41, arrow_duration=6, arrow_frequency=4, stamina_depletion=35, continent=2},
    {name='black eel', id=4429, stamina=41, arrow_duration=7, arrow_frequency=9, stamina_depletion=24, continent=5},
    {name='yilanbaligi', id=5458, stamina=41, arrow_duration=7, arrow_frequency=9, stamina_depletion=24, continent=2},
    {name='cone calamary', id=5128, stamina=42, arrow_duration=12, arrow_frequency=6, stamina_depletion=40, continent=5},
    {name='cone calamary', id=5128, stamina=42, arrow_duration=12, arrow_frequency=6, stamina_depletion=40, count=2, continent=5},
    {name='cone calamary', id=5128, stamina=42, arrow_duration=12, arrow_frequency=6, stamina_depletion=40, count=3, continent=5},
    {name='kalamar', id=5448, stamina=42, arrow_duration=12, arrow_frequency=6, stamina_depletion=40, continent=2},
    {name='kalamar', id=5448, stamina=42, arrow_duration=12, arrow_frequency=6, stamina_depletion=40, count=2, continent=2},
    {name='kalamar', id=5448, stamina=42, arrow_duration=12, arrow_frequency=6, stamina_depletion=40, count=3, continent=2},
    {name='icefish', id=4470, stamina=42, arrow_duration=5, arrow_frequency=10, stamina_depletion=38, continent=3},
    {name='icefish', id=4470, stamina=42, arrow_duration=5, arrow_frequency=10, stamina_depletion=38, count=2, continent=3},
    {name='icefish', id=4470, stamina=42, arrow_duration=5, arrow_frequency=10, stamina_depletion=38, count=3, continent=3},
    {name='frigorifish', id=6144, stamina=42, arrow_duration=5, arrow_frequency=10, stamina_depletion=38, continent=4},
    {name='frigorifish', id=6144, stamina=42, arrow_duration=5, arrow_frequency=10, stamina_depletion=38, count=2, continent=4},
    {name='frigorifish', id=6144, stamina=42, arrow_duration=5, arrow_frequency=10, stamina_depletion=38, count=3, continent=4},
    {name='sandfish', id=4291, stamina=43, arrow_duration=5, arrow_frequency=11, stamina_depletion=36},
    {name='sandfish', id=4291, stamina=43, arrow_duration=5, arrow_frequency=11, stamina_depletion=36, count=2},
    {name='sandfish', id=4291, stamina=43, arrow_duration=5, arrow_frequency=11, stamina_depletion=36, count=3},
    {name='giant donko', id=4306, stamina=43, arrow_duration=15, arrow_frequency=8, stamina_depletion=17, size=1},
    {name='duskcrawler', id=9077, stamina=43, arrow_duration=9, arrow_frequency=9, stamina_depletion=9},
    {name='ashen crayfish', id=9146, stamina=43, arrow_duration=12, arrow_frequency=4, stamina_depletion=34},
    {name='monke-onke', id=4462, stamina=43, arrow_duration=12, arrow_frequency=9, stamina_depletion=17, size=1},
    {name='dragonfish', id=5959, stamina=44, arrow_duration=6, arrow_frequency=10, stamina_depletion=22},
    {name='red terrapin', id=4402, stamina=44, arrow_duration=10, arrow_frequency=6, stamina_depletion=28, continent=5},
    {name='shall shell', id=4484, stamina=44, arrow_duration=15, arrow_frequency=3, stamina_depletion=27, continent=5},
    {name='vongola clam', id=5131, stamina=44, arrow_duration=10, arrow_frequency=5, stamina_depletion=20},
    {name='istiridye', id=5456, stamina=44, arrow_duration=15, arrow_frequency=3, stamina_depletion=27, continent=2},
    {name='kaplumbaga', id=5464, stamina=44, arrow_duration=10, arrow_frequency=6, stamina_depletion=28, continent=2},
    {name='black prawn', id=5948, stamina=45, arrow_duration=8, arrow_frequency=6, stamina_depletion=29},
    {name='bluetail', id=4399, stamina=45, arrow_duration=6, arrow_frequency=13, stamina_depletion=24, continent=5},
    {name='uskumru', id=5452, stamina=45, arrow_duration=6, arrow_frequency=13, stamina_depletion=24, continent=2},
    {name='voidsnapper', id=9216, stamina=45, arrow_duration=3, arrow_frequency=15, stamina_depletion=18},
    {name='gold carp', id=4427, stamina=46, arrow_duration=12, arrow_frequency=15, stamina_depletion=18, continent=5},
    {name='sazanbaligi', id=5459, stamina=46, arrow_duration=12, arrow_frequency=15, stamina_depletion=18, continent=2},
    {name='dragonfly trout', id=5953, stamina=46, arrow_duration=3, arrow_frequency=8, stamina_depletion=21},
    {name='pelazoea', id=5815, stamina=47, arrow_duration=6, arrow_frequency=12, stamina_depletion=22, size=1},
    {name='trilobite', id=4317, stamina=47, arrow_duration=7, arrow_frequency=7, stamina_depletion=27, continent=3},
    {name='thysanopeltis', id=6337, stamina=47, arrow_duration=7, arrow_frequency=7, stamina_depletion=27, continent=4},
    {name='elshimo newt', id=4579, stamina=48, arrow_duration=7, arrow_frequency=10, stamina_depletion=26},
    {name='bhefhel marlin', id=4479, stamina=48, arrow_duration=7, arrow_frequency=15, stamina_depletion=20, size=1, continent=5},
    {name='kilicbaligi', id=5451, stamina=48, arrow_duration=7, arrow_frequency=15, stamina_depletion=18, size=1, continent=2},
    {name='trumpet shell', id=5466, stamina=49, arrow_duration=14, arrow_frequency=5, stamina_depletion=18},
    {name='yawning catfish', id=5955, stamina=50, arrow_duration=7, arrow_frequency=12, stamina_depletion=18, size=1},
    {name='king perch', id=5816, stamina=50, arrow_duration=10, arrow_frequency=8, stamina_depletion=19, size=1},
    {name='malicious perch', id=5995, stamina=50, arrow_duration=10, arrow_frequency=8, stamina_depletion=19, size=1, continent=4},
    {name='noble lady', id=4485, stamina=51, arrow_duration=9, arrow_frequency=11, stamina_depletion=30},
    {name='betta', id=5139, stamina=51, arrow_duration=5, arrow_frequency=13, stamina_depletion=16},
    {name='shockfish', id=5957, stamina=51, arrow_duration=6, arrow_frequency=11, stamina_depletion=27},
    {name='crescent fish', id=4473, stamina=52, arrow_duration=9, arrow_frequency=9, stamina_depletion=28},
    {name='zebra eel', id=4288, stamina=53, arrow_duration=12, arrow_frequency=11, stamina_depletion=32},
    {name='bladefish', id=4471, stamina=53, arrow_duration=7, arrow_frequency=12, stamina_depletion=21, size=1},
    {name='rhinochimera', id=5135, stamina=54, arrow_duration=7, arrow_frequency=15, stamina_depletion=17, size=1},
    {name='dwarf remora', id=6145, stamina=54, arrow_duration=7, arrow_frequency=7, stamina_depletion=25, legendary=1},
    {name='apkallufa', id=5534, stamina=55, arrow_duration=4, arrow_frequency=11, stamina_depletion=26, size=1},
    {name='tavnazian goby', id=5130, stamina=55, arrow_duration=9, arrow_frequency=9, stamina_depletion=30, continent=5},
    {name='kayabaligi', id=5460, stamina=55, arrow_duration=9, arrow_frequency=9, stamina_depletion=30, continent=2},
    {name='silver shark', id=4451, stamina=56, arrow_duration=5, arrow_frequency=10, stamina_depletion=35},
    {name='clotflagration', id=6001, stamina=56, arrow_duration=12, arrow_frequency=10, stamina_depletion=22},
    {name='ca cuong', id=5474, stamina=57, arrow_duration=10, arrow_frequency=8, stamina_depletion=17},
    {name='jungle catfish', id=4307, stamina=58, arrow_duration=7, arrow_frequency=12, stamina_depletion=26, size=1},
    {name='gavial fish', id=4477, stamina=58, arrow_duration=15, arrow_frequency=15, stamina_depletion=30, size=1},
    {name='three-eyed fish', id=4478, stamina=58, arrow_duration=11, arrow_frequency=9, stamina_depletion=22, size=1},
    {name='pirarucu', id=5470, stamina=58, arrow_duration=15, arrow_frequency=4, stamina_depletion=24, size=1, legendary=1},
    {name='bloodblotch', id=5951, stamina=59, arrow_duration=7, arrow_frequency=10, stamina_depletion=35, size=1},
    {name='garpike', id=5472, stamina=59, arrow_duration=5, arrow_frequency=11, stamina_depletion=24},
    {name='bastore bream', id=4461, stamina=61, arrow_duration=9, arrow_frequency=10, stamina_depletion=31, continent=5},
    {name='mercanbaligi', id=5454, stamina=61, arrow_duration=9, arrow_frequency=10, stamina_depletion=31, continent=2},
    {name='black ghost', id=5138, stamina=62, arrow_duration=9, arrow_frequency=9, stamina_depletion=36},
    {name='dorado gar', id=5813, stamina=62, arrow_duration=4, arrow_frequency=13, stamina_depletion=17, size=1},
    {name='grimmonite', id=4304, stamina=63, arrow_duration=9, arrow_frequency=7, stamina_depletion=31, size=1, continent=5},
    {name='ahtapot', id=5455, stamina=63, arrow_duration=9, arrow_frequency=7, stamina_depletion=31, size=1, continent=2},
    {name='emperor fish', id=4454, stamina=63, arrow_duration=5, arrow_frequency=13, stamina_depletion=36, size=1, continent=5},
    {name='gigant squid', id=4474, stamina=63, arrow_duration=7, arrow_frequency=15, stamina_depletion=43, size=1},
    {name='morinabaligi', id=5462, stamina=63, arrow_duration=5, arrow_frequency=13, stamina_depletion=36, size=1, continent=2},
    {name='megalodon', id=5467, stamina=64, arrow_duration=8, arrow_frequency=12, stamina_depletion=33, size=1, legendary=1},
    {name='black sole', id=4384, stamina=66, arrow_duration=7, arrow_frequency=12, stamina_depletion=33, continent=5},
    {name='dil', id=5457, stamina=66, arrow_duration=7, arrow_frequency=12, stamina_depletion=33, continent=2},
    {name='tiger shark', id=5817, stamina=67, arrow_duration=4, arrow_frequency=10, stamina_depletion=49, size=1},
    {name='pterygotus', id=5133, stamina=67, arrow_duration=9, arrow_frequency=7, stamina_depletion=28, size=1, legendary=1},
    {name='takitaro', id=4463, stamina=68, arrow_duration=4, arrow_frequency=14, stamina_depletion=18, size=1, legendary=1},
    {name='sea zombie', id=4475, stamina=68, arrow_duration=4, arrow_frequency=15, stamina_depletion=39, size=1, legendary=1},
    {name='titanictus', id=4476, stamina=68, arrow_duration=6, arrow_frequency=14, stamina_depletion=28, size=1, legendary=1},
    {name='kalkanbaligi', id=5140, stamina=70, arrow_duration=7, arrow_frequency=12, stamina_depletion=19, size=1, legendary=1},
    {name='turnabaligi', id=5137, stamina=70, arrow_duration=5, arrow_frequency=13, stamina_depletion=30, size=1, legendary=1},
    {name='armored pisces', id=4316, stamina=72, arrow_duration=10, arrow_frequency=12, stamina_depletion=22, size=1},--not legendary on horizon
    {name='giant chirai', id=4308, stamina=73, arrow_duration=5, arrow_frequency=15, stamina_depletion=25, size=1, legendary=1},
    {name='crocodilos', id=5814, stamina=74, arrow_duration=3, arrow_frequency=13, stamina_depletion=25, size=1},
    {name='red bubble-eye', id=5446, stamina=77, arrow_duration=4, arrow_frequency=15, stamina_depletion=24},
    {name='titanic sawfish', id=5120, stamina=80, arrow_duration=7, arrow_frequency=15, stamina_depletion=39, size=1, legendary=1},
    {name='tricorn', id=4319, stamina=82, arrow_duration=15, arrow_frequency=5, stamina_depletion=38, size=1, legendary=1},
    {name='cave cherax', id=4309, stamina=83, arrow_duration=8, arrow_frequency=4, stamina_depletion=36, size=1, legendary=1},
    {name='far east puffer', id=6489, stamina=83, arrow_duration=3, arrow_frequency=14, stamina_depletion=15, size=1, legendary=1},
    {name='mola mola', id=5134, stamina=85, arrow_duration=15, arrow_frequency=12, stamina_depletion=16, size=1, legendary=1},
    {name='gerrothorax', id=5471, stamina=85, arrow_duration=7, arrow_frequency=7, stamina_depletion=29, size=1, legendary=1},
    {name='gugrusaurus', id=5127, stamina=88, arrow_duration=7, arrow_frequency=5, stamina_depletion=39, size=1, legendary=1},
    {name='lik', id=5129, stamina=88, arrow_duration=3, arrow_frequency=14, stamina_depletion=48, size=1, legendary=1},
    {name='shen', id=5997, stamina=88, arrow_duration=15, arrow_frequency=2, stamina_depletion=74, size=1, legendary=1},
    {name='kokuryu', id=5540, stamina=89, arrow_duration=5, arrow_frequency=8, stamina_depletion=36, size=1, legendary=1},
    {name='soryu', id=5537, stamina=89, arrow_duration=13, arrow_frequency=3, stamina_depletion=33, size=1, legendary=1},
    {name='sekiryu', id=5538, stamina=90, arrow_duration=6, arrow_frequency=8, stamina_depletion=29, size=1, legendary=1},
    {name='cameroceras', id=6338, stamina=90, arrow_duration=7, arrow_frequency=15, stamina_depletion=26, size=1, legendary=1},
    {name='ancient carp', id=6373, stamina=90, arrow_duration=1, arrow_frequency=5, stamina_depletion=43, size=1, legendary=1},
    {name='hakuryu', id=5539, stamina=91, arrow_duration=4, arrow_frequency=13, stamina_depletion=25, size=1, legendary=1},
    {name='tusoteuthis longa', id=6376, stamina=92, arrow_duration=5, arrow_frequency=15, stamina_depletion=19, size=1, legendary=1},
    {name='phantom serpent', id=6375, stamina=92, arrow_duration=4, arrow_frequency=12, stamina_depletion=31, size=1, legendary=1},
    {name='ryugu titan', id=4305, stamina=93, arrow_duration=2, arrow_frequency=15, stamina_depletion=48, size=1, legendary=1},
    {name='abaia', id=5476, stamina=93, arrow_duration=6, arrow_frequency=15, stamina_depletion=37, size=1, legendary=1},
    {name='quicksilver blade', id=6371, stamina=93, arrow_duration=5, arrow_frequency=5, stamina_depletion=35, size=1, legendary=1},
    {name='matsya', id=5468, stamina=93, arrow_duration=7, arrow_frequency=15, stamina_depletion=31, size=1, legendary=1},
    {name='remora', id=6146, stamina=94, arrow_duration=2, arrow_frequency=14, stamina_depletion=39, size=1, legendary=1},
    {name="dragon's tabernacle", id=6374, stamina=95, arrow_duration=2, arrow_frequency=15, stamina_depletion=32, size=1, legendary=1},
    {name='lord of ulbuka', id=6372, stamina=96, arrow_duration=2, arrow_frequency=15, stamina_depletion=25, size=1, legendary=1},
    -- non-fish items
    {name='mithra snare', id=5330, stamina=18, arrow_duration=15, arrow_frequency=5, stamina_depletion=42},
    {name='rusty bucket', id=90, stamina=18, arrow_duration=15, arrow_frequency=3, stamina_depletion=19},
    {name='tarutaru snare', id=5329, stamina=18, arrow_duration=15, arrow_frequency=5, stamina_depletion=42},
    {name='contortacle', id=5962, stamina=19, arrow_duration=15, arrow_frequency=3, stamina_depletion=19},
    {name='pamtam kelp', id=624, stamina=19, arrow_duration=15, arrow_frequency=3, stamina_depletion=24},
    {name='arrowwood log', id=688, stamina=20, arrow_duration=15, arrow_frequency=3, stamina_depletion=18, size=1},
    {name='hard-boiled egg', id=4409, stamina=20, arrow_duration=15, arrow_frequency=3, stamina_depletion=18},
    {name='rusty subligar', id=14242, stamina=20, arrow_duration=15, arrow_frequency=3, stamina_depletion=22},
    {name='adoulinian kelp', id=3965, stamina=21, arrow_duration=15, arrow_frequency=3, stamina_depletion=18},
    {name='rusty leggings', id=14117, stamina=21, arrow_duration=15, arrow_frequency=3, stamina_depletion=26},
    {name='bone chip', id=880, stamina=23, arrow_duration=15, arrow_frequency=3, stamina_depletion=25},
    {name='rusty kunai', id=19283, stamina=23, arrow_duration=15, arrow_frequency=3, stamina_depletion=16},
    {name='norg shell', id=1135, stamina=25, arrow_duration=15, arrow_frequency=3, stamina_depletion=31},
    {name='rotten meat', id=16995, stamina=25, arrow_duration=15, arrow_frequency=3, stamina_depletion=17},
    {name='damp scroll', id=1210, stamina=28, arrow_duration=15, arrow_frequency=3, stamina_depletion=35, continent=1},
    {name='hydrogauge', id=2341, stamina=28, arrow_duration=15, arrow_frequency=3, stamina_depletion=35, continent=2},
    {name='ripped cap', id=591, stamina=28, arrow_duration=15, arrow_frequency=3, stamina_depletion=36},
    {name='rusty spear', id=19308, stamina=28, arrow_duration=15, arrow_frequency=3, stamina_depletion=17, size=1},
    {name='copper ring', id=13454, stamina=30, arrow_duration=15, arrow_frequency=3, stamina_depletion=40},
    {name='barnacle', id=5954, stamina=32, arrow_duration=15, arrow_frequency=3, stamina_depletion=20},
    {name='rusty cap', id=12522, stamina=33, arrow_duration=15, arrow_frequency=3, stamina_depletion=38},
    {name='rusty zaghnal', id=18962, stamina=33, arrow_duration=15, arrow_frequency=3, stamina_depletion=16, size=1},
    {name='persikos', id=4274, stamina=35, arrow_duration=15, arrow_frequency=3, stamina_depletion=19},
    {name='silver ring', id=13456, stamina=35, arrow_duration=15, arrow_frequency=3, stamina_depletion=40},
    {name='rusty pick', id=16655, stamina=38, arrow_duration=15, arrow_frequency=3, stamina_depletion=47},
    {name='fish scale shield', id=12316, stamina=40, arrow_duration=15, arrow_frequency=3, stamina_depletion=47, continent=1},
    {name='matamata shell', id=3934, stamina=43, arrow_duration=15, arrow_frequency=3, stamina_depletion=29, size=1},
    {name='mythril sword', id=16537, stamina=43, arrow_duration=15, arrow_frequency=3, stamina_depletion=53},
    {name='bugbear mask', id=1624, stamina=45, arrow_duration=15, arrow_frequency=3, stamina_depletion=42},
    {name='feyweald log', id=2761, stamina=45, arrow_duration=15, arrow_frequency=3, stamina_depletion=33, size=1},
    {name='moblin mask', id=1638, stamina=45, arrow_duration=15, arrow_frequency=3, stamina_depletion=44},
    {name='rusty greatsword', id=16606, stamina=48, arrow_duration=15, arrow_frequency=3, stamina_depletion=57},
    {name='igneous rock', id=1654, stamina=50, arrow_duration=15, arrow_frequency=3, stamina_depletion=27},
    {name='ruszor meat', id=5755, stamina=50, arrow_duration=15, arrow_frequency=3, stamina_depletion=21},
    {name='ulbuconut', id=5966, stamina=53, arrow_duration=15, arrow_frequency=3, stamina_depletion=29},
    {name='coral fragment', id=887, stamina=55, arrow_duration=15, arrow_frequency=3, stamina_depletion=47},
    {name='wasabi', id=9200, stamina=58, arrow_duration=15, arrow_frequency=3, stamina_depletion=28},
    {name='mythril dagger', id=16451, stamina=63, arrow_duration=15, arrow_frequency=3, stamina_depletion=78},
    {name='gold ring', id=13445, stamina=68, arrow_duration=15, arrow_frequency=3, stamina_depletion=80},
    -- gil
    {name='1 gil', id=70000, stamina=18, arrow_duration=15, arrow_frequency=3, stamina_depletion=22},
    {name='100 gil', id=70001, stamina=18, arrow_duration=15, arrow_frequency=3, stamina_depletion=22},
    -- key items
    --{name='lance fish', id=70002, stamina=22, arrow_duration=5, arrow_frequency=10, stamina_depletion=30},
    --{name='paladin lobster', id=70003, stamina=40, arrow_duration=10, arrow_frequency=7, stamina_depletion=30},
    --{name='scutum crab', id=70004, stamina=56/60, arrow_duration=15, arrow_frequency=15, stamina_depletion=25},
    -- entities
    {name='jade etui', id=70005, stamina=11, arrow_duration=11, arrow_frequency=15, stamina_depletion=16, size=1},
    {name='monster', id=80000, stamina=23, arrow_duration=13, arrow_frequency=15, stamina_depletion=13, size=1},
    {name='monster', id=80000, stamina=23, arrow_duration=15, arrow_frequency=15, stamina_depletion=16, size=1},
    {name='monster', id=80000, stamina=28, arrow_duration=12, arrow_frequency=15, stamina_depletion=15, size=1},
    {name='monster', id=80000, stamina=28, arrow_duration=15, arrow_frequency=15, stamina_depletion=19, size=1},
    {name='monster', id=80000, stamina=33, arrow_duration=11, arrow_frequency=15, stamina_depletion=16, size=1},
    {name='monster', id=80000, stamina=33, arrow_duration=15, arrow_frequency=15, stamina_depletion=22, size=1},
    {name='monster', id=80000, stamina=38, arrow_duration=10, arrow_frequency=15, stamina_depletion=17, size=1},
    {name='monster', id=80000, stamina=38, arrow_duration=15, arrow_frequency=15, stamina_depletion=26, size=1},
    {name='monster', id=80000, stamina=43, arrow_duration=9, arrow_frequency=15, stamina_depletion=19, size=1},
    {name='monster', id=80000, stamina=43, arrow_duration=15, arrow_frequency=15, stamina_depletion=29, size=1},
    {name='monster', id=80000, stamina=24, arrow_duration=15, arrow_frequency=12, stamina_depletion=22, size=1},
    {name='monster', id=80000, stamina=30, arrow_duration=12, arrow_frequency=15, stamina_depletion=16, size=1},
    {name='monster', id=80000, stamina=42, arrow_duration=9, arrow_frequency=15, stamina_depletion=18, size=1},
    {name='monster', id=80000, stamina=43, arrow_duration=15, arrow_frequency=12, stamina_depletion=38, size=1},
    {name='monster', id=80000, stamina=60, arrow_duration=9, arrow_frequency=15, stamina_depletion=27, size=1},
    {name='monster', id=80000, stamina=75, arrow_duration=8, arrow_frequency=15, stamina_depletion=26, size=1},
    {name='monster', id=80000, stamina=23, arrow_duration=11, arrow_frequency=15, stamina_depletion=15, size=1},
}

data.unknown_item = {name='unknown', id=80001}

--Bee: Of the rods that I've checked, Horizon seems to have subtracted 0.3 from these values. 
--I have noted the rods that I've confirmed fixed, and those that I speculate are fixed but have not confirmed.
data.rod_modifiers_by_id = {
    [17011]={70, 120}, --speculative fix
    [17014]={95, nil, 0}, --speculative fix
    [17015]={70, nil, 0}, --Halcyon Fishing Rod, fixed for horizon
    [17380]={100, nil, 1}, --speculative fix
    [17381]={70, nil, 1}, --Composite Fishing Rod, fixed for horizon
    [17382]={70, nil, 1}, --speculative fix
    [17383]={140, nil, 1}, --speculative fix
    [17384]={70}, --super speculative fix
    [17385]={70}, --super speculative fix
    [17386]={80, 100}, --Lu Shang's Fishing Rod, fixed for horizon
    [17387]={100}, --speculative fix
    [17388]={105}, --speculative fix
    [17389]={110}, --Bamboo Fishing Rod, fixed for horizon
    [17390]={115}, --speculative fix
    [17391]={120}, --speculative fix
    [19319]={70}, --super speculative fix
    [19320]={80, 100}, --speculative fix
    [19321]={70, 120}, --speculative fix
}

data.continent_by_zone = {
    [48]=2,
    [50]=2,
    [51]=2,
    [52]=2,
    [53]=2,
    [54]=2,
    [55]=2,
    [56]=2,
    [57]=2,
    [58]=2,
    [59]=2,
    [60]=2,
    [61]=2,
    [65]=2,
    [66]=2,
    [67]=2,
    [68]=2,
    [69]=2,
    [79]=2,
    [256]=4,
    [257]=4,
    [258]=4,
    [259]=4,
    [260]=4,
    [261]=4,
    [262]=4,
    [263]=4,
    [264]=4,
    [265]=4,
    [266]=4,
    [267]=4,
    [268]=4,
    [269]=4,
    [270]=4,
    [271]=4,
    [272]=4,
    [273]=4,
    [274]=4,
    [275]=4,
    [276]=4,
    [277]=4,
    [280]=4,
    [281]=4,
}

data.fish_by_name = {
    -- fish items
    ['abaia']=5476,
    ['ahtapot']=5455,
    ['alabaligi']=5461,
    ['ancient carp']=6373,
    ['apkallufa']=5534,
    ['armored pisces']=4316,
    ['ashen crayfish']=9146,
    ['bastore bream']=4461,
    ['bastore sardine']=4360,
    ['bastore sweeper']=5473,
    ['betta']=5139,
    ['bhefhel marlin']=4479,
    ['bibikibo']=4314,
    ['bibiki urchin']=4318,
    ['black eel']=4429,
    ['black ghost']=5138,
    ['black prawn']=5948,
    ['black sole']=4384,
    ['bladefish']=4471,
    ['blindfish']=4313,
    ['bloodblotch']=5951,
    ['blowfish']=5812,
    ['bluetail']=4399,
    ['bonefish']=6336,
    ['brass loach']=5469,
    ['ca cuong']=5474,
    ['caedarva frog']=5465,
    ['cameroceras']=6338,
    ['cave cherax']=4309,
    ['cheval salmon']=4379,
    ['clotflagration']=6001,
    ['cobalt jellyfish']=4443,
    ['cone calamary']=5128,
    ['contortopus']=5961,
    ['copper frog']=4515,
    ['coral butterfly']=4580,
    ['crayfish']=4472,
    ['crescent fish']=4473,
    ['crocodilos']=5814,
    ['crystal bass']=4528,
    ['dark bass']=4428,
    ['deademoiselle']=5535,
    ['denizanasi']=5447,
    ['dil']=5457,
    ['dorado gar']=5813,
    ['dragonfish']=5959,
    ['dragonfly trout']=5953,
    ['dra. tabernacle']=6374,
    ["dragon's tabernacle"]=6374,
    ['duskcrawler']=9077,
    ['dwarf remora']=6145,
    ['elshimo frog']=4290,
    ['elshimo newt']=4579,
    ['emperor fish']=4454,
    ['far east puffer']=6489,
    ['fat greedie']=4501,
    ['forest carp']=4289,
    ['frigorifish']=6144,
    ['garpike']=5472,
    ['gavial fish']=4477,
    ['gerrothorax']=5471,
    ['giant catfish']=4469,
    ['giant chirai']=4308,
    ['giant donko']=4306,
    ['gigant octopus']=5475,
    ['gigant squid']=4474,
    ['gold carp']=4427,
    ['gold lobster']=4383,
    ['greedie']=4500,
    ['grimmonite']=4304,
    ['gugrusaurus']=5127,
    ['gugru tuna']=4480,
    ['gurnard']=5132,
    ['hakuryu']=5539,
    ['hamsi']=5449,
    ['icefish']=4470,
    ['istakoz']=5453,
    ['istavrit']=5136,
    ['istiridye']=5456,
    ['jungle catfish']=4307,
    ['kalamar']=5448,
    ['kalkanbaligi']=5140,
    ['kaplumbaga']=5464,
    ['kayabaligi']=5460,
    ['kilicbaligi']=5451,
    ['king perch']=5816,
    ['kokuryu']=5540,
    ['lakerda']=5450,
    ['lamp marimo']=2216,
    ['lik']=5129,
    ['lord of ulbuka']=6372,
    ['lungfish']=4315,
    ['mackerel']=5950,
    ['malicious perch']=5995,
    ['matsya']=5468,
    ['megalodon']=5467,
    ['mercanbaligi']=5454,
    ['moat carp']=4401,
    ['mola mola']=5134,
    ['monke-onke']=4462,
    ['moorish idol']=5121,
    ['morinabaligi']=5462,
    ['muddy siredon']=5126,
    ['mussel']=5949,
    ['nebimonite']=4361,
    ['noble lady']=4485,
    ['nosteau herring']=4482,
    ['ogre eel']=4481,
    ['pelazoea']=5815,
    ['phanauet newt']=5125,
    ['phan. serpent']=6375,
    ['phantom serpent']=6375,
    ['pipira']=4464,
    ['pirarucu']=5470,
    ['pterygotus']=5133,
    ['quick. blade']=6371,
    ['quicksilver blade']=6371,
    ['quus']=4514,
    ['ra. shellfish']=6334,
    ["ra'kaznar shellfish"]=6334,
    ['red bubble-eye']=5446,
    ['red terrapin']=4402,
    ['remora']=6146,
    ['rhinochimera']=5135,
    ['ruddy seema']=5952,
    ['ryugu titan']=4305,
    ['sandfish']=4291,
    ['sazanbaligi']=5459,
    ['sea zombie']=4475,
    ['sekiryu']=5538,
    ['senroh frog']=5993,
    ['senroh sardine']=5963,
    ['shall shell']=4484,
    ['shen']=5997,
    ['shining trout']=4354,
    ['shockfish']=5957,
    ['silver shark']=4451,
    ['soryu']=5537,
    ['takitaro']=4463,
    ['tavnazian goby']=5130,
    ['three-eyed fish']=4478,
    ['thysanopeltis']=6337,
    ['tiger cod']=4483,
    ['tiger shark']=5817,
    ['tiny goldfish']=4310,
    ['titanic sawfish']=5120,
    ['titanictus']=4476,
    ['translucent salpa']=6333,
    ['tricolored carp']=4426,
    ['tricorn']=4319,
    ['trilobite']=4317,
    ['trumpet shell']=5466,
    ['turnabaligi']=5137,
    ['tusoteuthis longa']=6376,
    ['ulbukan lobster']=5960,
    ['uskumru']=5452,
    ['veydal wrasse']=5141,
    ['voidsnapper']=9216,
    ['vongola clam']=5131,
    ['white lobster']=6335,
    ['yawning catfish']=5955,
    ['yayinbaligi']=5463,
    ['yellow globe']=4403,
    ['yilanbaligi']=5458,
    ['yorchete']=5536,
    ['zafmlug bass']=4385,
    ['zebra eel']=4288,
}

data.item_by_name = {
    -- non-fish items
    ['adoulinian kelp']=3965,
    ['clump of adoulinian kelp']=3965,
    ['arrowwood log']=688,
    ['barnacle']=5954,
    ['bone chip']=880,
    ['bugbear mask']=1624,
    ['contortacle']=5962,
    ['copper ring']=13454,
    ['coral fragment']=887,
    ['damp scroll']=1210,
    ['feyweald log']=2761,
    ['fish scale shield']=12316,
    ['gold ring']=13445,
    ['hard-boiled egg']=4409,
    ['hydrogauge']=2341,
    ['igneous rock']=1654,
    ['matamata shell']=3934,
    ['mithra snare']=5330,
    ['moblin mask']=1638,
    ['mythril dagger']=16451,
    ['mythril sword']=16537,
    ['norg shell']=1135,
    ['pamtam kelp']=624,
    ['clump of pamtam kelp']=624,
    ['persikos']=4274,
    ['ripped cap']=591,
    ['rotten meat']=16995,
    ['piece of rotten meat']=16995,
    ['rusty bucket']=90,
    ['rusty cap']=12522,
    ['rusty greatsword']=16606,
    ['rusty kunai']=19283,
    ['rusty leggings']=14117,
    ['rusty pick']=16655,
    ['rusty spear']=19308,
    ['rusty subligar']=14242,
    ['rusty zaghnal']=18962,
    ['ruszor meat']=5755,
    ['slab of ruszor meat']=5755,
    ['silver ring']=13456,
    ['tarutaru snare']=5329,
    ['ulbuconut']=5966,
    ['wasabi']=9200,
    ['dollop of wasabi']=9200,
    -- gil
    ['1 gil']=70000,
    ['100 gil']=70001,
    -- key items
    ['lance fish']=70002,
    ['paladin lobster']=70003,
    ['scutum crab']=70004,
    -- entities
    ['jade etui']=70005,
    ['monster']=80000,
    -- unknown
    ['unknown']=80001,
}

data.bait_by_name = {
    -- baits
    ['ball of crayfish paste']=16997,
    ['crayfish ball']=16997,
    ['ball of insect paste']=16998,
    ['insect ball']=16998,
    ['ball of sardine paste']=16996,
    ['sardine ball']=16996,
    ['ball of trout paste']=16999,
    ['trout ball']=16999,
    ['dried squid']=19324,
    ['drill calamary']=17006,
    ['dwarf pugil']=17007,
    ['fly lure']=17405,
    ['frog lure']=17403,
    ['giant shell bug']=17001,
    ['goliath worm']=17010,
    ['large maze monger ball']=17009,
    ['large mmm ball']=17009,
    ['little worm']=17396,
    ['lizard lure']=17401,
    ['lufaise fly']=17005,
    ['lugworm']=17395,
    ['maze monger minnow']=19323,
    ['mmm minnow']=19323,
    ['meatball']=17000,
    ['minnow']=17407,
    ['peeled crayfish']=16993,
    ['peeled lobster']=17394,
    ['piece of rotten meat']=16995,
    ['rotten meat']=16995,
    ['regular maze monger ball']=17008,
    ['reg. mmm ball']=17008,
    ['robber rig']=17002,
    ['rogue rig']=17398,
    ['sabiki rig']=17399,
    ['sea dragon liver']=19326,
    ['shell bug']=17397,
    ['shrimp lure']=17402,
    ['sinking minnow']=17400,
    ['slice of bluetail']=16992,
    ['slice of cod']=17393,
    ['slice of moat carp']=16994,
    ['slice of carp']=16994,
    ['slice of sardine']=17392,
    ['worm lure']=17404,
}

return data
