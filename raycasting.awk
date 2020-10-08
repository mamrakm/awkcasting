BEGIN {
    PI = 3.14159;
    COLS = int(COLS / 10) * 10 + 1;
    LINES = int(LINES / 10) * 10 + 1;
    ACTOR_POS_X = 0;
    ACTOR_POS_Y = 0;
    debug=0;

    TRANSLATE_POS_X = 0;
    TRANSLATE_POS_Y = 0;

    while (1) {
        initScene();
        # drawGrid(COLS, LINES);
        # drawActor();
        drawCosine();
        renderScene();

        # getline KEY < "/dev/tty";
        # updateActorCoordinates();
        break;
    }
}

function initScene() {
    for(y = 0; y < LINES; y++) {
        for(x = 0; x < COLS; x++) {
            addSymbolToScene(x, y, " ");
        }
    }
}
function drawCosine() {
    translate(0, 25);
    ycos = 0;
    for(i = 0; i < COLS; i += 1) {
        # print("ycos: ", ceil(ycos));
        addSymbolToScene(i, ceil(ycos), "*");
        print("x pos: ", i, " y pos: ", ceil(ycos), " cos(i)=", cos(i));
        ycos += cos(i/10);
    }
}

function translate(xt, yt) {
    TRANSLATE_POS_X = xt;
    TRANSLATE_POS_Y = yt;
}

function updateActorCoordinates() {
        if(KEY == "w") {
            if(ACTOR_POS_Y > 0) {
                ACTOR_POS_Y--;
            }
        }
        if(KEY == "s") {
           if(ACTOR_POS_Y < LINES) {
                ACTOR_POS_Y++;
            }
        }
        if(KEY == "a") {
            if(ACTOR_POS_X > 0) {
                ACTOR_POS_X--;
            }
        }
        if(KEY == "d") {
           if(ACTOR_POS_X < COLS) {
                ACTOR_POS_X++;
            }
        }
        if(KEY == "q") {
            exit;
        }
        printf("\x1B[2J");
}

function drawActor() {
    addSymbolToScene(ACTOR_POS_X, ACTOR_POS_Y,"◉");
}

function drawGrid(xLim, yLim) {
    x = 0;
    y = 0;
    while(y < yLim) {
        x = 0;
        while(x < xLim) {
            if(x == 0 && y == 0) {
                addSymbolToScene(x, y, "╭");
            }
            else if(x == xLim - 1 && y == 0) {
                addSymbolToScene(x, y, "╮");
            }
            else if(x == 0 && y == yLim - 1) {
                addSymbolToScene(x, y, "╰");
            }
            else if (x == xLim - 1 && y == yLim - 1) {
                addSymbolToScene(x, y, "╯");
            }
            else {
                if(x == 0 || x == xLim - 1) {
                    addSymbolToScene(x, y, "│");
                }
                if(y == 0 || y == yLim - 1) {
                    if (x % 10 == 0) {
                        if (y == 0) {
                            addSymbolToScene(x, y, "┬");
                        }
                        if(y == yLim - 1) {
                            addSymbolToScene(x, y, "┴");
                        }
                    } else {
                        addSymbolToScene(x, y, "─");
                    }
                } else {
                    if (x % 10 == 0) {
                        if(y % 10 == 0) {
                            addSymbolToScene(x, y, "┼");
                        } else {
                            addSymbolToScene(x, y, "│");
                        }
                    }
                    else {
                        if(y % 10 == 0) {
                            addSymbolToScene(x, y, "─");
                        }
                        else {
                            addSymbolToScene(x, y, " ");
                        }
                    }
                }
            }
            x++;
        }
        addSymbolToScene(x, y, "\n");
        y++;
    }
}

function renderScene() {
    for(y = 0;y < LINES; y++) {
        for(x = 0; x < COLS; x++) {
            printf(SCENE[x, y]);
        }
        printf("\n");
    }
}

function addSymbolToScene(x, y, symbol) {
    if ((TRANSLATE_POS_X + x) > COLS || (TRANSLATE_POS_Y + y) > LINES) {
        print("\x1B[1;91;103mERROR: addSymbolToScene(", TRANSLATE_POS_X + x, ", ", TRANSLATE_POS_Y + y, ")", "\x1B[38;48m");
        exit;
    }
    if(debug) {
        print("\x1B[1;91;103mDEBUG: addSymbolToScene(", TRANSLATE_POS_X + x, ", ", TRANSLATE_POS_Y + y, ")", "\x1B[38;48m");
    }
    SCENE[(TRANSLATE_POS_X + x), (TRANSLATE_POS_Y + y)] = symbol;
}

function ceil(num) {
    if(num >= 0){
        return 1 + int(num);
    }
    if(num < 0) {
        return int(num);
    }

}