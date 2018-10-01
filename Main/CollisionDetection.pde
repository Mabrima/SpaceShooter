boolean circleCollision(PVector v1, float size1, PVector v2, float size2) {
    float maxDistance = (size1 + size2)/2;
    if (abs(v1.x - v2.x) > maxDistance || abs(v1.y - v2.y) > maxDistance){
        return false;
    }  
    return dist(v1.x, v1.y, v2.x, v2.y) < maxDistance;
}