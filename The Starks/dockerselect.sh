#!/bin/sh
# shell script for docker
echo "What operation do you want to perform \n Enter 'deploy' to deploy an image \n Enter 'start' to start an image \n Enter 'stop' to stop an image \n Enter 'remove' to remove an image"
read input
#declare -i RAM
	case $input in
	'deploy')
		echo " Well ! enter 1 to deploy nginx and 2 to deploy httpd"
		read deploy_input 
		echo " Enter the CPU/RAM space needed for the image in GB"
		read image_ram
		export RAM=$((image_ram));
		echo "Ram allocated is "$RAM;		
		if [ $deploy_input -eq 1 ]
		then
			echo " deploying nginx";
			sudo docker run --name web1 -d -p 8081:80 nginx;
			echo " nginx has been deployed and the port address is localhost:8081"; 
		elif [ $deploy_input -eq 2 ]
		then 
			echo " deploying httpd"; 
			sudo docker run --name web2 -d -p 8082:80 httpd;
			echo " http has been deployed and the port address is localhost:8082";
		fi
	;;
	'stop')
		echo " enter 1 to stop nginx and 2 to stop httpd"
		read stop_input
		echo $RAM
		dollars=5;
		dollars_ram=10;
		price_ram=$(($RAM * $dollars_ram));
		if [ $stop_input -eq 1 ]
		then	
			time_nginx=$(sudo docker ps | grep 'nginx' | awk '{print $11}');
			echo " Stopping nginx";
				sudo docker stop web1;
			echo "nginx has been stopped";
			price_nginx=$(($time_nginx * $dollars));
			echo "The image nginx hasbeen up for $time_nginx minutes and price for the service is  $ $price_nginx dollars";
			echo "RAM used is "$RAM "price for the RAM usage is $"$price_ram;	
			echo " Total price you owe is $"$(($price_nginx + $price_ram));
			
			
		elif [ $stop_input -eq 2 ]
		then
			time_httpd=$(sudo docker ps | grep 'httpd' | awk '{print $8}');
                        echo " Stopping httpd";
                                sudo docker stop web2;
                        echo "nginx has been stopped";
                        price_httpd=$(($time_httpd * $dollars));
                        echo "The image httpd hasbeen up for $time_httpd and the price for the service is $ $price_httpd";
			echo "RAM used is "$RAM" GB and price for the RAM usage is $"$price_ram;
                        echo " Total price you owe is $"$(($price_httpd + $price_ram));

		fi
	;;
	'start')
		echo "Enter 1 to start nginx and 2 to start httpd"
		read start_input
		if [ $start_input -eq 1 ]
	        then
	                echo " Starting nginx";
	                sudo docker start web1;
	                echo "nginx has been started"
	        elif [ $start_input -eq 2 ]
	        then
	                echo " Starting httpd";
	                sudo docker start web2;
	                echo "httpd has been started"
	        fi
		;;
	'remove')
		echo "Ensure you stopped the image before you remove \n  Input 1 to remove nginx and 2 to remove httpd"
		read remove_input
		
		if [ $remove_input -eq 1 ]
	        then
	                echo " Removing nginx";
	                sudo docker rm web1;
	                echo "nginx has been removed"
	        elif [ $remove_input -eq 2 ]
	        then
	                echo " Stopping httpd";
	                sudo docker rm  web2;
	                echo "httpd has been removed"
        	fi

	esac
