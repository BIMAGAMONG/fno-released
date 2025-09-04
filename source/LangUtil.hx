package;
using StringTools;
class LangUtil{
    // NOTE TO SELF: TRANSLATE SHIT IN CLEARSAVEDATA AND OUTDATEDSUBSTATE
    public static var curLang:String = '';
    static var funFactQuotes:Map<String, Array<String>> = [//8 QUOTES PER EACH QUOTE CATEGORY
        'eng' => [
            "Guess what engine and version this mod uses.", "Coach Cory, the man himself, has voiced his chromatic in Cory Time.",
            "Originally FnO would be an average 'VS Someone' mod with two routes to two different endings.", "Not all fun facts are fun.",
            "The character Sakura comes from Friday Night Funkin' Fanon Wiki.", "You're not allowed to draw NSFW of any OCs in this mod, unless if their respective creator says otherwise.",
            "Any OC in this mod is a different version of it made specifically for this mod, they aren't digital representations of actual people.", "Puppet Mario and Eyes.kkx originate from bimagamongMOP's analog horror."
        ],'esp' => [
            "Este mod solia ser sobre un servidor de Discord, sin embargo evoluciono hasta convertirse en lo que es ahora.", "VectorFlame y NikRetaNCAM son los compositores mas antiguos que permanecen en el equipo.",
            "Lowme tiene un arma, pero no sabe usarla. Asi que la usa por estilo.", "El eslogan original del mod solia ser 'No puedes descargarnos'.",
            "Es posible que bimagamongMOP haya gastado demasiado en solo una mod...", "Friday Night Outrage es el mod principal de la serie de 'Outrage'.",
            "Diferentes idiomas, diferentes textos....", "La pizza favorita de Bima es la de pepperoni."
        ],'ita' => [
            '"Outrageous Hijinks" e stato creato durante la mod jam di Gamebanana.', 'Questa mod aveva una galleria, ma e stata rimossa.',
            'La decisione di tradurre la mod in diverse lingue e stata presa per divertimento.', 'Una volta e stato sviluppato un brano di 25 minuti per questa mod...',
            "La difficolta 'Scandaloso' aggiunge solo note a quelle gia esistenti, non cambia o modifica nient'altro.", "Sì, le scene d'intermezzo sono ispirate ai giochi Atari, FAITH e FNAF.",
            'La settimana "IL MINORE TRAVESTITO" e stata la prima mai realizzata, non "NUOVI INIZI"', 'Dovresti semplicemente premere 1 in qualsiasi momento.'
        ],'rus' => [
            'Все шрифты, которые вы видите в этом моде, доступны для загрузки. :)', 'В "Mods News Funkin" будут публиковаться эксклюзивные тизеры, присоединяйтесь к серверу через "Ссылки" в главном меню.',
            'Бима — бима.', 'Первоначально русский перевод этой игры был отменен, но теперь это не так.', 'Был ремикс "Personel" из "VS Sonic.exe", который был отменен, оставив шуточную версию в теперь удаленной категории "Shitpost".',
            'Любой мод может быть каноном в сюжете, однако это ни на что не повлияет', 'Если он захочет, Лоуми может стать восклицательным знаком.', 'Сакура — владелица своего бизнеса и франчайзер.'
        ],'ptbr' => [
            'Mars não pode ser fisicamente quebrado.', "'CONFRONTO CAÓTICO' foi criado em colaboração com um mod chamado 'Escape From Starr Park'",
            'O menu "Links" tem mais jogos relacionados a isso, experimente-os!', 'A tradução para o português foi feita inteiramente por uma pessoa e bimagamongMOP pelo uso de um tradutor.',
            'Hoshizora tem algum tipo de lado maligno, assim como Sakura.', 'Idiomas diferentes apresentam fatos diferentes sobre os personagens e o jogo. Divirta-se traduzindo!',
            'Este jogo pode ser jogado no seu celular!', "'ESCALADO' tem o maior número de versões da música já feitas."
        ]
    ];
    static var somethingQuotes:Map<String, Array<String>> = [
        'eng' => [
            "Just a thank you for everyone reading everything!", "There may or may not be a chance that you have been DMd by bimagamongMOP a long time ago, check your DMs!",
            "getting freaky on a friday night yeah.", "sticky", "V1 and V2 of this mod released back in the old days of FNF modding, it was shit but no one saw it.", "Wanna work on Friday Night Outrage?",
            "Nothing. This is a waste of time, stop reading this.", "illegal activity: my balls itch"
        ],'esp' => [
            "actividades ilegales: mis bolas pican", "quiero decir hola a mis amigos plantagamer09, ney, gamerpablito, prixolotl, leoeskisde, toonishtragedy, visqueux",
            "no se permite el uso de telefono movil en clase", "¿a alguien le gusta el solomillo?", "llama llama en llamas a llama en llamas", "hola batmancarpero", "HOLA, SOY PICO, Y ESTO ES JACKASS", "calla te pen de jo (los que saben)"
        ],'ita' => [
            'attivita illegali: mi prudono le palle', 'O partigiano, portami via\nO bella ciao, bella ciao, bella ciao, ciao, ciao\nO partigiano, portami via\nChe mi sento di morir',
            'bombardiro crocodilo', '104000 da aprire insieme a voi, 3 nuove leggendarie, 3 nuove carte per un totale di 6 nuove carte da trovare assolutamente signori',
            'Ma io che cazzo ne so scusa?', 'Ciao pubblico italiano, buona giornata!', 'Mandami un messaggio con scritto "bima, outrage, italy", giusto per divertimento... per favore...', 'niente'
        ],'rus' => [
            "Некоторые разрабы мода русскоязычные :)", "Повар спрашивает повара...", "незаконная деятельность: мои яйца чешутся", "Мой одноклассник ебашит школьный интернет без остановки.",
            "Как тебя зовут?\n'Нет, я не буду' сказал Нет, я не буду.", "ВАНЕЧКИН, ДУ Ю СПИК ИНГЛИШ?!", "Шампунь Жумайсынба, ахуенный шампунь!", "великорусский обстрел спермой\nславянский зажим яйцами"
        ],'ptbr' => [
            'atividade ilegal: minhas bolas coçam', 'Algumas pessoas dizem que este jogo parece o Codename Engine, mas não tenho ideia de como ou por quê.',
            'lol', 'lol',
            'lol', 'lol',
            'lol', 'lol'
        ]
    ];
    static var proTipQuotes:Map<String, Array<String>> = [
        'eng' => [
            "Some of the songs require a code, read their description and find out the code.", "Log into Gamejolt if you want your achievements to be saved.",
            "Some songs may require coins to be unlocked, but for some, you need to hunt for them....", "You can navigate almost all menus with just your mouse, read the controls in some of the menus.",
            "Make sure to take breaks after playing!", "This mod has story and lore, figure it out via the cutscenes and some secrets!",
            "Like the mod's gamebanana page!", "You should join the community server..."
        ],'esp' => [
            "Algunas de las canciones requieren un codigo, lee su descripcion y descubre el codigo.", "Inicia sesion en Gamejolt si quieres guardar tus logros.",
            "Algunas canciones pueden requerir monedas para desbloquearlas, pero para otras tendras que buscarlas...", "Puedes navegar por casi todos los menus solo con el raton, lee los controles en algunos de los menus.",
            "¡Asegurate de tomar descansos despues de jugar!", "Este mod tiene una historia, ¡descubrela a traves de las escenas y algunos secretos!",
            "¡Dale un Like a la pagina gamebanana del mod!", "Deberias unirte al servidor de la comunidad..."
        ],'ita' => [
            "Alcune canzoni richiedono un codice: leggi la descrizione e scoprilo.", "Accedi a Gamejolt se vuoi che i tuoi risultati vengano salvati.",
            "Alcune canzoni potrebbero richiedere delle monete per essere sbloccate, ma per altre, bisogna cercarle...", "E possibile navigare in quasi tutti i menu semplicemente con il mouse e leggere i comandi in alcuni menu.",
            "Assicuratevi di fare delle pause dopo aver giocato!", "Questa mod ha una storia, scoprila attraverso le scene tagliate e alcuni segreti!",
            "Metti mi piace alla pagina gamebanana del moderatore!", "Dovresti unirti al server della comunita..."
        ],'rus' => [
            "Некоторые песни требуют код, прочитайте их описание и узнайте код...", "Войдите в Gamejolt, если хотите сохранить свои достижения",
            "Для разблокировки некоторых песен могут потребоваться монеты, но для некоторых вам нужно будет их найти...", "Вы можете перемещаться почти по всем меню с помощью мыши, прочитайте инструкции в некоторых меню",
            "Обязательно делайте перерывы после игры!", "У этого мода есть сюжет, разберитесь в них с помощью кат-сцен и некоторых секретов!",
            "Поставьте лайк на странице мода!", "Вам стоит присоединиться к серверу сообщества..."
        ],'ptbr' => [
            'Algumas músicas exigem um código. Leia a descrição e descubra o código.', 'Entre no Gamejolt se quiser que suas conquistas sejam salvas.',
            'Algumas músicas podem exigir moedas para serem desbloqueadas, mas para outras, você precisa caçá-las...', 'Você pode navegar em quase todos os menus apenas com o mouse e ler os controles em alguns dos menus.',
            'Não se esqueça de fazer pausas depois de jogar!', 'Este modo tem uma história, descubra-a através das cenas e alguns segredos!',
            "Curta a página do mod gamebanana!", "Você deve ingressar no servidor da comunidade..."
        ]
    ];
    public static function getFunFact():Array<String> return funFactQuotes.get(curLang);
    public static function getSomething():Array<String> return somethingQuotes.get(curLang);
    public static function getProTip():Array<String> return proTipQuotes.get(curLang);
    public static function getRat(i:Int):String return ratingPref.get(curLang)[i];
    static var ratingPref:Map<String, Array<String>> = [
        // sick, good, bad, shit - im doing this since some languages have the same translations so i don't need to save a copy of the same image
        'eng' => ["eng", "eng", "eng", "eng"],
        'esp' => ["esp", "esp", "eng", "esp"],
        'ita' => ["ita", "esp", "ita", "ita"],
        'rus' => ['rus', 'rus', 'rus', 'rus'],
        'ptbr' => ['ptbr', 'esp', 'eng', 'eng']
    ];
    static var keybindNames:Map<String, Array<String>> = [
        'eng' => ["LEFT", "DOWN", "UP", "RIGHT"],
        'esp' => ["IZQUIERDA", "ABAJO", "ARRIBA", "DERECHA"],
        'ita' => ["SINISTRA", "SU", "GIU", "DESTRA"],
        'rus' => ['ВЛЕВО', 'ВНИЗ', 'ВВЕРХ', 'ВПРАВО'],
        'ptbr' => ["ESQUERDO", "BAIXO", "ACIMA", "CERTO"]
    ];
    static var gameOverQuotes:Map<String, Array<String>> = [//8 Quotes
        'eng' => ['laughing my ass off', 'dum ass', 'u suck lil bro', 't-bone steak', 'sigma ballsack', 'outrageous moment', 'wanna work on outrage?', 'im abouta bust'],
        'esp' => ['estoy riendo mucho', 'estupido', 'pibe, deja de jugar fnf mods.', 'adios amigos', 'los porno!!!! lands', 'el pibe mario', '¿quiere trabajar en outrage?', 'fue mi pene'],
        'ita' => ['Non sono pigro. Sono in modalita risparmio energetico.', 'Non ho fallito. Ho solo trovato 10.000 modi che non funzionano.', 'meglio mai che tardi-', 'non conta questa!', 'la mia tastiera si e scollegata giuro', 'tu bari!', 'sto esplodendo', 'Bombardiere di coccodrillo'],
        'rus' => ['ебать лошара', 'сказал же, не рыпаться!', 'ало фнф, да да песни!', 'У вас нашлись семечки', 'Ракосель представляет...', 'огузок', 'ой мама пришла', 'возмутительный момент'],
        'ptbr' => ['lunadotjson termine sua tarefa', 'ronaldo vs messi', 'psych engine 2', 'como como - como como como', 'eu acabei de morrer', 'você só vive uma vez', 'esse jogo é um lixo', 'você quer trabalhar em outrage?']
    ];
    static var weekNames:Map<String, Array<String>> = [
        'eng' => ["MINOR IN DISGUISE", "QUESTIONABLE INSANITY", "SPACED OUT", "BARISTA'S CHALLENGE"],
        'esp' => ["MENOR DISFRAZADO", "LOCURA CUESTIONABLE", "ESPACIADO", "DESAFIO DEL BARISTA"],
        'ita' => ["IL MINORE TRAVESTITO", "FOLLIA DISCUTIBILE", "RAP SPAZIALE", "SFIDA DEL BARISTA"],
        'rus' => ['ПОД ПРИКРЫТИЕМ', 'СОМНИТЕЛЬНОЕ БЕЗУМИЕ', 'КОСМИЧЕСКИЙ РЭП', 'ВЫЗОВ БАРИСТЫ'],
        'ptbr' => ['MENOR EM DISFARÇE', 'INSANIDADE QUESTIONÁVEL', 'ESPAÇADO', 'DESAFIO DO BARISTA']
    ];
    static var splashText:Map<String, Array<String>> = [//6 Texts
        'eng' => ["very freaky mod", "ITS THE OUTRAGE", "hello darknebolian", "shoutout to\nfunkin crew", "move dat mouse", "ligma balls"],
        'esp' => ["hola cover ruisna", "mueve el puntero\ndel raton", "choque mate", "la casa de papel", "que vive el porno", "bienvenido a\npendejotopia"],
        'ita' => ["borbo", "super mario bros", "Ragazzi, prendetelo", "Veni, vidi, cantare", "ciao", "italia"],
        'rus' => ["не рыпаемся", "чиназес", "двигай мышку", "ох зря я\nтуда полез", "привет\nкуплинов", "блять"],
        'ptbr' => ['mova o mouse', 'estou em\nsuas paredes', 'olá shadowmario', 'portugal', 'brasil', 'batata?']
    ];
    public static function getKeybindNames():Array<String> return keybindNames.get(curLang);
    public static function getGameOverQuote():String return gameOverQuotes.get(curLang)[FlxG.random.int(0, gameOverQuotes.get(curLang).length - 1)];
    public static function getWeekNames():Array<String> return weekNames.get(curLang);
    public static function getSplashText():Array<String> return splashText.get(curLang);
    public static function translate(string:String):String{
        switch(curLang){
            /*
            case 'template';
                switch(string){
                    case "FUN FACT": return "";
                    case "PRO TIP": return "";
                    case "SOMETHING": return "";
                    case 'LEFT': return '';
                    case 'RIGHT': return '';
                    case 'UP': return '';
                    case 'DOWN': return '';
                    case 'NORMAL': return '';
                    case 'OUTRAGEOUS': return '';
                    case 'Category (UP/DOWN)': return '';
                    case 'No Link Available': return '';
                    case "Press 'ENTER' to support": return "";
                    case 'CODERS': return '';
                    case 'VISUALS': return '';
                    case 'CHARACTERS': return '';
                    case 'VOICE ACTORS': return '';
                    case 'AUDIO': return '';
                    case 'CHARTERS': return '';
                    case 'REDEEM': return '';
                    // MAIN MENU
                    case 'STORY MODE': return '';
                    case 'FREEPLAY': return '';
                    case 'CREDITS': return '';
                    case 'GAMEJOLT': return '';
                    case 'LINKS': return '';
                    case 'new song unlocked': return '';
                    case 'achievement unlocked': return '';
                    case "Song can be found in 'Extra' category of Freeplay.": return "";
                    case "Song can be found in 'Brawl' category of Freeplay.": return "";
                    case "Total Notes Pressed:": return "";
                    case "Total Misses:": return "";
                    case 'OVERDONE >:(': return '';
                    case 'Your credit card was Fanum Taxed successfully.': return '';
                    // GAMEJOLT
                    case "No Game Data Available!": return "";
                    case "ERROR, Something went wrong...": return "";
                    case "Username:": return "";
                    case "Game Token:": return "";
                    case 'Log In': return '';
                    case 'Log Out': return '';
                    case 'Trophies': return '';
                    case "You're about to log out of": return "";
                    case 'your GameJolt session here.\n': return '';
                    case 'Your personal information (username and game token)': return '';
                    case 'will be removed from this game.\n': return '';
                    case 'Are you sure you want to log out?': return '';
                    case '[Press P to Confirm]': return '';
                    case '[Press BACKSPACE to Cancel]': return '';
                    // MINIGAMES + TITLE SCREEN STUFF
                    case 'GO TO SLEEP LITTLE ONE.': return "";
                    case "THIS WILL BE OVER SOON.": return "";
                    // PAUSE MENU STUFF
                    case 'NONE': return '';
                    case 'resume': return '';
                    case 'options' | 'OPTIONS': return '';
                    case 'quit': return '';
                    case 'Background': return '';
                    case 'Characters': return '';
                    case 'Song': return '';
                    case "Sprites": return "";
                    case "Chart": return "";
                    case "Chromatics": return "";
                    // ACTUAL OPTIONS + DESCRIPTIONS
                    case 'Downscroll': return '';
                    case 'Anti-Aliasing': return '';
                    case 'Shaders': return '';
                    case 'Simple': return '';
                    case 'Milisecond Based': return '';
                    case 'Flashing Lights': return '';
                    case "Also affects other things that flash.": return ""; 
                    case "Miss Sounds": return "";
                    case "Play sound effects when missing notes.": return "";
                    case "Skip Cutscenes & Dialogue": return "";
                    case "Menu Instructions": return "";
                    case "Menus display instructions on how to use them (this menu is not affected by this).": return "";
                    case 'Lane Underlay Opacity': return '';
                    case "Change opacity of the background under the notes.": return "";
                    case 'Colorblind Filter': return '';
                    case 'DEUTERANOPIA': return '';
                    case 'PROTANOPIA': return '';
                    case 'TRITANOPIA': return '';
                    case "Instakill Key": return "";
                    case "Pressing 'R' with this enabled will result in an instant game over.": return "";
                    case "View Combo and Rating": return '';
                    case "View the ratings (Eg. Outrage!) and combo numbers when hitting notes.": return "";
                    case "Botplay": return "";
                    case "The game plays for you, no strings attached.": return "";
                    case "Notes will come from above, your strums will be at the bottom of the screen.": return "";
                    case "If turned on, graphics are smoother, otherwise, they lose their smoothness but improves performance.": return "";
                    case "Accuracy Calculation": return "";
                    case "Shaking": return "";
                    case "Hide HUD": return "";
                    case "Hides stats and song time and name during gameplay.": return "";
                    case "HUD Opacity": return '';
                    case "Sets transparency for all gameplay HUD elements. Lane underlay IS NOT AFFECTED by this.": return "";
                    case "Framerate": return '';
                    case "Set the framerate the game runs on.": return "";
                    case "Auto Pause": return "";
                    case "If this is enabled, the game will pause when not focused on.": return "";
                    case "FPS Counter": return '';
                    case "Appears on the top left corner of the screen.": return "";
                    case "Rainbow FPS Counter": return "";
                    case "Photosensitive Warning!": return "";
                    case "Instakill on Miss": return "";
                    case "Green Screen Mode": return "";
                    case "When enabled, the gameplay would be just a green screen with the HUD.": return "";
                    case "Extra Scroll Speed": return "";
                    case "The number gets added onto the scroll speed for all songs.": return "";
                    case "Note Offset": return "";
                    case "Determines how late a note spawns, useful for dealing with audio lag from wireless earphones. Also hold CTRL to scroll faster.": return "";
                    // CONTROLS & OPTION CATEGORIES MENU + SUBSTATES
                    case 'Self-explanatory.': return '';
                    case 'Controls': return '';
                    case 'General & Accessibility': return '';
                    case 'Display': return '';
                    case 'Gameplay': return '';
                    case 'Misc': return '';
                    case 'MISC': return '';
                    case 'Language': return '';
                    case 'Clear Save Data': return '';
                    case 'ENTER': return '';
                    case 'BACKSPACE': return '';
                    case 'MOUSE WHEEL': return '';
                    case 'SPACE': return '';
                    case 'CLICK': return '';
                    case 'ESC': return '';
                    case 'CTRL': return '';
                    case 'TOUCH': return '';
                    case 'SWIPE': return '';
                    case 'TOUCH ME': return '';
                    // FUNCTOINS
                    case 'TO SKIP': return '';
                    case 'restart': return '';
                    case 'change weeks': return '';
                    case 'switch difficulties': return '';
                    case 'pick tracks': return '';
                    case 'scroll': return '';
                    case 'select': return '';
                    case ", E - remixes": return "";
                    case 'to switch': return '';
                    case 'go back': return '';
                    case 'scroll up': return '';
                    case 'scroll down': return '';
                    case 'save and exit': return '';
                    case 'reset and exit': return ''; 
                    case 'toggle on/off': return '';
                    case 'change value': return '';
                    // MENUS INVOLVING SELECTING WEEKS/SONGS + GAMEOVER + RATINGS + RESULTS
                    case "Coins Earned": return "";
                    case "Gems Earned": return "";
                    case "Perfect": return "";
                    case "FC": return "";
                    case "Good FC": return "";
                    case "Clear": return "";
                    case "Good Clear": return "";
                    case "BRAWL\nCATEGORY": return "";
                    case "EXTRA\nCATEGORY": return "";
                    case "Not enough coins!": return "";
                    case "Song not unlocked yet!": return "";
                    case 'S:': return '';
                    case 'A:': return '';
                    case 'You Died!': return "";
                    case "YOU CANNOT CHEAT HERE": return "";
                    case "DELETE THE FILE": return "";
                    case "YOU'RE STUCK HERE UNTIL THEN": return "";
                    case "CLOSE THE GAME": return "";
                    case "You thought lua would work? This ain't Psych Engine bud.\nKade Engine lua ain't helping ya either.\nPress 'OK' to continue.": return "";
                    case 'exit': return '';
                    case 'ENTER/SPACE': return '';
                    case 'LOCKED': return '';
                    case 'Complete story mode first!': return "";
                    case 'WEEK ': return "";
                    case 'Score': return "";
                    case 'Misses': return "";
                    case 'Accuracy': return "";
                    case 'Songs': return "";
                    case "REMIXES": return "";
                    case 'Notes': return "";
                }
            */
            case 'ptbr':
                switch(string){
                    case 'TO SKIP': return 'PARA PULAR';
                    case 'TOUCH ME': return 'TOQUE-ME';
                    case 'TOUCH': return 'TOCAR';
                    case 'SWIPE': return 'DESLIZE';
                    case "Anti-Aliasing": return "Suavização de Curvas";
                    case "FUN FACT": return "CURIOSIDADE";
                    case "PRO TIP": return "DICA DE PRO";
                    case "SOMETHING": return "ALGO";
                    case 'LEFT': return 'ESQUERDA';
                    case 'RIGHT': return 'DIREITA';
                    case 'UP': return 'CIMA';
                    case 'DOWN': return 'BAIXO';
                    case 'NORMAL': return 'NORMAL';
                    case 'OUTRAGEOUS': return 'ABSURDO';
                    case 'Category (UP/DOWN)': return 'Categoria (CIMA/BAIXO)';
                    case 'No Link Available': return 'Sem Link Disponível';
                    case "Press 'ENTER' to support": return "Aperte 'ENTER' para suporte";
                    case 'VISUALS': return 'VISUAIS';
                    case 'CHARACTERS': return 'PERSONAGENS';
                    case 'VOICE ACTORS': return 'DUBLADORES';
                    case 'AUDIO': return 'AUDIO';
                    case 'REDEEM': return 'RESGATAR';
                    // MAIN MENU
                    case 'STORY MODE': return 'MODO HISTÓRIA';
                    case 'FREEPLAY': return 'FREEPLAY';
                    case 'CREDITS': return 'CRÉDITOS';
                    case 'GAMEJOLT': return 'GAMEJOLT';
                    case 'new song unlocked': return 'nova música desbloqueada';
                    case 'achievement unlocked': return 'conquista dosbloqueada';
                    case "Song can be found in 'Extra' category of Freeplay.": return "Música pode ser achada na categoria 'Extra' do Freeplay";
                    case "Song can be found in 'Brawl' category of Freeplay.": return "Música pode ser achada na categoria 'Brawl' do Freeplay";
                    case "Total Notes Pressed:": return "Total De Notas Pressionadas";
                    case "Total Misses:": return "Error Totais";
                    case 'OVERDONE >:(': return 'EXCESSIVO >:(';
                    case 'Your credit card was Fanum Taxed successfully.': return 'Seu cartão de crédito foi taxado pelo Haddad com sucesso';
                    // GAMEJOLT
                    case "No Game Data Available!": return "Sem Dados De Jogo Disponível!";
                    case "ERROR, Something went wrong...": return "ERRO, Algo deu errado...";
                    case "Username:": return "Nome";
                    case "Game Token:": return "GAME Token";
                    case 'Log In': return 'Log In';
                    case 'Log Out': return 'Log Out';
                    case 'Trophies': return 'Troféis';
                    case "You're about to log out of": return "Você está prestes a Sair";
                    case 'your GameJolt session here.\n': return 'sua sessão do GameJolt aqui. n';
                    case 'Your personal information (username and game token)': return 'Sua informação pessoal (username e token de jogo)';
                    case 'will be removed from this game.\n': return 'vai ser removido desse jogo.\n';
                    case 'Are you sure you want to log out?': return 'Tem certeza que deseja sair?';
                    case '[Press P to Confirm]': return '[Pressione P para Confirmar]';
                    case '[Press BACKSPACE to Cancel]': return '[Pressione BACKSPACE para Cancelar]';
                    // MINIGAMES + TITLE SCREEN STUFF
                    case 'GO TO SLEEP LITTLE ONE.': return "VÀ DORMIR PEQUENO";
                    case "THIS WILL BE OVER SOON.": return "ISSO VAI ACABAR LOGO";
                    // PAUSE MENU STUFF
                    case 'NONE': return 'NENHUM';
                    case 'resume': return 'retomar';
                    case 'options' | 'OPTIONS': return 'OPÇÕES';
                    case 'quit': return 'deixar';
                    case 'Characters': return 'Personagens';
                    case 'Song': return 'Música';
                    // ACTUAL OPTIONS + DESCRIPTIONS
                    case 'Simple': return 'Simples';
                    case 'Milisecond Based': return 'Baseado Em Milisegundos';
                    case 'Flashing Lights': return 'Luzes Piscantes';
                    case "Also affects other things that flash.": return "Também afeta outras coisas que piscam"; 
                    case "Miss Sounds": return "Som de erro";
                    case "Play sound effects when missing notes.": return "Tocar um efeito sonoro quando errar uma nota";
                    case "Skip Cutscenes & Dialogue": return "Pular Cutscenes & Diálogo";
                    case "Menu Instructions": return "Instruções de Menu";
                    case "Menus display instructions on how to use them (this menu is not affected by this).": return "Menus mostram instruções em como usar eles (esse menu não é afetado por isso).";
                    case 'Lane Underlay Opacity': return 'Opacidade Da Subposição da Faixa';
                    case "Change opacity of the background under the notes.": return "Alterar a opacidade do fundo sob as notas";
                    case 'Colorblind Filter': return 'Filtro De Daltonismo';
                    case 'DEUTERANOPIA': return 'DEUTERANOPIA';
                    case 'PROTANOPIA': return 'PROTANOPIA';
                    case 'TRITANOPIA': return 'TRITANOPIA';
                    case "Instakill Key": return "Tecla Instakill";
                    case "Pressing 'R' with this enabled will result in an instant game over.": return "Pressionar 'R' com isso ativado vai resultar em um game over instantâneo";
                    case "View Combo and Rating": return 'Mostrar Combo e Nota';
                    case "View the ratings (Eg. Outrage!) and combo numbers when hitting notes.": return "Visualizar a sua nota (Ex. Absurdo!) e número de combo quando acertar notas";
                    case "Botplay": return "Botplay";
                    case "The game plays for you, no strings attached.": return "O jogo joga por você, sem amarras.";
                    case "Notes will come from above, your strums will be at the bottom of the screen.": return "Notas vão vir de cima, seus dedilhados vão ficar em baixo da tela.";
                    case "If turned on, graphics are smoother, otherwise, they lose their smoothness but improves performance.": return "Se ligado, os gráficos ficarão mais lisos, se não, eles ficarão menos lisos mas vai melhorar a performance";
                    case "Accuracy Calculation": return "Cálculo De Precisão";
                    case "Shaking": return "Tremer";
                    case "Hide HUD": return "Esconder HUD";
                    case "Hides stats and song time and name during gameplay.": return "Esconde os status e tempo de música e nome durante gameplay";
                    case "HUD Opacity": return 'Opacidade Do HUD';
                    case "Sets transparency for all gameplay HUD elements. Lane underlay IS NOT AFFECTED by this.": return "Define a transparência pra todos os elementos do HUD. Subposição de faixa NÃO E AFETADA por isso.";
                    case "Framerate": return 'Framerate';
                    case "Set the framerate the game runs on.": return "Seleciona o framerate que o jogo roda";
                    case "Auto Pause": return "Auto Pausa";
                    case "If this is enabled, the game will pause when not focused on.": return "Se isso está ativado, o jogo vai pausar quando desfocado.";
                    case "FPS Counter": return 'Contador de FPS';
                    case "Appears on the top left corner of the screen.": return "Aparece no canto superior esquerdo da tela.";
                    case "Rainbow FPS Counter": return "Contador De FPS Colorido";
                    case "Photosensitive Warning!": return "Aviso De Fotossensibilidade!";
                    case "Instakill on Miss": return "Instakill Quando Erra";
                    case "Green Screen Mode": return "Modo De Tela Verde";
                    case "When enabled, the gameplay would be just a green screen with the HUD.": return "Quando ativado, a gameplay seria só a tela verde com o HUD.";
                    case "Extra Scroll Speed": return "Extra Scroll Speed";
                    case "The number gets added onto the scroll speed for all songs.": return "Esse número é adicionado no scroll speed de todas as músicas";
                    case "Note Offset": return "Deslocamento da nota";
                    case "Determines how late a note spawns, useful for dealing with audio lag from wireless earphones. Also hold CTRL to scroll faster.": return "Determina o quão tarde as notas aparecem, útil para microfones com lag no áudio. também segure CTRL para ajuste rápido.";
                    // CONTROLS & OPTION CATEGORIES MENU + SUBSTATES
                    case 'Self-explanatory.': return 'Autoexplicativo';
                    case 'Controls': return 'Controles';
                    case 'General & Accessibility': return 'Geral & Acessibilidade';
                    case 'Language': return 'Linguagem';
                    case 'Clear Save Data': return 'Limpar Dados Salvos';
                    case 'MOUSE WHEEL': return 'RODA DO MOUSE';
                    // FUNCTOINS
                    case 'restart': return 'restart';
                    case 'change weeks': return 'mudar semanas';
                    case 'switch difficulties': return 'mudar dificuldade';
                    case 'pick tracks': return 'escolher músicas';
                    case 'select': return 'selecionar';
                    case 'to switch': return 'para mudar';
                    case 'go back': return 'voltar';
                    case 'scroll up': return 'scroll pra cima';
                    case 'scroll down': return 'scroll bra baixo';
                    case 'save and exit': return 'salvar e sair';
                    case 'reset and exit': return 'resetar e sair'; 
                    case 'toggle on/off': return 'alternar on/off';
                    case 'change value': return 'mudar valor';
                    // MENUS INVOLVING SELECTING WEEKS/SONGS + GAMEOVER + RATINGS + RESULTS
                    case "Coins Earned": return "Moedas Ganhas";
                    case "Gems Earned": return "Gemas Ganhas";
                    case "Perfect": return "Perfeiro";
                    case "FC": return "FC";
                    case "Good FC": return "Bom FC";
                    case "Clear": return "Clear";
                    case "Good Clear": return "Bom Clear";
                    case "SHITPOST\nCATEGORY": return "SHITPOST\nCATEGORIA";
                    case "BRAWL\nCATEGORY": return "BRAWL\nCATEGORIA";
                    case "EXTRA\nCATEGORY": return "EXTRA\nCATEGORIA";
                    case "Not enough coins!": return "Sem Moedas Suficiente!";
                    case "Not enough gems!": return "Não há joias suficientes!";
                    case "Song not unlocked yet!": return "Música não desbloqueada ainda!";
                    case 'Score': return "Pontuação";
                    case 'Misses': return "Erros";
                    case 'Accuracy': return "Precisão";
                    case 'S:': return 'P:';
                    case 'A:': return 'P:';
                    case 'You Died!': return "Você Morreu!";
                    case "YOU CANNOT CHEAT HERE": return "VOCÊ NÃO PODE XITAR AQUI";
                    case "DELETE THE FILE": return "DELETE O ARQUIVO";
                    case "YOU'RE STUCK HERE UNTIL THEN": return "VOCÊ ESTA PRESO AQUI ATÉ ENTÃO";
                    case "CLOSE THE GAME": return "FECHE O JOGO";
                    case "You thought lua would work? This ain't Psych Engine bud.\nKade Engine lua ain't helping ya either.\nPress 'OK' to continue.": return "Tu achou que lua ia funcionar? Isoo aqui não e Psych Engine amigão.\nKade Engine muito menos.\nPressione 'OK' para continuar.";
                    case 'exit': return 'sair';
                    case 'ENTER/SPACE': return 'ENTER/SPACE';
                    case 'LOCKED': return 'TRANCADO';
                    case 'Complete story mode first!': return "Complete o modo história primeiro!";
                    case 'WEEK ': return "SEMANA ";
                    case 'Songs': return "Músicas";
                    case "REMIXES": return "REMIXES";
                    case 'Notes': return "Notas";
                }
            case 'rus':
                switch(string){
                    case 'TO SKIP': return 'ЧТОБЫ ПРОПУСТИТЬ';
                    case 'TOUCH ME': return 'КОСНИСЬ МЕНЯ';
                    case 'TOUCH': return 'КОСНУТЬСЯ';
                    case 'SWIPE': return 'СМАХНУТЬ';
                    case "FUN FACT": return "УДИВИТЕЛЬНЫЙ ФАКТ";
                    case "PRO TIP": return "СОВЕТ";
                    case "SOMETHING": return "ЧТО-НИБУДЬ";
                    case 'LEFT': return 'ВЛЕВО';
                    case 'RIGHT': return 'ВПРАВО';
                    case 'UP': return 'ВВЕРХ';
                    case 'DOWN': return 'ВНИЗ';
                    case 'NORMAL': return 'СРЕДНЕ';
                    case 'OUTRAGEOUS': return 'ВОЗМУЩЕНИЕ';
                    case 'Category (UP/DOWN)': return 'Категория (ВВЕРХ/ВНИЗ)';
                    case 'No Link Available': return 'Ссылка недоступна';
                    case "Press 'ENTER' to support": return "Нажмите 'ВВОД', чтобы поддержать";
                    case 'CODERS': return 'КОДЕРЫ';
                    case 'VISUALS': return 'ГРАФИКА';
                    case 'CHARACTERS': return 'ПЕРСОНАЖИ';
                    case 'VOICE ACTORS': return 'ОЗВУЧКА';
                    case 'AUDIO': return 'АУДИО';
                    case 'CHARTERS': return 'ЧАРТЕРЫ';
                    case 'REDEEM': return 'ВВОД';
                    // MAIN MENU
                    case 'STORY MODE': return 'СЮЖЕТ';
                    case 'FREEPLAY': return 'СВОБОДНАЯ\nИГРА';
                    case 'CREDITS': return 'КРЕДИТЫ';
                    case 'LINKS': return 'ССЫЛКИ';
                    case 'new song unlocked': return 'новая песня разблокирована';
                    case 'achievement unlocked': return 'достижение разблокировано';
                    case "Song can be found in 'Extra' category of Freeplay.": return "Песню можно найти в категории 'Экстра' в режиме Freeplay.";
                    case "Song can be found in 'Brawl' category of Freeplay.": return "Песню можно найти в категории 'Схватка' в режиме Freeplay.";
                    case "Total Notes Pressed:": return "Всего нажато нот:";
                    case "Total Misses:": return "Всего промахов:";
                    case 'OVERDONE >:(': return 'ЗАЕБАЛИ >:(';
                    case 'Your credit card was Fanum Taxed successfully.': return 'Ваша кредитная карта была успешно обложена налогом.';
                    // GAMEJOLT
                    case "No Game Data Available!": return "Данные игры отсутствуют!";
                    case "ERROR, Something went wrong...": return "ОШИБКА, что-то пошло не так...";
                    case "Username:": return "Имя пользователя:";
                    case "Game Token:": return "Игровой токен:";
                    case 'Log In': return 'Войти';
                    case 'Log Out': return 'Выйти';
                    case 'Trophies': return 'Достижения';
                    case "You're about to log out of": return "Вы собираетесь выйти из вашего";
                    case 'your GameJolt session here.\n': return 'сеанса GameJolt здесь.\n';
                    case 'Your personal information (username and game token)': return 'Ваша личная информация (имя пользователя и игровой токен)';
                    case 'will be removed from this game.\n': return 'будет удален из этой игры.\n';
                    case 'Are you sure you want to log out?': return 'Вы уверены, что хотите выйти?';
                    case '[Press P to Confirm]': return '[Нажмите P для подтверждения]';
                    case '[Press BACKSPACE to Cancel]': return '[Нажмите BACKSPACE для отмены]';
                    // MINIGAMES + TITLE SCREEN STUFF
                    case 'GO TO SLEEP LITTLE ONE.': return "ИДИ СПАТЬ, МАЛЫШ.";
                    case "THIS WILL BE OVER SOON.": return "ЭТО СКОРО ЗАКОНЧИТСЯ.";
                    // PAUSE MENU STUFF
                    case 'NONE': return 'НИЧЕГО';
                    case 'resume': return 'продолжить';
                    case 'options' | 'OPTIONS': return 'НАСТРОЙКИ';
                    case 'quit': return 'выйти из игры';
                    case 'Background': return 'Фон';
                    case 'Characters': return 'Персонажи';
                    case 'Song': return 'Песня';
                    case "Sprites": return "Спрайты";
                    case "Chart": return "Чарт";
                    case "Chromatics": return "Хроматики";
                    // ACTUAL OPTIONS + DESCRIPTIONS
                    case 'Downscroll': return 'Прокрутка нот вниз';
                    case 'Anti-Aliasing': return 'Сглаживание Кривых';
                    case 'Shaders': return 'Шейдеры';
                    case 'Simple': return 'Простой';
                    case 'Milisecond Based': return 'На основе миллисек.';
                    case 'Flashing Lights': return 'Мигающие Огни';
                    case "Also affects other things that flash.": return "Также влияет на другие вещи, которые мигают."; 
                    case "Miss Sounds": return "Звуки При Промахе";
                    case "Play sound effects when missing notes.": return "Воспроизводить звуковые эффекты при промахе.";
                    case "Skip Cutscenes & Dialogue": return "Пропускать Катсцены и Диалоги";
                    case "Menu Instructions": return "Инструкции по Меню";
                    case "Menus display instructions on how to use them (this menu is not affected by this).": return "Меню отображают инструкции по их использованию (на данное меню это не влияет).";
                    case 'Lane Underlay Opacity': return 'Прозрачность Фона Под Нотами';
                    case "Change opacity of the background under the notes.": return "Изменить прозрачность фона под нотами.";
                    case 'Colorblind Filter': return 'Фильтр Для Дальтоников';
                    case 'DEUTERANOPIA': return 'ДЕЙТЕРАНОПИЯ';
                    case 'PROTANOPIA': return 'ПРОТАНОПИЯ';
                    case 'TRITANOPIA': return 'ТРИТАНОПИЯ';
                    case "Instakill Key": return "Клавиша Смерти";
                    case "Pressing 'R' with this enabled will result in an instant game over.": return "Нажатие клавиши 'R' при включенной функции приведет к мгновенному окончанию игры.";
                    case "View Combo and Rating": return 'Показ Комбо и Рейтинга';
                    case "View the ratings (Eg. Outrage!) and combo numbers when hitting notes.": return "Просматривайте рейтинги (например, 'Возмущение!') и комбо при нажатии нот.";
                    case "Botplay": return "Бот";
                    case "The game plays for you, no strings attached.": return "Игра играет за вас.";
                    case "Notes will come from above, your strums will be at the bottom of the screen.": return "Ноты будут появляться сверху, ваши удары будут внизу экрана.";
                    case "If turned on, graphics are smoother, otherwise, they lose their smoothness but improves performance.": return "Если включить, графика становится более плавной, в противном случае плавность теряется ради производительности.";
                    case "Accuracy Calculation": return "Расчет Точности";
                    case "Shaking": return "Тряска Экрана";
                    case "Hide HUD": return "Скрыть Интерфейс";
                    case "Hides stats and song time and name during gameplay.": return "Скрывает статистику, время и название песни во время игры.";
                    case "HUD Opacity": return 'Прозрачность Интерфейса';
                    case "Sets transparency for all gameplay HUD elements. Lane underlay IS NOT AFFECTED by this.": return "Устанавливает прозрачность для всех элементов игрового интерфейса. Это НЕ ВЛИЯЕТ на фон под нотами.";
                    case "Framerate": return 'Частота Кадров';
                    case "Set the framerate the game runs on.": return "Установить частоту кадров, с которой будет работать игра.";
                    case "Auto Pause": return "Автоматическая Пауза";
                    case "If this is enabled, the game will pause when not focused on.": return "Если эта функция включена, игра будет приостанавливаться, если на ней не сосредоточена твоя мышь.";
                    case "FPS Counter": return 'Счетчик Кадров';
                    case "Appears on the top left corner of the screen.": return "Появляется в верхнем левом углу экрана.";
                    case "Rainbow FPS Counter": return "Радужный счетчик Кадров";
                    case "Photosensitive Warning!": return "Предупреждение для людей с светочувствительностью!";
                    case "Instakill on Miss": return "Смерть При Промахе";
                    case "Green Screen Mode": return "Режим Зеленого Экрана";
                    case "When enabled, the gameplay would be just a green screen with the HUD.": return "При включении, игровой процесс будет представлять собой просто зеленый экран с интерфейсом.";
                    case "Extra Scroll Speed": return "Доп. Скорость Нот";
                    case "The number gets added onto the scroll speed for all songs.": return "Число добавляется к скорости прокрутки для всех песен.";
                    case "Note Offset": return "Смещение Нот";
                    case "Determines how late a note spawns, useful for dealing with audio lag from wireless earphones. Also hold CTRL to scroll faster.": return "Определяет насколько поздно появляется нота, полезно для борьбы с задержкой звука в наушниках. Удерживайте CTRL для быстрой прокрутки.";
                    // CONTROLS & OPTION CATEGORIES MENU + SUBSTATES
                    case 'Self-explanatory.': return 'Очевидно.';
                    case 'Controls': return 'Управление';
                    case 'General & Accessibility': return 'Общие & Доступность';
                    case 'Display': return 'Отображение';
                    case 'Misc': return 'Прочее';
                    case 'MISC': return 'ПРОЧЕЕ';
                    case 'Language': return 'Язык';
                    case 'Gameplay': return 'Геймплей';
                    case 'Clear Save Data': return 'Очистить Данные Сохранения';
                    case 'ENTER': return 'ВВОД';
                    case 'BACKSPACE': return 'ВОЗВРАТ';
                    case 'MOUSE WHEEL': return 'КОЛЕСО';
                    case 'SPACE': return 'ПРОБЕЛ';
                    case 'CLICK': return 'НАЖАТЬ';
                    // FUNCTOINS
                    case 'restart': return 'заново';
                    case 'change weeks': return 'сменить неделю';
                    case 'switch difficulties': return 'переключать сложность';
                    case 'pick tracks': return 'выбрать треки';
                    case 'scroll': return 'прокрутка';
                    case 'select': return 'выбрать';
                    case ", E - remixes": return ", E - ремиксы";
                    case 'to switch': return 'переключаться';
                    case 'go back': return 'вернуться';
                    case 'scroll up': return 'прокрутка вверх';
                    case 'scroll down': return 'прокрутка вниз';
                    case 'save and exit': return 'сохранить и выйти';
                    case 'reset and exit': return 'сброс и выход'; 
                    case 'toggle on/off': return 'вкл/выкл';
                    case 'change value': return 'изменить значение';
                    // MENUS INVOLVING SELECTING WEEKS/SONGS + GAMEOVER + RATINGS + RESULTS
                    case "Coins Earned": return "Заработано монет";
                    case "Gems Earned": return "Заработано гемов";
                    case "Perfect": return "Идеально";
                    case "FC": return "ПК";
                    case "Good FC": return "Хорошее ПК";
                    case "Clear": return "Завершение";
                    case "Good Clear": return "Хорошее Завершение";
                    case "SHITPOST\nCATEGORY": return "Категория\nШитпост";
                    case "BRAWL\nCATEGORY": return "Категория\nБравл";
                    case "EXTRA\nCATEGORY": return "Категория\nЭкстра";
                    case "Not enough coins!": return "Недостаточно монет!";
                    case "Not enough gems!": return "Недостаточно гемов!";
                    case "Song not unlocked yet!": return "Песня еще не разблокирована!";
                    case 'S:': return 'С:';
                    case 'A:': return 'Т:';
                    case 'You Died!': return "Ты умер!";
                    case "YOU CANNOT CHEAT HERE": return "ЗДЕСЬ НЕЛЬЗЯ НАРУШАТЬ ПРАВИЛА";
                    case "DELETE THE FILE": return "УДАЛИТЕ ФАЙЛ";
                    case "YOU'RE STUCK HERE UNTIL THEN": return "ТЫ ЗАСТРЯЛ ЗДЕСЬ ДО ТОГО МОМЕНТА";
                    case "CLOSE THE GAME": return "ЗАКРОЙТЕ ИГРУ";
                    case "You thought lua would work? This ain't Psych Engine bud.\nKade Engine lua ain't helping ya either.\nPress 'OK' to continue.": return "Ты думал, lua сработает? Это не Psych Engine, приятель.\nKade Engine lua тебе тоже не поможет.\nНажми 'ОК', чтобы продолжить.";
                    case 'exit': return 'выход';
                    case 'ENTER/SPACE': return 'ВВОД/ПРОБЕЛ';
                    case 'LOCKED': return 'ЗАБЛОКИРОВАНО';
                    case 'Complete story mode first!': return "Сначала пройдите сюжет!";
                    case 'WEEK ': return "НЕДЕЛЯ ";
                    case 'Score': return "Счет";
                    case 'Misses': return "Промахи";
                    case 'Accuracy': return "Точность";
                    case 'Songs': return "Песни";
                    case "REMIXES": return "РЕМИКСЫ";
                    case 'Notes': return "Ноты";
                }
            case 'ita':
                switch(string) {
                    case 'TO SKIP': return 'PER SALTARE';
                    case 'TOUCH ME': return 'TOCCAMI';
                    case 'TOUCH': return 'TOCCARE';
                    case 'SWIPE': return 'SCORRERE';
                    case 'Anti-Aliasing': return 'Curve Leviganti';
                    case 'CLICK': return 'CLIC';
                    case 'Notes': return "Note";
                    case "FUN FACT": return "LO SAPEVI CHE...";
                    case "PRO TIP": return "CONSIGLIO DA PROFESSIONISTA";
                    case "SOMETHING": return "QUALCOSA";
                    case 'LEFT': return 'SINISTRA';
                    case 'RIGHT': return 'DESTRA';
                    case 'UP': return 'SU';
                    case 'DOWN': return 'GIU';
                    case 'NORMAL': return 'NORMALE';
                    case 'OUTRAGEOUS': return 'SCANDALOSO';
                    case 'Category (UP/DOWN)': return 'Categorie (SU/GIU)';
                    case 'No Link Available': return 'Nessun Link Disponibile';
                    case "Press 'ENTER' to support": return "Premi 'INVIO' per dare supporto";
                    case 'CODERS': return 'PROGRAMMATORI';
                    case 'VISUALS': return 'VISUALIZZAZIONI';
                    case 'CHARACTERS': return 'PERSONAGGI';
                    case 'VOICE ACTORS': return 'DOPPIATORI';
                    case 'REDEEM': return 'RISCATTARE';
                    // MAIN MENU
                    case 'STORY MODE': return 'MODALITA\nSTORIA';
                    case 'CREDITS': return 'CREDITI';
                    case 'new song unlocked': return 'nuova canzone sbloccata';
                    case 'achievement unlocked': return 'obiettivo sbloccato';
                    case "Song can be found in 'Extra' category of Freeplay.": return "La canzone puo essere trovata nella categoria 'Extra' di Freeplay.";
                    case "Song can be found in 'Brawl' category of Freeplay.": return "La canzone puo essere trovata nella categoria 'Brawl' di Freeplay.";
                    case "Total Notes Pressed:": return "Note totali premute:";
                    case "Total Misses:": return "Errori totali:";
                    case 'OVERDONE >:(': return 'ESAGERATO >:(';
                    case 'Your credit card was Fanum Taxed successfully.': return 'La tua carta di credito e stata tassato con Fanum Tax con successo.';
                    // GAMEJOLT
                    case "No Game Data Available!": return "Nessun dato di gioco disponibile!";
                    case "ERROR, Something went wrong...": return "ERRORE, Qualcosa e andato storto...";
                    case "Username:": return "Nome Utente:";
                    case "Game Token:": return "Token di gioco:";
                    case 'Log In': return 'Accedi';
                    case 'Log Out': return 'Disconnettiti';
                    case 'Trophies': return 'Trofei';
                    case "You're about to log out of": return "Stai per uscire da";
                    case 'your GameJolt session here.\n': return 'la tua sessione GameJolt qui.\n';
                    case 'Your personal information (username and game token)': return 'Le tue informazioni personali (nome utente e token di gioco)';
                    case 'will be removed from this game.\n': return 'verranno rimosse da questo gioco.\n';
                    case 'Are you sure you want to log out?': return 'Sei sicuro di voler uscire?';
                    case '[Press P to Confirm]': return '[Premi P per confermare]';
                    case '[Press BACKSPACE to Cancel]': return '[Premi BACKSPACE per annullare]';
                    // MINIGAMES
                    case 'GO TO SLEEP LITTLE ONE.': return "DORMI, PICCOLO.";
                    case "THIS WILL BE OVER SOON.": return "PRESTO SARA FINITA.";
                    // PAUSE MENU STUFF
                    case 'NONE': return 'NESSUNO';
                    case 'resume': return 'Riprende';
                    case 'options' | 'OPTIONS': return 'OPZIONI';
                    case 'quit': return 'Esci';
                    case 'Background': return 'Sfondo';
                    case 'Characters': return 'Personaggi';
                    case 'Song': return 'Canzone';
                    // ACTUAL OPTIONS + DESCRIPTIONS
                    case 'Simple': return 'Semplice';
                    case 'Milisecond Based': return 'A base di millisecondi';
                    case 'Flashing Lights': return 'Luci lampeggianti';
                    case "Also affects other things that flash.": return "Influisce anche su altri elementi lampeggianti."; 
                    case "Miss Sounds": return "Suoni di errore";
                    case "Play sound effects when missing notes.": return "Riproduce effetti sonori quando si sbagliano le note.";
                    case "Skip Cutscenes & Dialogue": return "Salta Scene & Dialoghi";
                    case "Menu Instructions": return "Istruzioni del Menu";
                    case "Menus display instructions on how to use them (this menu is not affected by this).": return "I menu mostrano istruzioni su come usarli (questo menu non e influenzato).";
                    case 'Lane Underlay Opacity': return 'Opacita Corsia';
                    case "Change opacity of the background under the notes.": return "Cambia l'opacita dello sfondo sotto le note.";
                    case 'Colorblind Filter': return 'Filtro Daltonismo';
                    case "Instakill Key": return "Tasto Morte Istantanea";
                    case "Pressing 'R' with this enabled will result in an instant game over.": return "Premendo 'R' con questa opzione attiva si ottiene un game over immediato.";
                    case "View Combo and Rating": return 'Visualizza Combo e Valutazione';
                    case "View the ratings (Eg. Outrage!) and combo numbers when hitting notes.": return "Mostra i rating (Es. Scandaloso!) e il numero di combo quando si colpiscono le note.";
                    case "The game plays for you, no strings attached.": return "Il gioco gioca da solo, senza conseguenze.";
                    case "Notes will come from above, your strums will be at the bottom of the screen.": return "Le note arriveranno dall’alto, gli input dal basso.";
                    case "If turned on, graphics are smoother, otherwise, they lose their smoothness but improves performance.": return "Se attivo, la grafica e piu fluida, altrimenti meno fluida ma con migliori prestazioni.";
                    case "Accuracy Calculation": return "Calcolo della Precisione";
                    case "Shaking": return "Tremolio";
                    case "Hide HUD": return "Nascondi HUD";
                    case "Hides stats and song time and name during gameplay.": return "Nasconde statistiche, tempo e nome della canzone durante il gioco.";
                    case "HUD Opacity": return 'Opacita HUD';
                    case "Sets transparency for all gameplay HUD elements. Lane underlay IS NOT AFFECTED by this.": return "Imposta la trasparenza per tutti gli elementi dell'HUD. La corsia NON e inclusa.";
                    case "Set the framerate the game runs on.": return "Imposta il framerate del gioco.";
                    case "Auto Pause": return "Pausa Automatica";
                    case "If this is enabled, the game will pause when not focused on.": return "Se questa opzione e abilitata, il gioco andra in pausa quando non e attivo.";
                    case "Framerate": return 'Frequenza Fotogrammi';
                    case "FPS Counter": return 'Contatore FPS';
                    case "Appears on the top left corner of the screen.": return "Appare in alto a sinistra dello schermo.";
                    case "Rainbow FPS Counter": return "Contatore FPS Arcobaleno";
                    case "Photosensitive Warning!": return "Avviso per Fotosensibili!";
                    case "Instakill on Miss": return "Morte Istantanea al Fallimento";
                    case "Green Screen Mode": return "Modalita Green Screen";
                    case "When enabled, the gameplay would be just a green screen with the HUD.": return "Quando attiva, il gameplay e uno schermo verde con l'HUD.";
                    case "Extra Scroll Speed": return "Velocita Extra Scorrimento";
                    case "The number gets added onto the scroll speed for all songs.": return "Questo valore si aggiunge alla velocita di scorrimento delle canzoni.";
                    case "Note Offset": return "Ritardo Note";
                    case "Determines how late a note spawns, useful for dealing with audio lag from wireless earphones. Also hold CTRL to scroll faster.": return "Determina quanto in ritardo appaiono le note, utile per ritardi audio con cuffie wireless. Tieni premuto CTRL per scorrere piu velocemente.";
                    // CONTROLS & OPTION CATEGORIES MENU + SUBSTATES
                    case 'Self-explanatory.': return 'Autoesplicativo.';
                    case 'Controls': return 'Controlli';
                    case 'General & Accessibility': return 'Generali & Accessibilita';
                    case 'Display': return 'Schermo';
                    case 'Misc': return 'Varie';
                    case 'MISC': return 'VARIE';
                    case 'Language': return 'Lingua';
                    case 'Clear Save Data': return 'Cancella Dati di Salvataggio';
                    case 'ENTER': return 'INVIO';
                    case 'MOUSE WHEEL': return 'ROTELLINA';
                    case 'SPACE': return 'SPAZIO';
                    // FUNCTOINS
                    case 'restart': return 'riavvia';
                    case 'change weeks': return 'cambia settimane';
                    case 'switch difficulties': return 'cambia difficolta';
                    case 'pick tracks': return 'scegli tracce';
                    case 'scroll': return 'scorri';
                    case 'select': return 'seleziona';
                    case 'to switch': return 'per cambiare';
                    case 'go back': return 'torna indietro';
                    case 'scroll up': return 'scorri su';
                    case 'scroll down': return 'scorri giu';
                    case 'save and exit': return 'salva ed esci';
                    case 'reset and exit': return 'resetta ed esci'; 
                    case 'toggle on/off': return 'attiva/disattiva';
                    case 'change value': return 'cambia valore';
                    // MENUS INVOLVING SELECTING WEEKS/SONGS + GAMEOVER + RATINGS + RESULTS
                    case "Coins Earned": return "Monete Guadagnate";
                    case "Gems Earned": return "Gemme Ottenute";
                    case "Perfect": return "Perfetto";
                    case "Good FC": return "Buon FC";
                    case "Clear": return "Superato";
                    case "Good Clear": return "Superato Bene";
                    case "SHITPOST\nCATEGORY": return "CATEGORIA\nSHITPOST";
                    case "BRAWL\nCATEGORY": return "CATEGORIA\nBRAWL";
                    case "EXTRA\nCATEGORY": return "CATEGORIA\nEXTRA";
                    case "Not enough coins!": return "Non hai abbastanza monete!";
                    case "Not enough gems!": return "Non ci sono abbastanza gemme!";
                    case "Song not unlocked yet!": return "Canzone non ancora sbloccata!";
                    case 'S:': return 'P:';
                    case 'A:': return 'P:';
                    case 'You Died!': return "Sei Morto!";
                    case "YOU CANNOT CHEAT HERE": return "NON PUOI BARARE QUI";
                    case "DELETE THE FILE": return "ELIMINA IL FILE";
                    case "YOU'RE STUCK HERE UNTIL THEN": return "RESTERAI QUI FINCHE NON LO FAI";
                    case "CLOSE THE GAME": return "CHIUDI IL GIOCO";
                    case "You thought lua would work? This ain't Psych Engine bud.\nKade Engine lua ain't helping ya either.\nPress 'OK' to continue.": return "Pensavi che funzionasse il lua? Questo non è Psych Engine, amico.\nNemmeno il lua del Kade Engine ti aiuterà.\nPremi 'OK' per continuare.";
                    case 'exit': return 'uscita';
                    case 'ENTER/SPACE': return 'INVIO/SPAZIO';
                    case 'LOCKED': return 'BLOCCATO';
                    case 'Complete story mode first!': return "Completa prima la modalita storia!";
                    case 'WEEK ': return "SETTIMANA ";
                    case 'Score': return "Punteggio";
                    case 'Misses': return "Errori";
                    case 'Accuracy': return "Precisione";
                    case 'Songs': return "Canzoni";
                }
            case 'esp':
                switch(string) {
                    case 'TO SKIP': return 'PARA SALTAR';
                    case 'TOUCH ME': return 'TÓCAME';
                    case 'TOUCH': return 'TOCAR';
                    case 'SWIPE': return 'DESLIZAR';
                    case 'Anti-Aliasing': return 'Curvas Suavizadas';
                    // MINIGAMES + LOADING HEADINGS + TITLE SCREEN STUFF
                    case 'GO TO SLEEP LITTLE ONE.': return "VETE A DORMIR PEQUEÑO.";
                    case "THIS WILL BE OVER SOON.": return "ESTO TERMINARA PRONTO.";
                    case "FUN FACT": return "¿SABIAS?";
                    case "PRO TIP": return "CONSEJO";
                    case "SOMETHING": return "ALGO";
                    // PAUSE MENU STUFF
                    case 'NONE': return 'NINGUN';
                    case 'resume': return 'Continuar';
                    case 'options' | 'OPTIONS': return 'AJUSTES';
                    case 'quit': return 'Abandonar';
                    case 'Background': return 'Fondo';
                    case 'Characters': return 'Personajes';
                    case 'Song': return 'Cancion';
                    // ACTUAL OPTIONS + DESCRIPTIONS
                    case 'Milisecond Based': return 'Basado en milisegundos';
                    case 'Flashing Lights': return 'Luces Brillantes';
                    case "Also affects other things that flash.": return "Tambien afecta a otras cosas que parpadean."; 
                    case "Miss Sounds": return 'Sonidos de Fallo';
                    case "Play sound effects when missing notes.": return "Reproduce efectos de sonido cuando faltan notas.";
                    case "Skip Cutscenes & Dialogue": return 'Saltar Cinematicas y Dialogo';
                    case "Menu Instructions": return "Instrucciones del menu";
                    case "Menus display instructions on how to use them (this menu is not affected by this).": return "Los menus muestran instrucciones sobre como usarlos (este menu no se ve afectado por esto).";
                    case 'Lane Underlay Opacity': return 'Opacidad de Fondo de Notas';
                    case "Change opacity of the background under the notes.": return "Cambiar la opacidad del fondo debajo de las notas.";
                    case 'Colorblind Filter': return 'Filtro de Daltonismo';
                    case "Instakill Key": return 'Tecla Instakill';
                    case "Pressing 'R' with this enabled will result in an instant game over.": return "Si presionas 'R' con esta opcion habilitada, el juego terminara instantaneamente.";
                    case "View Combo and Rating": return 'Ver Combo y Calificacion';
                    case "View the ratings (Eg. Outrage!) and combo numbers when hitting notes.": return "Ver las calificaciones (por ejemplo, ¡Indignacion!) y los numeros al tocar notas.";
                    case "The game plays for you, no strings attached.": return "El juego se juega para ti, sin ataduras.";
                    case "Notes will come from above, your strums will be at the bottom of the screen.": return "Las notas vendran desde arriba, tus rasgueos estaran en la parte inferior de la pantalla.";
                    case "If turned on, graphics are smoother, otherwise, they lose their smoothness but improves performance.": return "Si esta activado, los graficos son mas fluidos; de lo contrario, pierden su fluidez pero mejoran el rendimiento.";
                    case "Accuracy Calculation": return "Calculo de exactitud";
                    case "Shaking": return 'Temblor';
                    case "Hide HUD": return 'Esconder HUD';
                    case "Hides stats and song time and name during gameplay.": return "Oculta las estadisticas, la duracion y el nombre de la cancion durante el juego.";
                    case "HUD Opacity": return 'Opacidad de la IU';
                    case "Sets transparency for all gameplay HUD elements. Lane underlay IS NOT AFFECTED by this.": return "Establece la transparencia de todos los elementos del HUD del juego. El fondo de notas NO SE VA AFECTADA.";
                    case "Set the framerate the game runs on.": return "Establece la velocidad de cuadros con la que se ejecuta el juego.";
                    case "Auto Pause": return 'Auto Pausar';
                    case "If this is enabled, the game will pause when not focused on.": return "Si esta opcion esta habilitada, el juego se pausara cuando no haya foco en el.";
                    case "FPS Counter": return 'Contador de FPS';
                    case "Framerate": return "Velocidad de Fotogramas";
                    case "Appears on the top left corner of the screen.": return "Aparece en la esquina superior izquierda de la pantalla.";
                    case "Rainbow FPS Counter": return 'Contador de FPS arcoiris';
                    case "Photosensitive Warning!": return "¡Advertencia fotosensible!";
                    case "Instakill on Miss": return 'Instakill en Fallo';
                    case "Green Screen Mode": return 'Modo de pantalla verde';
                    case "When enabled, the gameplay would be just a green screen with the HUD.": return "Cuando esta habilitado, el juego sera solo una pantalla verde con el HUD.";
                    case "Extra Scroll Speed": return 'Velocidad de Scroll extra';
                    case "The number gets added onto the scroll speed for all songs.": return "El numero se agrega a la velocidad de scroll de todas las canciones.";
                    case "Note Offset": return 'Retardo de Notas';
                    case "Determines how late a note spawns, useful for dealing with audio lag from wireless earphones. Also hold CTRL to scroll faster.": return "Determina el retraso en la reproduccion de una nota, util para solucionar el retraso de audio de los auriculares inalambricos. Manten presionada la tecla CTRL para desplazar mas rapido.";
                    // CONTROLS & OPTION CATEGORIES MENU + SUBSTATES
                    case 'Self-explanatory.': return 'Se explica por si solo.';
                    case 'Controls': return 'Controles';
                    case 'General & Accessibility': return 'General y accesibilidad';
                    case 'Gameplay': return 'Jugabilidad';
                    case 'Display': return 'Presentacion';
                    case 'Misc': return 'Miscelanea';
                    case 'MISC': return 'MISCELANEA';                   
                    case 'Language': return 'Idioma';
                    case 'Clear Save Data': return 'Borrar datos guardados';
                    case 'ENTER': return 'ENTRAR';
                    case 'BACKSPACE': return 'RETROCESO';
                    case 'LEFT': return 'IZQ';
                    case 'RIGHT': return 'DERECHA';
                    case 'UP': return 'ARRIBA';
                    case 'DOWN': return 'ABAJO';
                    case 'MOUSE WHEEL': return 'RUEDA';
                    case 'CLICK': return 'CLIC';
                    case 'SPACE': return 'ESPACIO';
                    // FUNCTOINS
                    case 'restart': return 'reanudar';
                    case 'change weeks': return 'cambiar semanas';
                    case 'switch difficulties': return 'cambiar dificultades';
                    case 'pick tracks': return 'elegir canciones';
                    case 'scroll': return 'desplazar';
                    case 'select': return 'elegir';
                    case 'to switch': return 'para cambiar';
                    case 'go back': return 'regresar';
                    case 'scroll up': return 'desplazar arriba';
                    case 'scroll down': return 'deplazar abajo';
                    case 'save and exit': return 'guardar y regresar';
                    case 'reset and exit': return 'restablecer y salir'; 
                    case 'toggle on/off': return 'des/activar';
                    case 'change value': return 'cambiar valor';
                    // MENUS INVOLVING SELECTING WEEKS/SONGS + GAMEOVER + RATINGS + RESULTS
                    case "Coins Earned": return "Monedas Ganadas";
                    case 'Notes': return "Notas";
                    case "Gems Earned": return "Gemas Ganadas";
                    case "Perfect": return "Perfecto";
                    case "FC": return "CC";
                    case "Good FC": return "Buen CC";
                    case "Clear": return "Pase";
                    case "Good Clear": return "Buen Pase";
                    case "SHITPOST\nCATEGORY": return "CATEGORIA\nSHITPOST";
                    case "BRAWL\nCATEGORY": return "CATEGORIA\nBRAWL";
                    case "EXTRA\nCATEGORY": return "CATEGORIA\nEXTRA";
                    case "Not enough coins!": return "¡No hay suficientes monedas!";
                    case "Not enough gems!": return "¡No hay suficientes gemas!";
                    case "Song not unlocked yet!": return "¡Cancion aun no desbloqueada!";
                    case 'S:': return 'P:';
                    case 'A:': return 'E:';
                    case 'You Died!': return '¡Has Muerto!';
                    case "YOU CANNOT CHEAT HERE": return 'AQUI NO PUEDES HACER TRAMPAS';
                    case "DELETE THE FILE": return "ELEMINA EL ARCHIVO";
                    case "YOU'RE STUCK HERE UNTIL THEN": return "ESTAS ATRAPADO AQUI HASTA ENTONCES";
                    case "CLOSE THE GAME": return "CIERRA EL JUEGO";
                    case "You thought lua would work? This ain't Psych Engine bud.\nKade Engine lua ain't helping ya either.\nPress 'OK' to continue.": return "¿Pensabas que lua funcionaria? Esto no es Psych Engine, amigo.\nEl lua de Kade Engine tampoco te ayuda.\nPulsa 'OK' para continuar.";
                    case 'exit': return 'Salir';
                    case 'ENTER/SPACE': return 'ENTRAR/ESPACIO';
                    case 'LOCKED': return 'BLOQUEADO';
                    case 'OUTRAGEOUS': return 'INDIGNANTE';
                    case 'Complete story mode first!': return '¡Primero completa el modo historia!';
                    case 'WEEK ': return 'SEMANA ';
                    case 'Score': return 'Puntaje';
                    case 'Misses': return 'Fallos';
                    case 'Accuracy': return 'Exactitud';
                    case 'Songs': return 'Canciones';
                    // CREDITS
                    case 'Category (UP/DOWN)': return 'Categoria (ARRIBA/ABAJO)';
                    case 'No Link Available': return 'No hay enlace disponible';
                    case "Press 'ENTER' to support": return "Presione 'ENTRAR' para seguir a";
                    case 'CODERS': return 'PROGRAMADORES';
                    case 'VISUALS': return 'VISUALES';
                    case 'CHARACTERS': return 'PERSONAJES';
                    case 'VOICE ACTORS': return 'ACTORES DE VOZ';
                    case 'REDEEM': return 'CANJEAR';
                    // MAIN MENU
                    case 'STORY MODE': return 'MODO HISTORIA';
                    case 'CREDITS': return 'CREDITOS';
                    case 'LINKS': return 'ENLACES';
                    case 'new song unlocked': return 'nueva cancion';
                    case 'achievement unlocked': return 'nuevo logro';
                    case "Song can be found in 'Extra' category of Freeplay.": return "La canción se puede encontrar en la categoría de canciones 'Extra' en Freeplay.";
                    case "Song can be found in 'Brawl' category of Freeplay.": return "La canción se puede encontrar en la categoría de canciones 'Brawl' en Freeplay.";
                    case "Total Notes Pressed:": return 'Total de notas impresas:';
                    case "Total Misses:": return "Fallos totales:";
                    case 'OVERDONE >:(': return "EXAGERADO >:(";
                    case 'Your credit card was Fanum Taxed successfully.': return 'Su tarjeta de crédito fue gravada Fanum exitosamente.';
                    // GAMEJOLT
                    case "No Game Data Available!": return "¡No hay datos de juego disponibles!";
                    case "ERROR, Something went wrong...": return "ERROR, Algo salió mal...";
                    case "Username:": return "Usuario:";
                    case "Game Token:": return "Token de juego:";
                    case 'Log In': return 'Iniciar\nSesion';
                    case 'Log Out': return 'Cerrar\nSesion';
                    case 'Trophies': return 'Trofeos';
                    case "You're about to log out of": return "Estás a punto de cerrar sesion";
                    case 'your GameJolt session here.\n': return "en GameJolt aqui.\n";
                    case 'Your personal information (username and game token)': return 'Tu informacion personal (nombre de usuario y token de juego)';
                    case 'will be removed from this game.\n': return 'sera eliminado de este juego.\n';
                    case 'Are you sure you want to log out?': return '¿Estás seguro de que quiere cerrar sesion?';
                    case '[Press P to Confirm]': return '[Presione P para confirmar]';
                    case '[Press BACKSPACE to Cancel]': return '[Presione RETROCESO para cancelar]';
                }
        }
        return string;
    }
}