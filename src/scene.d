module scene;
import all;

class Scene{
    abstract Scene update(State st);
    abstract void draw(State st);
}
