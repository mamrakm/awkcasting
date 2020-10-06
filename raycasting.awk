BEGIN {
    COLS = int(COLS / 10) * 10 + 1;
    LINES = int(LINES / 10) * 10 + 1;
    SCENE[COLS,LINES];
    ACTOR_POS_X = 0;
    ACTOR_POS_Y = 0;
    while (1) {
        printf("\x1B[2J");
        drawGrid(COLS, LINES);
        drawActor();
        renderScene();
        getline KEY < "/dev/tty";

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
    }
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