  class Car {
    //class properties
    String name;
    String color;
    final int _k=0;
    //constructor
    Car({ required this.name, required this.color});

    // factory constructor that returns a new instance
    factory Car.fromJson(Map json) {
    return Car(name : json['name'], 
    color : json['color']);
    }
}

void main(){
    // create a map
    Map myCar = {'name': 'Mercedes-Benz', 'color': 'blue'};
    // assign to Car instance
    Car car = Car.fromJson(myCar);
    //display result
    print(car.name);
    print(car.color);
    car._k;
}