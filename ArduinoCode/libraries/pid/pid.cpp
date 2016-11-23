/*
	Nathaniel Goldfarb
	8/22/15
	discrite PID control algorithum

*/

#include "pid.h"


using namespace std;

//default constructor
//set some random values
pid::pid()
{
	
	kp = .1;
	kd = .1;
	ki = .1;
	iMax = 100;
	iMin = 0;
	lastError = 0;
	totalError = 0;

}
//constructor, set the values for the control 
pid::pid(double p, double i, double d, double min, double max)
{
	kp = p;
	ki = i;
	kd = d;
	iMin = min;
	iMax = max;
	lastError = 0;
	totalError = 0;

}

//set a destination value
//reset the errors for a new loop
void pid::setDestination(double p)
{
	destination = p;
	lastError = 0;
	totalError = 0;
	error = 0;

}

//take in a measurment to update the movement.
double pid::update(double point)
{
	//hold values in the PID eq
	double proportional = 0;
	double integral = 0;
	double derivative = 0;
	double pid = 0;

	//calculate error
	error = point- destination;
	totalError = totalError + error;

	//bound the intergrator
	if (totalError> iMax)
	{
		totalError = iMax;
	}
	else if(totalError < iMin)
	{
		totalError = iMin;
	}

	//calculate the pid
	proportional = kp*error;
	derivative = kd * ( error - lastError);	
	integral = ki*totalError;
	pid = proportional + integral + derivative;

	return pid;
}


void pid::setKP(double input)
{
	kp = input;
}

void pid::setKD(double input)
{
	kd = input;
}

void pid::setKI(double input)
{
	ki = input;
}

void pid::setLimits(double min,double max)
{
	iMin = min;
	iMax = max;
}
double pid::getKP()
{
	return kp;
}
double pid::getKI()
{ 
	return ki;

}

double pid::getKD()
{
	 return kd;
}
double pid::getError()
{ 
	return error;
}

double pid::getDestination()
{
	return destination;
}

