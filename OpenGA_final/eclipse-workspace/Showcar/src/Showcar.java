import java.util.Scanner;
class Car{
	String number;
	String color;
	double speed;
	void showinformation()
	{
		System.out.println(number);
		System.out.println(color);
		System.out.println(speed);
	}
	double slowdown(double speed)
	{
		speed-=10;
		return speed;
	}
	double speedup(double speed) {
		speed+=10;
		return speed;
	}
	double slowdown(double speed,double delta){
		speed-=delta;
		return speed;
	}
}
public class Showcar {
	public static void main(String args[])
	{
		Scanner sc=new Scanner(System.in);
		
		Car car1= new Car();
		car1.number="A4185";
		car1.speed=150.4;
		car1.color="green";
		System.out.println("1st car's information:");
		car1.showinformation();
		
		Car car2= new Car();
		car2.number="D5874";
		car2.speed=140.5;
		car2.color="red";
		System.out.println("2nd car's information:");
		car2.showinformation();
		
		Car car3= new Car();
		car3.number="G5689";
		car3.speed=120.3;
		car3.color="blue";
		System.out.println("3rd car's information:");
		car3.showinformation();
		
		System.out.println("�п�J�Ĥ@�x���t�״�֪��ƭ�:");
		double delta=sc.nextDouble();
		double reducedSpeed=car1.slowdown(car1.speed,delta);
		System.out.println("�Ĥ@�x���t��:");
		System.out.println(reducedSpeed);
		
		System.out.println("�ĤG�x����t�⦸");
		reducedSpeed=car2.slowdown(car2.speed);
		reducedSpeed=car2.slowdown(reducedSpeed);
		System.out.println("�ĤG�x���t��:"+reducedSpeed);
		
	}
}
