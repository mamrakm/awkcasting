BEGIN {
    PI = 3.14159;
    COLS = int(COLS / 10) * 10 + 1;
    LINES = int(LINES / 10) * 10 + 1;
    SCENE[COLS,LINES];
    ACTOR_POS_X = 0;
    ACTOR_POS_Y = 0;

    TRANSLATE_POS_X = 0;
    TRANSLATE_POS_Y = 0;

    initScene();

    while (1) {
        # drawGrid(COLS, LINES);
        # drawActor();
        drawCosine();
        renderScene();

        getline KEY < "/dev/tty";
        updateActorCoordinates();
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
    translate(0,20);
    y = TRANSLATE_POS_Y;
    for(i = TRANSLATE_POS_X; i < COLS; i += 1) {
        addSymbolToScene(i, TRANSLATE_POS_Y + int(y), "X");
        # print("x pos: ", i, " y pos: ", int(y), " cos(i)=", cos(i/50));
        y += cos(i/10);
    }
}

function translate(x, y) {
    TRANSLATE_POS_X = x;
    TRANSLATE_POS_Y = y;
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
    for(y = 0;y <= LINES; y++) {
        for(x = 0; x <= COLS; x++) {
            printf(SCENE[x, y]);
        }
    }
}

function addSymbolToScene(x, y, symbol) {
    SCENE[x, y] = symbol;
}