;; Auto-generated. Do not edit!


(when (boundp 'roboy_simulation_msgs::Point32Array)
  (if (not (find-package "ROBOY_SIMULATION_MSGS"))
    (make-package "ROBOY_SIMULATION_MSGS"))
  (shadow 'Point32Array (find-package "ROBOY_SIMULATION_MSGS")))
(unless (find-package "ROBOY_SIMULATION_MSGS::POINT32ARRAY")
  (make-package "ROBOY_SIMULATION_MSGS::POINT32ARRAY"))

(in-package "ROS")
;;//! \htmlinclude Point32Array.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass roboy_simulation_msgs::Point32Array
  :super ros::object
  :slots (_person _id _point ))

(defmethod roboy_simulation_msgs::Point32Array
  (:init
   (&key
    ((:person __person) 0)
    ((:id __id) (make-array 0 :initial-element 0 :element-type :integer))
    ((:point __point) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point32 :init) r)) r))
    )
   (send-super :init)
   (setq _person (round __person))
   (setq _id __id)
   (setq _point __point)
   self)
  (:person
   (&optional __person)
   (if __person (setq _person __person)) _person)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:point
   (&rest __point)
   (if (keywordp (car __point))
       (send* _point __point)
     (progn
       (if __point (setq _point (car __point)))
       _point)))
  (:serialization-length
   ()
   (+
    ;; int32 _person
    4
    ;; int32[] _id
    (* 4    (length _id)) 4
    ;; geometry_msgs/Point32[] _point
    (apply #'+ (send-all _point :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _person
       (write-long _person s)
     ;; int32[] _id
     (write-long (length _id) s)
     (dotimes (i (length _id))
       (write-long (elt _id i) s)
       )
     ;; geometry_msgs/Point32[] _point
     (write-long (length _point) s)
     (dolist (elem _point)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _person
     (setq _person (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32[] _id
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _id (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _id i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; geometry_msgs/Point32[] _point
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _point (let (r) (dotimes (i n) (push (instance geometry_msgs::Point32 :init) r)) r))
     (dolist (elem- _point)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get roboy_simulation_msgs::Point32Array :md5sum-) "4a7498411af35f4561c6514bb8224f4d")
(setf (get roboy_simulation_msgs::Point32Array :datatype-) "roboy_simulation_msgs/Point32Array")
(setf (get roboy_simulation_msgs::Point32Array :definition-)
      "int32 person
int32[] id
geometry_msgs/Point32[] point
================================================================================
MSG: geometry_msgs/Point32
# This contains the position of a point in free space(with 32 bits of precision).
# It is recommeded to use Point wherever possible instead of Point32.  
# 
# This recommendation is to promote interoperability.  
#
# This message is designed to take up less space when sending
# lots of points at once, as in the case of a PointCloud.  

float32 x
float32 y
float32 z
")



(provide :roboy_simulation_msgs/Point32Array "4a7498411af35f4561c6514bb8224f4d")


