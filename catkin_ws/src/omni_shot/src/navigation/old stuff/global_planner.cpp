 #include <pluginlib/class_list_macros.h>
 #include "global_planner.h"

 //register this planner as a BaseGlobalPlanner plugin
 PLUGINLIB_EXPORT_CLASS(global_planner::GlobalPlanner, nav_core::BaseGlobalPlanner)

 using namespace std;

 //Default Constructor
 namespace global_planner 
 {

	GlobalPlanner::GlobalPlanner ()
	{
		std::vector<geometry_msgs::Pose> tempPath;

		for(unsigned int i = 0; i++; i < 200)
		{
			geometry_msgs::Pose temp; 
			temp.position.x =  i ;
			temp.position.y =  i ;
			temp.orientation.w = 1;
			tempPath.push_back(temp);
		}

		createAPath(tempPath);

	}

	GlobalPlanner::GlobalPlanner(std::string name, costmap_2d::Costmap2DROS* costmap_ros)
	{
		initialize(name, costmap_ros);

	}  


	void GlobalPlanner::initialize(std::string name, costmap_2d::Costmap2DROS* costmap_ros)
	{

	}

	bool GlobalPlanner::makePlan(const geometry_msgs::PoseStamped& start, const geometry_msgs::PoseStamped& goal,  std::vector<geometry_msgs::PoseStamped>& plan )
	{

		std::vector<geometry_msgs::PoseStamped> tempPath;

		tempPath.push_back(start);
		for(unsigned int i = 0; i++; i < myPath.size())
		{
			
			tempPath.push_back(myPath[i]);

		}
		tempPath.push_back(goal);

		plan = tempPath;
		

		return true;
	}


	bool GlobalPlanner::createAPath(std::vector<geometry_msgs::Pose>& points)
	{

		std::vector<geometry_msgs::PoseStamped> tempPath;
		
		for(unsigned int i = 0; i++; i < points.size())
		{
			geometry_msgs::PoseStamped temp; 
			temp.pose = points[i];
			//temp.header.frame_id = "odom";
			tempPath.push_back(temp);

		}

		myPath = tempPath;


	}

 };


 