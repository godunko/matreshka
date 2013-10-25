with Ada.Strings.Unbounded;
with Ada.Strings.Wide_Wide_Fixed;
with League.Strings;
with Payloads;
--  with ICTSClient.Types;
with ICTS.Forex;
with ICTS.Types;
with CLI.Ws_Utils;
package body Encoder is
   IATS_URI : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("http://www.actforex.com/iats");
   IATS_Prefix : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("iats");
   Bind_Orders_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("BindOrders");

   Session_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Session");

   delphi_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("delphi");

   Kind_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Kind");

   Instrument_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Instrument");

   Rate_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Rate");

   Distance_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Distance");

   Account_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Account");

   Amount_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Amount");

   Application_Data_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("ApplicationData");

   Hedge_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Hedge");

   Trailing_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Trailing");

   Position_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Position");

   Identifier_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Identifier");

   Version_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Version");

   Set_Position_Item_Application_Data_Name 
     : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("SetPositionItemApplicationData");

   Set_Position_Application_Data_Name 
     : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("SetPositionApplicationData");

   Close_Session_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("CloseSession");

   Get_Instruments_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("GetInstruments");

   Modify_Conditional_Order_Base_Name 
     : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("ModifyConditionalOrderBase");

   Condition_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Condition");

   Order_Item_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("OrderItem");

   Get_Positions_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("GetPositions");

   Get_Balance_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("GetBalance");

   Modify_Order_Base_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("ModifyOrderBase");

   Get_Currencies_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("GetCurrencies");

   Reject_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("RejectOrder");

   Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Order");

   Unbind_Orders_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("UnbindOrders");

   Activate_Account_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("ActivateAccount");

   Create_Open_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("CreateOpenOrder");

   Trader_Range_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("TraderRange");

   Deactivate_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("DeactivateOrder");

   Accept_Order_At_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("AcceptOrderAt");

   Cancel_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("CancelOrder");

   Execute_Order_At_Market_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("ExecuteOrderAtMarket");

   Negotiate_Order_At_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("NegotiateOrderAt");

   Create_Close_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("CreateCloseOrder");

   With_Hedge_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("WithHedge");

   Execute_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("ExecuteOrder");

   Execute_Order_At_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("ExecuteOrderAt");

   Get_Orders_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("GetOrders");

   Get_Orders_Links_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("GetOrdersLinks");

   Get_Accounts_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("GetAccounts");

   Accept_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("AcceptOrder");

   Create_Stop_Open_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("CreateStopOpenOrder");

   Create_Stop_Close_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("CreateStopCloseOrder");

   Create_Limit_Open_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("CreateLimitOpenOrder");

   Create_Limit_Close_Order_Name : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("CreateLimitCloseOrder");

   procedure Encode
     (Data : Payloads.Order_Item;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads.Order_Item;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String)
   is
      use Payloads;
      use Ada.Strings.Unbounded;
      --  use ICTSClient.Types;
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Account),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.Start_Element (IATS_URI, Amount_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Amount)));
  --  decimal
      Writer.End_Element (IATS_URI, Amount_Name);

     if Ada
       .Strings
         .Unbounded.Length (Data.Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Name);

   end Encode;
   procedure Encode
     (Data : Payloads.Activate_Condition;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads.Activate_Condition;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String)
   is
      use Payloads;
      use Ada.Strings.Unbounded;
      --  use ICTSClient.Types;
   begin
      Writer.Start_Element (IATS_URI, Name);

     case Data.Activate_Condition.Kind is
       when Payloads.Rate_Case =>
     if Data.Activate_Condition.Rate /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits
        (Data.Activate_Condition.Rate)
    then
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Activate_Condition.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

     end if;
       when Payloads.Trailing_Case =>
     if Data.Activate_Condition.Trailing /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits
        (Data.Activate_Condition.Trailing)
    then
      Writer.Start_Element (IATS_URI, Trailing_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Activate_Condition.Trailing)));
  --  decimal
      Writer.End_Element (IATS_URI, Trailing_Name);

     end if;
     end case;

      Writer.End_Element (IATS_URI, Name);

   end Encode;
   procedure Encode
     (Data : Payloads.Predefined_Condition;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads.Predefined_Condition;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String)
   is
      use Payloads;
      use Ada.Strings.Unbounded;
      --  use ICTSClient.Types;
   begin
      Writer.Start_Element (IATS_URI, Name);

      Encode (Data.Stop,
              Writer,
              League.Strings.To_Universal_String ("Stop"));
      Encode (Data.Limit,
              Writer,
              League.Strings.To_Universal_String ("Limit"));
      Writer.End_Element (IATS_URI, Name);

   end Encode;
   procedure Encode
     (Data : Payloads.Create_Conditional_Open_Order_Base;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads.Create_Conditional_Open_Order_Base;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String)
   is
      use Payloads;
      use Ada.Strings.Unbounded;
      --  use ICTSClient.Types;
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Kind_Name);
      Writer.Characters (League.Strings.From_UTF_8_String (Data.Kind'Img));
  --  string
      Writer.End_Element (IATS_URI, Kind_Name);

      Writer.Start_Element (IATS_URI, Instrument_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Identifier'Wide_Wide_Image
               (Data.Instrument),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Instrument_Name);

     case Data.Create_Conditional_Open_Order_Base.Kind is
       when Payloads.Rate_Case =>
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Create_Conditional_Open_Order_Base.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Create_Conditional_Open_Order_Base.Distance)));
  --  decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .. Natural
       (Data.Order_Item.Length) loop
      Encode (Data.Order_Item.Element (Index),
              Writer,
              League.Strings.To_Universal_String ("OrderItem"));
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Hedge));
  --  boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

      Encode (Data.Predefined,
              Writer,
              League.Strings.To_Universal_String ("Predefined"));
     if Ada
       .Strings
         .Unbounded.Length (Data.Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Name);

   end Encode;
   procedure Encode
     (Data : Payloads.Create_Conditional_Close_Order_Base;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads.Create_Conditional_Close_Order_Base;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String)
   is
      use Payloads;
      use Ada.Strings.Unbounded;
      --  use ICTSClient.Types;
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Position_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Position),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Position_Name);

     case Data.Create_Conditional_Close_Order_Base.Kind is
       when Payloads.Rate_Case =>
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Create_Conditional_Close_Order_Base.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Create_Conditional_Close_Order_Base.Distance)));
  --  decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .. Natural
       (Data.Order_Item.Length) loop
      Encode (Data.Order_Item.Element (Index),
              Writer,
              League.Strings.To_Universal_String ("OrderItem"));
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Hedge));
  --  boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

     if Ada
       .Strings
         .Unbounded.Length (Data.Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Name);

   end Encode;
   procedure Encode
     (Data : ICTS.Forex.Order;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : ICTS.Forex.Order;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String)
   is
      use Payloads;
      use Ada.Strings.Unbounded;
      --  use ICTSClient.Types;
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Identifier_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Identifier),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Identifier_Name);

      Writer.Start_Element (IATS_URI, Version_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Version'Wide_Wide_Image
               (Data.Version),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Version_Name);

      Writer.End_Element (IATS_URI, Name);

   end Encode;
   procedure Encode
     (Data : ICTS.Forex.Position_Group;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : ICTS.Forex.Position_Group;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String)
   is
      use Payloads;
      use Ada.Strings.Unbounded;
      --  use ICTSClient.Types;
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Identifier_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Identifier),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Identifier_Name);

      Writer.Start_Element (IATS_URI, Version_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group_Version'Wide_Wide_Image
               (Data.Version),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Version_Name);

      Writer.End_Element (IATS_URI, Name);

   end Encode;
   procedure Encode
     (Data : ICTS.Forex.Link;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : ICTS.Forex.Link;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String)
   is
      use Payloads;
      use Ada.Strings.Unbounded;
      --  use ICTSClient.Types;
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Identifier_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Link_Identifier'Wide_Wide_Image
               (Data.Identifier),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Identifier_Name);

      Writer.Start_Element (IATS_URI, Version_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Link_Version'Wide_Wide_Image
               (Data.Version),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Version_Name);

      Writer.End_Element (IATS_URI, Name);

   end Encode;

-----------------------------------------------------------------------------
--  Copyright Â© 2013 ACTForex, Inc.
--  All rights reserved.
-----------------------------------------------------------------------------
--  This file is generated by xsd_to_Ada, don't edit it.
-----------------------------------------------------------------------------

   -----------------
   -- Bind_Orders --
   -----------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Bind_Orders_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Bind_Orders_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Bind_Orders_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Bind_Orders
       renames Payloads.Bind_Orders (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Bind_Orders_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

     for Index in 1 .. Natural
       (Data.Bind_Orders_delphi.Length) loop
      Writer.Start_Element (IATS_URI, delphi_Name);
--  SSSSSSSSSSSS
     case Data.Bind_Orders_delphi.Element (Index).Kind is
       when Payloads.Create_Stop_Open_Order_Case =>
      Encode (Data.Bind_Orders_delphi.Element (Index).Create_Stop_Open_Order,
              Writer,
              League.Strings.To_Universal_String ("CreateStopOpenOrder"));
       when Payloads.Create_Limit_Open_Order_Case =>
      Encode (Data.Bind_Orders_delphi.Element (Index).Create_Limit_Open_Order,
              Writer,
              League.Strings.To_Universal_String ("CreateLimitOpenOrder"));
       when Payloads.Create_Stop_Close_Order_Case =>
      Encode (Data.Bind_Orders_delphi.Element (Index).Create_Stop_Close_Order,
              Writer,
              League.Strings.To_Universal_String ("CreateStopCloseOrder"));
       when Payloads.Create_Limit_Close_Order_Case =>
      Encode 
        (Data.Bind_Orders_delphi.Element (Index).Create_Limit_Close_Order,
              Writer,
              League.Strings.To_Universal_String ("CreateLimitCloseOrder"));
       when Payloads.Conditional_Order_Case =>
      Encode (Data.Bind_Orders_delphi.Element (Index).Conditional_Order,
              Writer,
              League.Strings.To_Universal_String ("ConditionalOrder"));
     end case;

      Writer.End_Element (IATS_URI, delphi_Name);  --  EEEEEEEEE

     end loop;

      Writer.End_Element (IATS_URI, Bind_Orders_Name);
   end Encode;

   ----------------------------------------
   -- Set_Position_Item_Application_Data --
   ----------------------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Set_Position_Item_Application_Data_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Set_Position_Item_Application_Data_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Set_Position_Item_Application_Data_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Set_Position_Item_Application_Data
       renames Payloads.Set_Position_Item_Application_Data (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Set_Position_Item_Application_Data_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Position,
              Writer,
              League.Strings.To_Universal_String ("Position"));
      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Account),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

      Writer.End_Element (IATS_URI, Set_Position_Item_Application_Data_Name);
   end Encode;

   -----------------------------------
   -- Set_Position_Application_Data --
   -----------------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Set_Position_Application_Data_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Set_Position_Application_Data_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Set_Position_Application_Data_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Set_Position_Application_Data
       renames Payloads.Set_Position_Application_Data (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Set_Position_Application_Data_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Position,
              Writer,
              League.Strings.To_Universal_String ("Position"));
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

      Writer.End_Element (IATS_URI, Set_Position_Application_Data_Name);
   end Encode;

   -------------------
   -- Close_Session --
   -------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Close_Session_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Close_Session_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Close_Session_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Close_Session
       renames Payloads.Close_Session (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Close_Session_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Close_Session_Name);
   end Encode;

   ---------------------
   -- Get_Instruments --
   ---------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Get_Instruments_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Get_Instruments_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Get_Instruments_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Instruments
       renames Payloads.Get_Instruments (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Get_Instruments_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Instruments_Name);
   end Encode;

   -----------------------------------
   -- Modify_Conditional_Order_Base --
   -----------------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Modify_Conditional_Order_Base_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Modify_Conditional_Order_Base_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Modify_Conditional_Order_Base_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Modify_Conditional_Order_Base
       renames Payloads.Modify_Conditional_Order_Base (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Modify_Conditional_Order_Base_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Order,
              Writer,
              League.Strings.To_Universal_String ("Order"));
      Writer.Start_Element (IATS_URI, Condition_Name);
--  SSSSSSSSSSSS
     case Data.Modify_Conditional_Order_Base_Condition.Kind is
       when Payloads.Rate_Case =>
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Modify_Conditional_Order_Base_Condition.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data.Modify_Conditional_Order_Base_Condition.Distance)));
  --  decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

      Writer.End_Element (IATS_URI, Condition_Name);  --  EEEEEEEEE

     for Index in 1 .. Natural
       (Data.Modify_Conditional_Order_Base_Order_Item.Length) loop
      Writer.Start_Element (IATS_URI, Order_Item_Name);
--  SSSSSSSSSSSS
      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data
                 .Modify_Conditional_Order_Base_Order_Item
                   .Element (Index).Account),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

     if Data
       .Modify_Conditional_Order_Base_Order_Item
         .Element (Index).Amount /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits
        (Data.Modify_Conditional_Order_Base_Order_Item.Element (Index).Amount)
    then
      Writer.Start_Element (IATS_URI, Amount_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Modify_Conditional_Order_Base_Order_Item
                   .Element (Index).Amount)));
  --  decimal
      Writer.End_Element (IATS_URI, Amount_Name);

     end if;
     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Modify_Conditional_Order_Base_Order_Item
                 .Element (Index).Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data
               .Modify_Conditional_Order_Base_Order_Item
                 .Element (Index).Application_Data.Application_Data)));
  --  YYYYYYYYYYYstring
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Order_Item_Name);  --  EEEEEEEEE

     end loop;

     if Ada
       .Strings
         .Unbounded.Length (Data.Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Modify_Conditional_Order_Base_Name);
   end Encode;

   -------------------
   -- Get_Positions --
   -------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Get_Positions_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Get_Positions_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Get_Positions_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Positions
       renames Payloads.Get_Positions (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Get_Positions_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Positions_Name);
   end Encode;

   -----------------
   -- Get_Balance --
   -----------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Get_Balance_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Get_Balance_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Get_Balance_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Balance
       renames Payloads.Get_Balance (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Get_Balance_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Account),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.End_Element (IATS_URI, Get_Balance_Name);
   end Encode;

   -----------------------
   -- Modify_Order_Base --
   -----------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Modify_Order_Base_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Modify_Order_Base_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Modify_Order_Base_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Modify_Order_Base
       renames Payloads.Modify_Order_Base (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Modify_Order_Base_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Order,
              Writer,
              League.Strings.To_Universal_String ("Order"));
     for Index in 1 .. Natural
       (Data.Modify_Order_Base_Order_Item.Length) loop
      Writer.Start_Element (IATS_URI, Order_Item_Name);
--  SSSSSSSSSSSS
      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Modify_Order_Base_Order_Item.Element (Index).Account),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data
               .Modify_Order_Base_Order_Item
                 .Element (Index).Application_Data)));
  --  XXXXXXXXXstring
      Writer.End_Element (IATS_URI, Application_Data_Name);

      Writer.End_Element (IATS_URI, Order_Item_Name);  --  EEEEEEEEE

     end loop;

     if Ada
       .Strings
         .Unbounded.Length (Data.Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Modify_Order_Base_Name);
   end Encode;

   --------------------
   -- Get_Currencies --
   --------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Get_Currencies_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Get_Currencies_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Get_Currencies_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Currencies
       renames Payloads.Get_Currencies (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Get_Currencies_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Currencies_Name);
   end Encode;

   ------------------
   -- Reject_Order --
   ------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Reject_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Reject_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Reject_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Reject_Order
       renames Payloads.Reject_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Reject_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Reject_Order_Name);
   end Encode;

   -------------------
   -- Unbind_Orders --
   -------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Unbind_Orders_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Unbind_Orders_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Unbind_Orders_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Unbind_Orders
       renames Payloads.Unbind_Orders (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Unbind_Orders_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Orders_Link,
              Writer,
              League.Strings.To_Universal_String ("OrdersLink"));
      Writer.End_Element (IATS_URI, Unbind_Orders_Name);
   end Encode;

   ----------------------
   -- Activate_Account --
   ----------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Activate_Account_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Activate_Account_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Activate_Account_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Activate_Account
       renames Payloads.Activate_Account (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Activate_Account_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Account),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.End_Element (IATS_URI, Activate_Account_Name);
   end Encode;

   -----------------------
   -- Create_Open_Order --
   -----------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Create_Open_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Create_Open_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Create_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Create_Open_Order
       renames Payloads.Create_Open_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Create_Open_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Kind_Name);
      Writer.Characters (League.Strings.From_UTF_8_String (Data.Kind'Img));
  --  string
      Writer.End_Element (IATS_URI, Kind_Name);

      Writer.Start_Element (IATS_URI, Instrument_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Identifier'Wide_Wide_Image
               (Data.Instrument),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Instrument_Name);

     for Index in 1 .. Natural
       (Data.Order_Item.Length) loop
      Encode (Data.Order_Item.Element (Index),
              Writer,
              League.Strings.To_Universal_String ("OrderItem"));
     end loop;

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

     if Data.Trader_Range /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits
        (Data.Trader_Range)
    then
      Writer.Start_Element (IATS_URI, Trader_Range_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Trader_Range)));
  --  decimal
      Writer.End_Element (IATS_URI, Trader_Range_Name);

     end if;
      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Hedge));
  --  boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

      Encode (Data.Predefined,
              Writer,
              League.Strings.To_Universal_String ("Predefined"));
     if Ada
       .Strings
         .Unbounded.Length (Data.Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Create_Open_Order_Name);
   end Encode;

   ----------------------
   -- Deactivate_Order --
   ----------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Deactivate_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Deactivate_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Deactivate_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Deactivate_Order
       renames Payloads.Deactivate_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Deactivate_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Deactivate_Order_Name);
   end Encode;

   ---------------------
   -- Accept_Order_At --
   ---------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Accept_Order_At_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Accept_Order_At_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Accept_Order_At_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Accept_Order_At
       renames Payloads.Accept_Order_At (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Accept_Order_At_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

     if Data.Trader_Range /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits
        (Data.Trader_Range)
    then
      Writer.Start_Element (IATS_URI, Trader_Range_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Trader_Range)));
  --  decimal
      Writer.End_Element (IATS_URI, Trader_Range_Name);

     end if;
      Writer.End_Element (IATS_URI, Accept_Order_At_Name);
   end Encode;

   ------------------
   -- Cancel_Order --
   ------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Cancel_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Cancel_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Cancel_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Cancel_Order
       renames Payloads.Cancel_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Cancel_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Cancel_Order_Name);
   end Encode;

   -----------------------------
   -- Execute_Order_At_Market --
   -----------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Execute_Order_At_Market_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Execute_Order_At_Market_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Execute_Order_At_Market_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Execute_Order_At_Market
       renames Payloads.Execute_Order_At_Market (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Execute_Order_At_Market_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Execute_Order_At_Market_Name);
   end Encode;

   ------------------------
   -- Negotiate_Order_At --
   ------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Negotiate_Order_At_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Negotiate_Order_At_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Negotiate_Order_At_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Negotiate_Order_At
       renames Payloads.Negotiate_Order_At (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Negotiate_Order_At_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

      Writer.End_Element (IATS_URI, Negotiate_Order_At_Name);
   end Encode;

   ------------------------
   -- Create_Close_Order --
   ------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Create_Close_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Create_Close_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Create_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Create_Close_Order
       renames Payloads.Create_Close_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Create_Close_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Position_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Position),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Position_Name);

     for Index in 1 .. Natural
       (Data.Order_Item.Length) loop
      Encode (Data.Order_Item.Element (Index),
              Writer,
              League.Strings.To_Universal_String ("OrderItem"));
     end loop;

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

     if Data.Trader_Range /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits
        (Data.Trader_Range)
    then
      Writer.Start_Element (IATS_URI, Trader_Range_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Trader_Range)));
  --  decimal
      Writer.End_Element (IATS_URI, Trader_Range_Name);

     end if;
      Writer.Start_Element (IATS_URI, With_Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.With_Hedge));
  --  boolean
      Writer.End_Element (IATS_URI, With_Hedge_Name);

     if Ada
       .Strings
         .Unbounded.Length (Data.Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Create_Close_Order_Name);
   end Encode;

   -------------------
   -- Execute_Order --
   -------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Execute_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Execute_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Execute_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Execute_Order
       renames Payloads.Execute_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Execute_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Execute_Order_Name);
   end Encode;

   ----------------------
   -- Execute_Order_At --
   ----------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Execute_Order_At_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Execute_Order_At_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Execute_Order_At_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Execute_Order_At
       renames Payloads.Execute_Order_At (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Execute_Order_At_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

      Writer.End_Element (IATS_URI, Execute_Order_At_Name);
   end Encode;

   ----------------
   -- Get_Orders --
   ----------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Get_Orders_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Get_Orders_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Get_Orders_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Orders
       renames Payloads.Get_Orders (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Get_Orders_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Orders_Name);
   end Encode;

   ----------------------
   -- Get_Orders_Links --
   ----------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Get_Orders_Links_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Get_Orders_Links_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Get_Orders_Links_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Orders_Links
       renames Payloads.Get_Orders_Links (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Get_Orders_Links_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Orders_Links_Name);
   end Encode;

   ------------------
   -- Get_Accounts --
   ------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Get_Accounts_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Get_Accounts_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Get_Accounts_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Accounts
       renames Payloads.Get_Accounts (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Get_Accounts_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Accounts_Name);
   end Encode;

   ------------------
   -- Accept_Order --
   ------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Accept_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Accept_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Accept_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Payloads;
     use Ada.Strings.Unbounded;

     Data : Payloads.Accept_Order
       renames Payloads.Accept_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);
      Writer.Start_Element (IATS_URI, Accept_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Accept_Order_Name);
   end Encode;

   ----------------------------
   -- Create_Stop_Open_Order --
   ----------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Create_Stop_Open_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Create_Stop_Open_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Create_Stop_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;
     use Payloads;

     Data : Payloads.Create_Stop_Open_Order
       renames Payloads.Create_Stop_Open_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Stop_Open_Order_Name);

      Writer.Start_Element (IATS_URI, Kind_Name);
      Writer
        .Characters 
          (League
            .Strings
              .From_UTF_8_String 
                (Data.Create_Conditional_Open_Order_Base.Kind'Img));
  --  string
      Writer.End_Element (IATS_URI, Kind_Name);

      Writer.Start_Element (IATS_URI, Instrument_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Identifier'Wide_Wide_Image
               (Data.Create_Conditional_Open_Order_Base.Instrument),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Instrument_Name);

     case Data
       .Create_Conditional_Open_Order_Base
         .Create_Conditional_Open_Order_Base.Kind is
       when Payloads.Rate_Case =>
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Open_Order_Base
                   .Create_Conditional_Open_Order_Base.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Open_Order_Base
                   .Create_Conditional_Open_Order_Base.Distance)));
  --  decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .. Natural
       (Data.Create_Conditional_Open_Order_Base.Order_Item.Length) loop
      Encode 
        (Data.Create_Conditional_Open_Order_Base.Order_Item.Element (Index),
              Writer,
              League.Strings.To_Universal_String ("OrderItem"));
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Create_Conditional_Open_Order_Base.Hedge));
  --  boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

      Encode (Data.Create_Conditional_Open_Order_Base.Predefined,
              Writer,
              League.Strings.To_Universal_String ("Predefined"));
     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Create_Conditional_Open_Order_Base
                 .Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data
               .Create_Conditional_Open_Order_Base
                 .Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Create_Stop_Open_Order_Name);
   end Encode;

   -----------------------------
   -- Create_Stop_Close_Order --
   -----------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Create_Stop_Close_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Create_Stop_Close_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Create_Stop_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;
     use Payloads;

     Data : Payloads.Create_Stop_Close_Order
       renames Payloads.Create_Stop_Close_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Stop_Close_Order_Name);

      Writer.Start_Element (IATS_URI, Position_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Create_Conditional_Close_Order_Base.Position),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Position_Name);

     case Data
       .Create_Conditional_Close_Order_Base
         .Create_Conditional_Close_Order_Base.Kind is
       when Payloads.Rate_Case =>
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Close_Order_Base
                   .Create_Conditional_Close_Order_Base.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Close_Order_Base
                   .Create_Conditional_Close_Order_Base.Distance)));
  --  decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .. Natural
       (Data.Create_Conditional_Close_Order_Base.Order_Item.Length) loop
      Encode 
        (Data.Create_Conditional_Close_Order_Base.Order_Item.Element (Index),
              Writer,
              League.Strings.To_Universal_String ("OrderItem"));
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Create_Conditional_Close_Order_Base.Hedge));
  --  boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Create_Conditional_Close_Order_Base
                 .Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data
               .Create_Conditional_Close_Order_Base
                 .Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Create_Stop_Close_Order_Name);
   end Encode;

   -----------------------------
   -- Create_Limit_Open_Order --
   -----------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Create_Limit_Open_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Create_Limit_Open_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Create_Limit_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;
     use Payloads;

     Data : Payloads.Create_Limit_Open_Order
       renames Payloads.Create_Limit_Open_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Limit_Open_Order_Name);

      Writer.Start_Element (IATS_URI, Kind_Name);
      Writer
        .Characters 
          (League
            .Strings
              .From_UTF_8_String 
                (Data.Create_Conditional_Open_Order_Base.Kind'Img));
  --  string
      Writer.End_Element (IATS_URI, Kind_Name);

      Writer.Start_Element (IATS_URI, Instrument_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Identifier'Wide_Wide_Image
               (Data.Create_Conditional_Open_Order_Base.Instrument),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Instrument_Name);

     case Data
       .Create_Conditional_Open_Order_Base
         .Create_Conditional_Open_Order_Base.Kind is
       when Payloads.Rate_Case =>
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Open_Order_Base
                   .Create_Conditional_Open_Order_Base.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Open_Order_Base
                   .Create_Conditional_Open_Order_Base.Distance)));
  --  decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .. Natural
       (Data.Create_Conditional_Open_Order_Base.Order_Item.Length) loop
      Encode 
        (Data.Create_Conditional_Open_Order_Base.Order_Item.Element (Index),
              Writer,
              League.Strings.To_Universal_String ("OrderItem"));
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Create_Conditional_Open_Order_Base.Hedge));
  --  boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

      Encode (Data.Create_Conditional_Open_Order_Base.Predefined,
              Writer,
              League.Strings.To_Universal_String ("Predefined"));
     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Create_Conditional_Open_Order_Base
                 .Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data
               .Create_Conditional_Open_Order_Base
                 .Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Create_Limit_Open_Order_Name);
   end Encode;

   ------------------------------
   -- Create_Limit_Close_Order --
   ------------------------------

   overriding function Create
     (Dummy : not null access Boolean)
      return Create_Limit_Close_Order_Encoder
   is
     pragma Unreferenced (Dummy);
   begin
     return X : Create_Limit_Close_Order_Encoder;
   end Create;

   overriding procedure Encode
     (Self    : Create_Limit_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;
     use Payloads;

     Data : Payloads.Create_Limit_Close_Order
       renames Payloads.Create_Limit_Close_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Limit_Close_Order_Name);

      Writer.Start_Element (IATS_URI, Position_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Create_Conditional_Close_Order_Base.Position),
            Ada.Strings.Both)));
  --  positive_Integer
      Writer.End_Element (IATS_URI, Position_Name);

     case Data
       .Create_Conditional_Close_Order_Base
         .Create_Conditional_Close_Order_Base.Kind is
       when Payloads.Rate_Case =>
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Close_Order_Base
                   .Create_Conditional_Close_Order_Base.Rate)));
  --  decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Close_Order_Base
                   .Create_Conditional_Close_Order_Base.Distance)));
  --  decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .. Natural
       (Data.Create_Conditional_Close_Order_Base.Order_Item.Length) loop
      Encode 
        (Data.Create_Conditional_Close_Order_Base.Order_Item.Element (Index),
              Writer,
              League.Strings.To_Universal_String ("OrderItem"));
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Create_Conditional_Close_Order_Base.Hedge));
  --  boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Create_Conditional_Close_Order_Base
                 .Application_Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data
               .Create_Conditional_Close_Order_Base
                 .Application_Data.Application_Data)));
  --  string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters (Data.Session);
  --  string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Create_Limit_Close_Order_Name);
   end Encode;

end Encoder;
