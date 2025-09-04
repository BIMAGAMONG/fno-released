package;
class SongLangUtil{
    public static function trans(thing:String):String{ //THIS IS FOR SONGS AND DESCRIPTIONS
        switch(LangUtil.curLang){
            /*
            case 'template':
                switch(thing){
                    // STORY MODE
                    case 'RED-X': return '';
                    case 'OMNIPOTENT': return '';
                    case 'OV-DEZEPTION': return '';
                    case 'MAP-MAKER': return '';
                    case 'QUESTION': return '';
                    case 'CONTEST-OUTRAGE': return '';
                    case 'SPACE-TRAP': return '';
                    case 'REGENERATOR': return '';
                    case 'SWEARING': return '';
                    case 'GO-GO-DISCO': return '';
                    case 'SORCERY': return '';
                    case 'STARSHOT': return '';
                    // SHITPOST CATEGORY
                    case 'CYBERCHASE': return '';
                    case 'ESSAY': return '';
                    case 'EAR-KILLER': return '';
                    case 'EXE-TEST': return '';
                    case 'SAKUROVANIA': return '';
                    case 'SCRUNKLYWANKLYEXPLODISIGMABIDIDOTIOUS': return '';
                    case 'DYNAMIKE-SONG-MASTER': return '';
                    case 'Why she looks scary': return '';
                    case 'TWITTER AND OPINIONS CLASH AGAIN': return '';
                    case 'We are getting rid of sound waves with this one': return '';
                    case 'Just a burning memory...': return '';
                    case 'Woah': return '';
                    case 'Good luck saying the name of this song fluently.': return '';
                    case 'Get ready for bimas musical masterpiece....': return '';
                    // EXTRA CATEGORY
                    case "ARCADE-SLUDGEFEST": return "";
                    case "Immerse yourself in Starr Park's arcade classics...": return "";
                    case "ASTRAL-DESCENT": return "";
                    case "Eyes.kkx - An experiment gone horribly wrong.": return "";
                    case "FAR-FUTURE": return "";
                    case 'Catch a glimpse of the VERY near future....': return "";
                    case "ESCALATED": return "";
                    case "Insane and isolated in a emulated copy of SMW.": return "";
                    // BRAWL CATEGORY
                    case "SPACE-SYMPHONY": return "";
                    case 'The dark lord himself attacked, and you are here to stop him.': return "";
                    case 'STARRCADE': return "";
                    case 'The Tiger Pit Tournament - but you sing, instead of fighting.': return "";
                    case 'SHOWDOWN-OF-CHAOS': return "";
                    case "The screaming menace, wearing his iconic blue glasses.": return "";
                    case 'CORY-TIME': return "";
                    case 'A face off with a content creator, live on YouTube.': return "";
                    // REST OF FREEPLAY DESCRIPTIONS
                    case 'Unlock with Coins!\nCost: 200': return "";
                    case "Figure out the name of the song and search it, the answer is the channel name.": return "";
                    case "The creator of 'Firm Grip' map in Brawl Stars. The food is the clue.": return "";
                }*/
            case 'ptbr':
                switch(thing){
                    case 'CYBERCHASE': return 'CIBERNETICO';
                    case 'ESSAY': return 'ENSAIO';
                    case 'EAR-KILLER': return 'DESTRUIDOR DE ORELHAS';
                    case 'DYNAMIKE-SONG-MASTER': return 'DYNAMIKE CANÇÃO MESTRE';
                    case 'Why she looks scary': return 'por que ela parece assustadora';
                    case 'TWITTER AND OPINIONS CLASH AGAIN': return 'TWITTER E OPINIÕES SE CONFRONTAM NOVAMENTE';
                    case 'We are getting rid of sound waves with this one': return 'Estamos nos livrando das ondas sonoras com isso';
                    case 'Just a burning memory...': return 'Apenas uma lembrança ardente...';
                    case 'Woah': return 'o que';
                    case 'Good luck saying the name of this song fluently.': return 'Boa sorte tentando dizer o nome dessa música fluentemente.';
                    case 'Get ready for bimas musical masterpiece....': return 'Prepare-se para a obra-prima musical de bima...';
                    // STORY MODE
                    case 'OMNIPOTENT': return 'ONIPOTENTE';
                    case 'OV-DEZEPTION': return 'VÔO NOTURNO';
                    case 'QUESTION': return 'PERGUNTA';
                    case 'CONTEST-OUTRAGE': return 'PALCO ESCANDALOSO';
                    case 'SPACE-TRAP': return 'ATAQUE DUPLO';
                    case 'REGENERATOR': return 'REGENERADOR';
                    case 'SWEARING': return 'JURAR';
                    case 'GO-GO-DISCO': return 'VAI VAI DISCO';
                    case 'SORCERY': return 'ATAQUE DE SOMBRA';
                    case 'STARSHOT': return 'HORA ESTRELA';
                    // EXTRA CATEGORY
                    case "ARCADE-SLUDGEFEST": return "FESTA RETRÔ";
                    case "Immerse yourself in Starr Park's arcade classics...": return "Mergulhe nos clássicos dos fliperamas do Starr Park...";
                    case "ASTRAL-DESCENT": return "DESCIDA ASTRAL";
                    case "Eyes.kkx - An experiment gone horribly wrong.": return "Eyes.kkx - Um experimento que deu terrivelmente errado.";
                    case "FAR-FUTURE": return "NOVO FUTURO";
                    case 'Catch a glimpse of the VERY near future....': return "Dê uma olhada no futuro MUITO próximo...";
                    case "ESCALATED": return "ESCALADO";
                    case "Insane and isolated in a emulated copy of SMW.": return "Insano e isolado em uma cópia emulada do SMW.";
                    // BRAWL CATEGORY
                    case "SPACE-SYMPHONY": return "SINFONIA ESPACIAL";
                    case 'The dark lord himself attacked, and you are here to stop him.': return "O próprio Lorde das Trevas atacou, e você está aqui para detê-lo.";
                    case 'The Tiger Pit Tournament - but you sing, instead of fighting.': return "O Torneio Tiger Pit - mas você canta, em vez de lutar.";
                    case 'SHOWDOWN-OF-CHAOS': return "CONFRONTO CAÓTICO";
                    case "The screaming menace, wearing his iconic blue glasses.": return "A ameaça gritante, usando seus icônicos óculos azuis.";
                    case 'A face off with a content creator, live on YouTube.': return "Um confronto com um criador de conteúdo, ao vivo no YouTube.";
                    case 'Our hating protagonist meets a virus...': return "Nosso protagonista odioso encontra um vírus...";
                    // REST OF FREEPLAY DESCRIPTIONS
                    case 'Unlock with Coins!\nCost: 200': return "Desbloqueie com moedas!\nCusto: 200";
                    case 'Unlock with Gems!\nCost: 10': return "Desbloqueie com gemas!\nCusto: 10";
                    case "Figure out the name of the song and search it, the answer is the channel name.": return "Descubra o nome da música e pesquise, a resposta é o nome do canal.";
                    case "The creator of 'Firm Grip' map in Brawl Stars. The food is the clue.": return "O criador do mapa 'Firm Grip' em Brawl Stars. A comida é a pista.";
                }
            case 'ita':
                switch(thing){
                    case 'CYBERCHASE': return 'CORSA CIBERNETICA';
                    case 'ESSAY': return 'SAGGIO';
                    case 'EAR-KILLER': return 'TROPPO FORTE';
                    case 'DYNAMIKE-SONG-MASTER': return 'DYNAMIKE CANZONE MAESTRO';
                    case 'Why she looks scary': return 'Perché sembra spaventosa?';
                    case 'TWITTER AND OPINIONS CLASH AGAIN': return 'TWITTER E OPINIONI SI SCONTRANO DI NUOVO';
                    case 'We are getting rid of sound waves with this one': return 'Con questo eliminiamo le onde sonore';
                    case 'Just a burning memory...': return 'Solo un ricordo bruciante...';
                    case 'Woah': return 'Che cosa';
                    case 'Good luck saying the name of this song fluently.': return 'Buona fortuna nel pronunciare fluentemente il nome di questa canzone.';
                    case 'Get ready for bimas musical masterpiece....': return 'Preparatevi per il capolavoro musicale di bima...';
                    // STORY MODE
                    case 'OMNIPOTENT': return 'ONNIPOTENTE';
                    case 'QUESTION': return 'DOMANDA';
                    case 'CONTEST-OUTRAGE': return 'DUELLO SCANDALOSO';
                    case 'SPACE-TRAP': return 'TRAPP DALLO SPAZIO';
                    case 'REGENERATOR': return 'RIGENERATORE';
                    case 'SWEARING': return 'GIURANDO';
                    case 'GO-GO-DISCO': return 'FEBBRE DA DISCO';
                    case 'SORCERY': return 'STREGONERIA';
                    // EXTRA CATEGORY
                    case "Immerse yourself in Starr Park's arcade classics...": return "Immergiti nei classici arcade di Starr Park...";
                    case "ASTRAL-DESCENT": return "DISCESA ASTRALE";
                    case "Eyes.kkx - An experiment gone horribly wrong.": return "Eyes.kkx - Un esperimento andato terribilmente storto.";
                    case "FAR-FUTURE": return "FUTURO LONTANO";
                    case 'Catch a glimpse of the VERY near future....': return "Dai un’occhiata a un futuro MOLTO vicino....";
                    case "ESCALATED": return "ESCALATO";
                    case "Insane and isolated in a emulated copy of SMW.": return "Folle e isolato in una copia emulata di SMW.";
                    // BRAWL CATEGORY
                    case 'SPACE-SYMPHONY': return 'SPAZIO SINFONIA';
                    case 'The dark lord himself attacked, and you are here to stop him.': return "Il signore oscuro in persona ha attaccato, e tu sei qui per fermarlo.";
                    case 'The Tiger Pit Tournament - but you sing, instead of fighting.': return "Il Torneo della Fossa della Tigre – ma canti, invece di combattere.";
                    case 'SHOWDOWN-OF-CHAOS': return "OMBRE DEL CHAOS";
                    case "The screaming menace, wearing his iconic blue glasses.": return "La minaccia urlante, con i suoi iconici occhiali blu.";
                    case 'A face off with a content creator, live on YouTube.': return "Uno scontro con un content creator, in diretta su YouTube.";
                    case 'Our hating protagonist meets a virus...': return "Il nostro protagonista odiato incontra un virus...";
                    // REST OF FREEPLAY DESCRIPTIONS
                    case "Figure out the name of the song and search it, the answer is the channel name.": return "Scopri il nome della canzone e cercalo, la risposta e il nome del canale.";
                    case 'Unlock with Coins!\nCost: 200': return "Sblocca con Monete!\nCosto: 200";
                    case 'Unlock with Gems!\nCost: 10': return "Sblocca con le gemme!\nCosto: 10";
                    case "The creator of 'Firm Grip' map in Brawl Stars. The food is the clue.": return "Il creatore della mappa 'Firm Grip' in Brawl Stars. Il cibo e l'indizio.";
                }
            case 'esp':
                switch(thing){
                    case 'CYBERCHASE': return 'CIBERCARRERA';
                    case 'ESSAY': return 'ENSAYO';
                    case 'EAR-KILLER': return 'MUY RUIDOSO';
                    case 'DYNAMIKE-SONG-MASTER': return 'DINAMIKE CANCION MAESTRO';
                    case 'Why she looks scary': return '¿Por qué parece aterrador?';
                    case 'TWITTER AND OPINIONS CLASH AGAIN': return 'TWITTER Y LAS OPINIONES VUELVEN A CHOCAR';
                    case 'We are getting rid of sound waves with this one': return 'Con esto eliminamos las ondas sonoras.';
                    case 'Just a burning memory...': return 'Sólo un recuerdo ardiente';
                    case 'Woah': return 'q';
                    case 'Good luck saying the name of this song fluently.': return 'Buena suerte diciendo el nombre de esta canción con fluidez.';
                    case 'Get ready for bimas musical masterpiece....': return 'Prepárate para la obra maestra musical de Bima...';
                    // STORY MODE
                    case 'OMNIPOTENT': return 'OMNIPOTENTE';
                    case 'QUESTION': return 'PREGUNTA';
                    case 'CONTEST-OUTRAGE': return 'INDIGNACION';
                    case 'REGENERATOR': return 'REGENERADOR';
                    case 'SWEARING': return 'POLEMICA';
                    case 'GO-GO-DISCO': return 'HORA DE DISCO';
                    case 'SORCERY': return 'LUCHA OSCURA';
                    case 'STARSHOT': return 'JUGADOR ESTRELLA';
                    // EXTRA CATEGORY
                    case "Immerse yourself in Starr Park's arcade classics...": return "Sumergete en los clasicos arcade de Starr Park...";
                    case "ASTRAL-DESCENT": return "DESCENSO ASTRAL";
                    case "Eyes.kkx - An experiment gone horribly wrong.": return "Eyes.kkx – Un experimento que salio terriblemente mal.";
                    case "FAR-FUTURE": return "FUTURO LEJANO";
                    case 'Catch a glimpse of the VERY near future....': return 'Eche un vistazo al futuro MUY cercano...';
                    case "ESCALATED": return "ESCALADO";
                    case "Insane and isolated in a emulated copy of SMW.": return "Loco y aislado en una copia de SMW";
                    // BRAWL CATEGORY
                    case "SPACE-SYMPHONY": return "SINFONIA ESPACIAL";
                    case 'The dark lord himself attacked, and you are here to stop him.': return 'El señor oscuro ataco, y tu estas aqui para detenerlo.';
                    case 'The Tiger Pit Tournament - but you sing, instead of fighting.': return 'El torneo "Tiger Pit", pero cantas en lugar de luchar.';
                    case "SHOWDOWN-OF-CHAOS": return "SUPERVIVENCIA CAOTICA";
                    case "The screaming menace, wearing his iconic blue glasses.": return "La amenaza griton, luciendo sus iconicas gafas azules.";
                    case 'A face off with a content creator, live on YouTube.': return 'Un enfrentamiento con un creador de contenidos, en directo en YouTube.';
                    case 'Our hating protagonist meets a virus...': return 'Nuestro protagonista odioso se encuentra con un virus...';
                    // REST OF FREEPLAY DESCRIPTIONS
                    case "Figure out the name of the song and search it, the answer is the channel name.": return "Averigua el nombre en ingles de la cancion y buscalo, la respuesta es el nombre del canal.";
                    case 'Unlock with Coins!\nCost: 200': return "¡Desbloquea con monedas!\nPrecio: 200";
                    case 'Unlock with Gems!\nCost: 10': return "¡Desbloquea con gemas!\nCosto: 10";
                    case "The creator of 'Firm Grip' map in Brawl Stars. The food is the clue.": return "La creadora del mapa 'Firm Grip' en Brawl Stars. La comida es la clave.";
                }
            case 'rus':
                switch(thing){
                    // SHITPOST CATEGORY
                    case 'CYBERCHASE': return 'КИБЕРПОГОНЯ';
                    case 'ESSAY': return 'ЭССЕ';
                    case 'EAR-KILLER': return 'УБИВАТЕЛЬ УШ';
                    case 'EXE-TEST': return 'ЕКЗЕ ТЭСТ';
                    case 'SAKUROVANIA': return 'САКУРОВАНИЯ';
                    case 'SCRUNKLYWANKLYEXPLODISIGMABIDIDOTIOUS': return 'СКРУНКЛИВАНКЛИВЗРЫВСИГМАБИДИДОШУС';
                    case 'DYNAMIKE-SONG-MASTER': return 'ДИНАМАЙК СОНГ МАСТЕР';
                    case 'Why she looks scary': return 'Почему мне сейчас страшна';
                    case 'TWITTER AND OPINIONS CLASH AGAIN': return 'ТВИТТЕР И МНЕНИЯ СТАЛКИВАЮТСЯ СНОВА';
                    case 'We are getting rid of sound waves with this one': return 'Мы с этой песней избавляемся от звуковых волн';
                    case 'Just a burning memory...': return 'Старые плохие времена...';
                    case 'Woah': return 'шо';
                    case 'Good luck saying the name of this song fluently.': return 'Удачи произносить имя этой песни.';
                    case 'Get ready for bimas musical masterpiece....': return 'Приготовтесь к самой лучшей музыки от бимы...';
                    // STORY MODE
                    case 'RED-X': return 'КРАСНЫЙ X';
                    case 'OMNIPOTENT': return 'ВСЕМОГУЩИЙ';
                    case 'OV-DEZEPTION': return 'НОЧНОЙ ПОЛЁТ';
                    case 'MAP-MAKER': return 'ДЕБЮТ';
                    case 'QUESTION': return 'ВСЁ ИЛИ НИЧЕГО';
                    case 'CONTEST-OUTRAGE': return 'КОНКУРСНОЕ ВОЗМУЩЕНИЕ';
                    case 'SPACE-TRAP': return 'ДВОЙНОЙ УДАР';
                    case 'REGENERATOR': return 'РЕГЕНЕРАТОР';
                    case 'SWEARING': return 'РУГАНЬ';
                    case 'GO-GO-DISCO': return 'ДИСКОТЕКА';
                    case 'SORCERY': return 'ПЕРЕХВАТ';
                    case 'STARSHOT': return 'ЗВЁЗДНЫЙ ЧАС';
                    // EXTRA CATEGORY
                    case "ARCADE-SLUDGEFEST": return "АРКАДНАЯ ВЕЧЕРИНКА";
                    case "Immerse yourself in Starr Park's arcade classics...": return "Погрузитесь в классические игры от Starr Park...";
                    case "ASTRAL-DESCENT": return "АСТРАЛЬНЫЙ СПУСК";
                    case "Eyes.kkx - An experiment gone horribly wrong.": return "Eyes.kkx - Неудачный эксперимент.";
                    case "FAR-FUTURE": return "ДАЛЁКОЕ БУДУЩЕЕ";
                    case 'Catch a glimpse of the VERY near future....': return "Загляните в ОЧЕНЬ близкое будущее...";
                    case "ESCALATED": return "ЭСКАЛАЦИЯ";
                    case "Insane and isolated in a emulated copy of SMW.": return "Безумный и изолированный в эмулированной копии SMW.";
                    // BRAWL CATEGORY
                    case "SPACE-SYMPHONY": return "ЗВЕЗДНАЯ СИМФОНИЯ";
                    case 'The dark lord himself attacked, and you are here to stop him.': return "Сам Темный Лорд напал, и вы здесь, чтобы остановить его.";
                    case 'STARRCADE': return "СТАРРКАДА";
                    case 'The Tiger Pit Tournament - but you sing, instead of fighting.': return "Турнир 'Тигровая яма' — но вы поете, вместо того чтобы сражаться.";
                    case 'SHOWDOWN-OF-CHAOS': return "СТОЛКНОВЕНИЕ";
                    case "The screaming menace, wearing his iconic blue glasses.": return "Кричащий в своих знаменитых синих очках.";
                    case 'CORY-TIME': return "ВЫЗОВ КОРИ";
                    case 'A face off with a content creator, live on YouTube.': return "Встреча с создателем контента в прямом эфире.";
                    case 'Our hating protagonist meets a virus...': return "Наш ненавидящий герой встречает вирус...";
                    // REST OF FREEPLAY DESCRIPTIONS
                    case "Figure out the name of the song and search it, the answer is the channel name.": return "Узнайте название песни и выполните поиск по ней, ответом будет название канала.";
                    case 'Unlock with Coins!\nCost: 200': return "Разблокируете за монеты!\nСтоимость: 200";
                    case 'Unlock with Gems!\nCost: 10': return "Разблокируете за гемы!\nСтоимость: 10";
                    case "The creator of 'Firm Grip' map in Brawl Stars. The food is the clue.": return "Создатель карты 'Firm Grip' в Brawl Stars. Еда — вот ключ.";
                }
        }
        return thing;
    }
}