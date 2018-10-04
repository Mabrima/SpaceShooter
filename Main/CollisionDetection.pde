boolean circleCollision(PVector v1, float size1, PVector v2, float size2) {
    float maxDistance = (size1 + size2)/2;
    if (abs(v1.x - v2.x) > maxDistance || abs(v1.y - v2.y) > maxDistance){
        return false;
    }  
    return dist(v1.x, v1.y, v2.x, v2.y) < maxDistance;
}

public boolean boxAndCircleCollision(PVector circlePosition, float circleSize, int[] box) { 
    return !(box[0] - box[2]/2 > circlePosition.x + circleSize ||
        box[0] + box[2]/2 < circlePosition.x - circleSize ||
        box[1] - box[3]/2 > circlePosition.y + circleSize ||
        box[1] + box[3]/2 < circlePosition.y - circleSize);
}