
#ifndef PID_H
#define PID_H
#endif

class pid
{
	private:
		double ki;
		double kd;
		double kp;
		double iMax;
		double iMin;
		double error;
		double totalError;
		double lastError;
		double destination;

	public:
		pid();
		
		pid(double, double, double, double, double);
		double update(double);
		void setDestination(double);
		void setKP(double);
		void setKD(double);
		void setKI(double);
		void setLimits(double,double);
		double getKP();
		double getKI();
		double getKD();
		double getError();
		double getDestination();
		
};

