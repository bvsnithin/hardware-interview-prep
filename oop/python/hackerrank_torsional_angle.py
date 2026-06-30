"""
https://www.hackerrank.com/challenges/class-2-find-the-torsional-angle/problem?isFullScreen=true

You are given four points  and  in a 3-dimensional Cartesian coordinate system. You are required to print the angle between the plane made by the points  and  in degrees(not radians). 
Let the angle be PHI.

COS(PHI) = (X.Y)/|X||Y| where X =  AB X BC and Y = BC X CD

Here X.Y,  means the dot product of X and Y , and  AB X BC  means the cross product of vectors AB and CD. 

Also, AB = B -A.

Input Format
One line of input containing the space separated floating number values of the  and  coordinates of a point.

Output Format
Output the angle correct up to two decimal places.

Sample Input
0 4 5
1 7 6
0 5 9
1 7 2

Sample Output
8.19

5 8.8 9
4 -1 3
7 8.7 3.3
4.4 5.1 6.3

5.69
"""
import math

class Points(object):
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
    def __sub__(self, no):
        sub_x = self.x - no.x
        sub_y = self.y - no.y
        sub_z = self.z - no.z
        
        return Points(sub_x, sub_y, sub_z)
    def dot(self, no):
        dot_x = self.x * no.x
        dot_y = self.y * no.y
        dot_z = self.z * no.z
        
        return dot_x+ dot_y + dot_z
    def cross(self, no):
        cross_x = (self.y * no.z) - (self.z * no.y)
        cross_y = (self.z * no.x) - (self.x * no.z)
        cross_z = (self.x * no.y) - (self.y * no.x)
    
        return Points(cross_x, cross_y, cross_z)
    def absolute(self):
        return pow((self.x ** 2 + self.y ** 2 + self.z ** 2), 0.5)

if __name__ == '__main__':
    points = list()
    for i in range(4):
        a = list(map(float, input().split()))
        points.append(a)

    a, b, c, d = Points(*points[0]), Points(*points[1]), Points(*points[2]), Points(*points[3])
    x = (b - a).cross(c - b)
    y = (c - b).cross(d - c)
    angle = math.acos(x.dot(y) / (x.absolute() * y.absolute()))

    print("%.2f" % math.degrees(angle))