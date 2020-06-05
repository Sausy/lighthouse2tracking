;; Auto-generated. Do not edit!


(when (boundp 'roboy_simulation_msgs::BodyPart)
  (if (not (find-package "ROBOY_SIMULATION_MSGS"))
    (make-package "ROBOY_SIMULATION_MSGS"))
  (shadow 'BodyPart (find-package "ROBOY_SIMULATION_MSGS")))
(unless (find-package "ROBOY_SIMULATION_MSGS::BODYPART")
  (make-package "ROBOY_SIMULATION_MSGS::BODYPART"))

(in-package "ROS")
;;//! \htmlinclude BodyPart.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass roboy_simulation_msgs::BodyPart
  :super ros::object
  :slots (_id _link_id _position ))

(defmethod roboy_simulation_msgs::BodyPart
  (:init
   (&key
    ((:id __id) 0)
    ((:link_id __link_id) 0)
    ((:position __position) (instance geometry_msgs::Point :init))
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _link_id (round __link_id))
   (setq _position __position)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:link_id
   (&optional __link_id)
   (if __link_id (setq _link_id __link_id)) _link_id)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; int32 _link_id
    4
    ;; geometry_msgs/Point _position
    (send _position :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; int32 _link_id
       (write-long _link_id s)
     ;; geometry_msgs/Point _position
       (send _position :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _link_id
     (setq _link_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;;
   self)
  )

(setf (get roboy_simulation_msgs::BodyPart :md5sum-) "4f76706811fad63028450434bc8c147d")
(setf (get roboy_simulation_msgs::BodyPart :datatype-) "roboy_simulation_msgs/BodyPart")
(setf (get roboy_simulation_msgs::BodyPart :definition-)
      "int32 id
int32 link_id
geometry_msgs/Point position

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :roboy_simulation_msgs/BodyPart "4f76706811fad63028450434bc8c147d")


