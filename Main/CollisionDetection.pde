boolean intersectsCircle(Circle other){
    return dist(pos.x, pos.y, other.pos.x, other.pos.y) < r + other.r;
}