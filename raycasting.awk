BEGIN {
    COLS -= 1;
    LINES -= 1;
    SCENE[COLS,LINES];

    drawGrid(COLS, LINES);
    renderScene();
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
                else {
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
                            addSymbolToScene(x, y, "│");
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