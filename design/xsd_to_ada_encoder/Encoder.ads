package Encoder is
   type Bind_Orders_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Bind_Orders_Encoder;

   overriding procedure Encode
     (Self    : Bind_Orders_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Set_Position_Item_Application_Data_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Set_Position_Item_Application_Data_Encoder;

   overriding procedure Encode
     (Self    : Set_Position_Item_Application_Data_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Set_Position_Application_Data_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Set_Position_Application_Data_Encoder;

   overriding procedure Encode
     (Self    : Set_Position_Application_Data_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Close_Session_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Close_Session_Encoder;

   overriding procedure Encode
     (Self    : Close_Session_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Get_Instruments_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Get_Instruments_Encoder;

   overriding procedure Encode
     (Self    : Get_Instruments_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Modify_Conditional_Order_Base_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Modify_Conditional_Order_Base_Encoder;

   overriding procedure Encode
     (Self    : Modify_Conditional_Order_Base_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Get_Positions_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Get_Positions_Encoder;

   overriding procedure Encode
     (Self    : Get_Positions_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Get_Balance_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Get_Balance_Encoder;

   overriding procedure Encode
     (Self    : Get_Balance_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Modify_Order_Base_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Modify_Order_Base_Encoder;

   overriding procedure Encode
     (Self    : Modify_Order_Base_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Get_Currencies_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Get_Currencies_Encoder;

   overriding procedure Encode
     (Self    : Get_Currencies_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Reject_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Reject_Order_Encoder;

   overriding procedure Encode
     (Self    : Reject_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Unbind_Orders_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Unbind_Orders_Encoder;

   overriding procedure Encode
     (Self    : Unbind_Orders_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Activate_Account_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Activate_Account_Encoder;

   overriding procedure Encode
     (Self    : Activate_Account_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Create_Open_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Create_Open_Order_Encoder;

   overriding procedure Encode
     (Self    : Create_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Deactivate_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Deactivate_Order_Encoder;

   overriding procedure Encode
     (Self    : Deactivate_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Accept_Order_At_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Accept_Order_At_Encoder;

   overriding procedure Encode
     (Self    : Accept_Order_At_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Cancel_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Cancel_Order_Encoder;

   overriding procedure Encode
     (Self    : Cancel_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Execute_Order_At_Market_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Execute_Order_At_Market_Encoder;

   overriding procedure Encode
     (Self    : Execute_Order_At_Market_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Negotiate_Order_At_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Negotiate_Order_At_Encoder;

   overriding procedure Encode
     (Self    : Negotiate_Order_At_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Create_Close_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Create_Close_Order_Encoder;

   overriding procedure Encode
     (Self    : Create_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Execute_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Execute_Order_Encoder;

   overriding procedure Encode
     (Self    : Execute_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Execute_Order_At_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Execute_Order_At_Encoder;

   overriding procedure Encode
     (Self    : Execute_Order_At_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Get_Orders_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Get_Orders_Encoder;

   overriding procedure Encode
     (Self    : Get_Orders_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Get_Orders_Links_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Get_Orders_Links_Encoder;

   overriding procedure Encode
     (Self    : Get_Orders_Links_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Get_Accounts_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Get_Accounts_Encoder;

   overriding procedure Encode
     (Self    : Get_Accounts_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Accept_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Accept_Order_Encoder;

   overriding procedure Encode
     (Self    : Accept_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Modify_Close_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Modify_Close_Order_Encoder;

   overriding procedure Encode
     (Self    : Modify_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Modify_Limit_Close_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Modify_Limit_Close_Order_Encoder;

   overriding procedure Encode
     (Self    : Modify_Limit_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Create_Stop_Open_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Create_Stop_Open_Order_Encoder;

   overriding procedure Encode
     (Self    : Create_Stop_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Modify_Limit_Open_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Modify_Limit_Open_Order_Encoder;

   overriding procedure Encode
     (Self    : Modify_Limit_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Modify_Stop_Open_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Modify_Stop_Open_Order_Encoder;

   overriding procedure Encode
     (Self    : Modify_Stop_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Modify_Open_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Modify_Open_Order_Encoder;

   overriding procedure Encode
     (Self    : Modify_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Create_Stop_Close_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Create_Stop_Close_Order_Encoder;

   overriding procedure Encode
     (Self    : Create_Stop_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Modify_Stop_Close_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Modify_Stop_Close_Order_Encoder;

   overriding procedure Encode
     (Self    : Modify_Stop_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Create_Limit_Open_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Create_Limit_Open_Order_Encoder;

   overriding procedure Encode
     (Self    : Create_Limit_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);

   type Create_Limit_Close_Order_Encoder is
   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder
   with null record;

   overriding function Create
     (Dummy : not null access Boolean) return 
      Create_Limit_Close_Order_Encoder;

   overriding procedure Encode
     (Self    : Create_Limit_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);


end Encoder;
