// Auto-generated. Do not edit!

// (in-package roboy_cognition_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class OrderIceCreamFeedback {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.finished_scoops = null;
      this.status_message = null;
    }
    else {
      if (initObj.hasOwnProperty('finished_scoops')) {
        this.finished_scoops = initObj.finished_scoops
      }
      else {
        this.finished_scoops = [];
      }
      if (initObj.hasOwnProperty('status_message')) {
        this.status_message = initObj.status_message
      }
      else {
        this.status_message = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OrderIceCreamFeedback
    // Serialize message field [finished_scoops]
    bufferOffset = _arraySerializer.bool(obj.finished_scoops, buffer, bufferOffset, null);
    // Serialize message field [status_message]
    bufferOffset = _serializer.string(obj.status_message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OrderIceCreamFeedback
    let len;
    let data = new OrderIceCreamFeedback(null);
    // Deserialize message field [finished_scoops]
    data.finished_scoops = _arrayDeserializer.bool(buffer, bufferOffset, null)
    // Deserialize message field [status_message]
    data.status_message = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.finished_scoops.length;
    length += object.status_message.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'roboy_cognition_msgs/OrderIceCreamFeedback';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '84132ae12f784d01b8d8c41f0054500b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
    # for every finished scoop, feedback is supplied in form of another boolean that is appended to finished_scoops
    # status messages can be "more time" 
    bool[] finished_scoops 
    string status_message
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new OrderIceCreamFeedback(null);
    if (msg.finished_scoops !== undefined) {
      resolved.finished_scoops = msg.finished_scoops;
    }
    else {
      resolved.finished_scoops = []
    }

    if (msg.status_message !== undefined) {
      resolved.status_message = msg.status_message;
    }
    else {
      resolved.status_message = ''
    }

    return resolved;
    }
};

module.exports = OrderIceCreamFeedback;