package Encoder is

   procedure Encode
     (Data : ICTSClient.Types.Order_Item;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : ICTSClient.Types.Order_Item;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Account),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.Start_Element (IATS_URI, Amount_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Amount)));  -- decimal
      Writer.End_Element (IATS_URI, Amount_Name);

     if Ada.Strings.Unbounded.Length (Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : Payloads_2.Activate_Condition;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads_2.Activate_Condition;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

     case Data.Activate_Condition.Kind is
       when Payloads.Rate_Case =>
     if Data.Rate /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Rate)
    then
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

     end if;
       when Payloads.Trailing_Case =>
     if Data.Trailing /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Trailing)
    then
      Writer.Start_Element (IATS_URI, Trailing_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Trailing)));  -- decimal
      Writer.End_Element (IATS_URI, Trailing_Name);

     end if;
     end case;

      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : ICTSClient.Types.Predefined_Condition;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : ICTSClient.Types.Predefined_Condition;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Encode (Data.Stop
              Writer,
              "Stop");
      Encode (Data.Limit
              Writer,
              "Limit");
      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : ICTSClient.Types.Entry_Order;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : ICTSClient.Types.Entry_Order;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Kind_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Kind)));  -- string
      Writer.End_Element (IATS_URI, Kind_Name);

      Writer.Start_Element (IATS_URI, Instrument_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Identifier'Wide_Wide_Image
               (Data.Instrument),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Instrument_Name);

     case Data.Create_Conditional_Open_Order_Base.Kind is
       when Payloads.Rate_Case =>
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Distance)));  -- decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .. Integer (Data.Order_Item.Length) loop
      Encode (Data.Order_Item.Element (Index),
              Writer,
              "Order_Item");
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Hedge));  -- boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

      Encode (Data.Predefined
              Writer,
              "Predefined");
     if Ada.Strings.Unbounded.Length (Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : ICTSClient.Types.Stop_Limit_Order;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : ICTSClient.Types.Stop_Limit_Order;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Position_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Position),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Position_Name);

     case Data.Create_Conditional_Close_Order_Base.Kind is
       when Payloads.Rate_Case =>
      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Distance)));  -- decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .. Integer (Data.Order_Item.Length) loop
      Encode (Data.Order_Item.Element (Index),
              Writer,
              "Order_Item");
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Hedge));  -- boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

     if Ada.Strings.Unbounded.Length (Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));  -- string
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
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Identifier_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Identifier),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Identifier_Name);

      Writer.Start_Element (IATS_URI, Version_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Version'Wide_Wide_Image
               (Data.Version),
            Ada.Strings.Both)));  -- positive_Integer
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
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Identifier_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Identifier),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Identifier_Name);

      Writer.Start_Element (IATS_URI, Version_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group_Version'Wide_Wide_Image
               (Data.Version),
            Ada.Strings.Both)));  -- positive_Integer
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
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Identifier_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Link_Identifier'Wide_Wide_Image
               (Data.Identifier),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Identifier_Name);

      Writer.Start_Element (IATS_URI, Version_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Link_Version'Wide_Wide_Image
               (Data.Version),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Version_Name);

      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : Payloads_2.Instrument;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads_2.Instrument;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Identifier_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Identifier'Wide_Wide_Image
               (Data.Identifier),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Identifier_Name);

      Writer.Start_Element (IATS_URI, Version_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Version'Wide_Wide_Image
               (Data.Version),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Version_Name);

      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : Payloads_2.Time_Interval;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads_2.Time_Interval;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, From_Name);
      Writer.Characters (IATS_URI, Data.From);  -- time
      Writer.End_Element (IATS_URI, From_Name);

      Writer.Start_Element (IATS_URI, To_Name);
      Writer.Characters (IATS_URI, Data.To);  -- time
      Writer.End_Element (IATS_URI, To_Name);

      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : ICTSClient.Types.Money;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : ICTSClient.Types.Money;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Currency_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Currency_Identifier'Wide_Wide_Image
               (Data.Currency),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Currency_Name);

      Writer.Start_Element (IATS_URI, Amount_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Amount)));  -- decimal
      Writer.End_Element (IATS_URI, Amount_Name);

      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : Payloads_2.Base_Margin_Requirement;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads_2.Base_Margin_Requirement;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Kind_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Kind)));  -- string
      Writer.End_Element (IATS_URI, Kind_Name);

     if Data.Percent /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Percent)
    then
      Writer.Start_Element (IATS_URI, Percent_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Percent)));  -- decimal
      Writer.End_Element (IATS_URI, Percent_Name);

     end if;
      Encode (Data.Fixed
              Writer,
              "Fixed");
      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : Payloads_2.Margin_Requirement_Level;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads_2.Margin_Requirement_Level;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

     if Data.Limit /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Limit)
    then
      Writer.Start_Element (IATS_URI, Limit_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Limit)));  -- decimal
      Writer.End_Element (IATS_URI, Limit_Name);

     end if;
     if Data.Coefficient /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Coefficient)
    then
      Writer.Start_Element (IATS_URI, Coefficient_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Coefficient)));  -- decimal
      Writer.End_Element (IATS_URI, Coefficient_Name);

     end if;
      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : Payloads_2.Margin_Requirement;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads_2.Margin_Requirement;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Encode (Data.Base
              Writer,
              "Base");
     if Data.Intraday_Discount_Coefficient /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Intraday_Discount_Coefficient)
    then
      Writer.Start_Element (IATS_URI, Intraday_Discount_Coefficient_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Intraday_Discount_Coefficient)));  -- decimal
      Writer.End_Element (IATS_URI, Intraday_Discount_Coefficient_Name);

     end if;
      Encode (Data.Limit1
              Writer,
              "Limit1");
      Encode (Data.Limit2
              Writer,
              "Limit2");
      Writer.End_Element (IATS_URI, Name);

   end Encode;

   procedure Encode
     (Data : Payloads_2.Margin_Call_Execution;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String);

   procedure Encode
     (Data : Payloads_2.Margin_Call_Execution;
      Writer : in out XML.SAX.Writers.SAX_Writer'Class;
      Name : League.Strings.Universal_String) is
   begin
      Writer.Start_Element (IATS_URI, Name);

      Writer.Start_Element (IATS_URI, Mode_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Mode)));  -- string
      Writer.End_Element (IATS_URI, Mode_Name);

     if Data.Level /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Level)
    then
      Writer.Start_Element (IATS_URI, Level_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Level)));  -- decimal
      Writer.End_Element (IATS_URI, Level_Name);

     end if;
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

   overriding procedure Encode
     (Self    : Bind_Orders_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Bind_Orders
       renames Payloads.Bind_Orders (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Bind_Orders_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

     for J in 1 .. Data.Bind_Orders_delphi.Lenght loop
     case Data.Bind_Orders_delphi.Kind is
       when Payloads.Create_Stop_Open_Order_Case =>
      Encode (Data.Bind_Orders_delphi.Create_Stop_Open_Order.Element (Index),
              Writer,
              "Create_Stop_Open_Order");
       when Payloads.Create_Limit_Open_Order_Case =>
      Encode (Data.Bind_Orders_delphi.Create_Limit_Open_Order.Element (Index),
              Writer,
              "Create_Limit_Open_Order");
       when Payloads.Create_Stop_Close_Order_Case =>
      Encode (Data.Bind_Orders_delphi.Create_Stop_Close_Order.Element (Index),
              Writer,
              "Create_Stop_Close_Order");
       when Payloads.Create_Limit_Close_Order_Case =>
      Encode 
        (Data.Bind_Orders_delphi.Create_Limit_Close_Order.Element (Index),
              Writer,
              "Create_Limit_Close_Order");
       when Payloads.Conditional_Order_Case =>
      Encode (Data.Bind_Orders_delphi.Conditional_Order.Element (Index),
              Writer,
              "Conditional_Order");
     end case;

     end loop;

      Writer.End_Element (IATS_URI, Bind_Orders_Name);
   end Encode;

   ----------------------------------------
   -- Set_Position_Item_Application_Data --
   ----------------------------------------

   overriding procedure Encode
     (Self    : Set_Position_Item_Application_Data_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Set_Position_Item_Application_Data
       renames Payloads.Set_Position_Item_Application_Data (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Set_Position_Item_Application_Data_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Position
              Writer,
              "Position");
      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Account),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

      Writer.End_Element (IATS_URI, Set_Position_Item_Application_Data_Name);
   end Encode;

   -----------------------------------
   -- Set_Position_Application_Data --
   -----------------------------------

   overriding procedure Encode
     (Self    : Set_Position_Application_Data_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Set_Position_Application_Data
       renames Payloads.Set_Position_Application_Data (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Set_Position_Application_Data_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Position
              Writer,
              "Position");
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

      Writer.End_Element (IATS_URI, Set_Position_Application_Data_Name);
   end Encode;

   -------------------
   -- Close_Session --
   -------------------

   overriding procedure Encode
     (Self    : Close_Session_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Close_Session
       renames Payloads.Close_Session (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Close_Session_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Close_Session_Name);
   end Encode;

   ---------------------
   -- Get_Instruments --
   ---------------------

   overriding procedure Encode
     (Self    : Get_Instruments_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Instruments
       renames Payloads.Get_Instruments (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Get_Instruments_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Instruments_Name);
   end Encode;

   -----------------------------------
   -- Modify_Conditional_Order_Base --
   -----------------------------------

   overriding procedure Encode
     (Self    : Modify_Conditional_Order_Base_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Modify_Conditional_Order_Base
       renames Payloads.Modify_Conditional_Order_Base (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Modify_Conditional_Order_Base_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Order
              Writer,
              "Order");
     case Data.Modify_Conditional_Order_Base_Condition.Kind is
       when Payloads.Rate_Case =>
     if Data
       .Modify_Conditional_Order_Base_Condition.Rate /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Rate)
    then
      Writer.Start_Element (IATS_URI, Condition_Name);

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Modify_Conditional_Order_Base_Condition.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

      Writer.End_Element (IATS_URI, Condition_Name);
     end if;
       when Payloads.Distance_Case =>
     if Data
       .Modify_Conditional_Order_Base_Condition
         .Distance /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Distance)
    then
      Writer.Start_Element (IATS_URI, Condition_Name);

      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data.Modify_Conditional_Order_Base_Condition.Distance)));  -- decimal
      Writer.End_Element (IATS_URI, Distance_Name);

      Writer.End_Element (IATS_URI, Condition_Name);
     end if;
     end case;

     for J in 1 .. Data.Modify_Conditional_Order_Base_Order_Item.Lenght loop
      Writer.Start_Element (IATS_URI, Order_Item_Name);

      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data
                 .Modify_Conditional_Order_Base_Order_Item
                   .Element (Index).Account),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.Ends_Element (IATS_URI, OrderItem_Name);

     if Data
       .Modify_Conditional_Order_Base_Order_Item
         .Amount /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Amount)
    then
      Writer.Start_Element (IATS_URI, Order_Item_Name);

      Writer.Start_Element (IATS_URI, Amount_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Modify_Conditional_Order_Base_Order_Item
                   .Element (Index).Amount)));  -- decimal
      Writer.End_Element (IATS_URI, Amount_Name);

      Writer.End_Element (IATS_URI, Order_Item_Name);
     end if;
     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Modify_Conditional_Order_Base_Order_Item
                 .Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Order_Item_Name);

      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data
               .Modify_Conditional_Order_Base_Order_Item
                 .Element (Index).Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

      Writer.End_Element (IATS_URI, Order_Item_Name);

     end if;
     end loop;

     if Ada.Strings.Unbounded.Length (Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Modify_Conditional_Order_Base_Name);
   end Encode;

   -------------------
   -- Get_Positions --
   -------------------

   overriding procedure Encode
     (Self    : Get_Positions_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Positions
       renames Payloads.Get_Positions (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Get_Positions_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Positions_Name);
   end Encode;

   -----------------
   -- Get_Balance --
   -----------------

   overriding procedure Encode
     (Self    : Get_Balance_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Balance
       renames Payloads.Get_Balance (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Get_Balance_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Account),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.End_Element (IATS_URI, Get_Balance_Name);
   end Encode;

   -----------------------
   -- Modify_Order_Base --
   -----------------------

   overriding procedure Encode
     (Self    : Modify_Order_Base_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Modify_Order_Base
       renames Payloads.Modify_Order_Base (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Modify_Order_Base_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Order
              Writer,
              "Order");
     for J in 1 .. Data.Modify_Order_Base_Order_Item.Lenght loop
      Writer.Start_Element (IATS_URI, Order_Item_Name);

      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Modify_Order_Base_Order_Item.Element (Index).Account),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.Ends_Element (IATS_URI, OrderItem_Name);

     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data.Modify_Order_Base_Order_Item.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Order_Item_Name);

      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data
               .Modify_Order_Base_Order_Item
                 .Element (Index).Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

      Writer.End_Element (IATS_URI, Order_Item_Name);

     end if;
     end loop;

     if Ada.Strings.Unbounded.Length (Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Modify_Order_Base_Name);
   end Encode;

   --------------------
   -- Get_Currencies --
   --------------------

   overriding procedure Encode
     (Self    : Get_Currencies_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Currencies
       renames Payloads.Get_Currencies (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Get_Currencies_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Currencies_Name);
   end Encode;

   ------------------
   -- Reject_Order --
   ------------------

   overriding procedure Encode
     (Self    : Reject_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Reject_Order
       renames Payloads.Reject_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Reject_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Reject_Order_Name);
   end Encode;

   -------------------
   -- Unbind_Orders --
   -------------------

   overriding procedure Encode
     (Self    : Unbind_Orders_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Unbind_Orders
       renames Payloads.Unbind_Orders (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Unbind_Orders_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Encode (Data.Orders_Link
              Writer,
              "Orders_Link");
      Writer.End_Element (IATS_URI, Unbind_Orders_Name);
   end Encode;

   ----------------------
   -- Activate_Account --
   ----------------------

   overriding procedure Encode
     (Self    : Activate_Account_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Activate_Account
       renames Payloads.Activate_Account (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Activate_Account_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Account_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Account_Identifier'Wide_Wide_Image
               (Data.Account),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Account_Name);

      Writer.End_Element (IATS_URI, Activate_Account_Name);
   end Encode;

   -----------------------
   -- Create_Open_Order --
   -----------------------

   overriding procedure Encode
     (Self    : Create_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Create_Open_Order
       renames Payloads.Create_Open_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Open_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Kind_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Kind)));  -- string
      Writer.End_Element (IATS_URI, Kind_Name);

      Writer.Start_Element (IATS_URI, Instrument_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Identifier'Wide_Wide_Image
               (Data.Instrument),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Instrument_Name);

     for Index in 1 .. Integer (Data.Order_Item.Length) loop
      Encode (Data.Order_Item.Element (Index),
              Writer,
              "Order_Item");
     end loop;

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

     if Data.Trader_Range /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Trader_Range)
    then
      Writer.Start_Element (IATS_URI, Trader_Range_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Trader_Range)));  -- decimal
      Writer.End_Element (IATS_URI, Trader_Range_Name);

     end if;
      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Hedge));  -- boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

      Encode (Data.Predefined
              Writer,
              "Predefined");
     if Ada.Strings.Unbounded.Length (Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Create_Open_Order_Name);
   end Encode;

   ----------------------
   -- Deactivate_Order --
   ----------------------

   overriding procedure Encode
     (Self    : Deactivate_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Deactivate_Order
       renames Payloads.Deactivate_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Deactivate_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Deactivate_Order_Name);
   end Encode;

   ---------------------
   -- Accept_Order_At --
   ---------------------

   overriding procedure Encode
     (Self    : Accept_Order_At_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Accept_Order_At
       renames Payloads.Accept_Order_At (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Accept_Order_At_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

     if Data.Trader_Range /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Trader_Range)
    then
      Writer.Start_Element (IATS_URI, Trader_Range_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Trader_Range)));  -- decimal
      Writer.End_Element (IATS_URI, Trader_Range_Name);

     end if;
      Writer.End_Element (IATS_URI, Accept_Order_At_Name);
   end Encode;

   ------------------
   -- Cancel_Order --
   ------------------

   overriding procedure Encode
     (Self    : Cancel_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Cancel_Order
       renames Payloads.Cancel_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Cancel_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Cancel_Order_Name);
   end Encode;

   -----------------------------
   -- Execute_Order_At_Market --
   -----------------------------

   overriding procedure Encode
     (Self    : Execute_Order_At_Market_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Execute_Order_At_Market
       renames Payloads.Execute_Order_At_Market (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Execute_Order_At_Market_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Execute_Order_At_Market_Name);
   end Encode;

   ------------------------
   -- Negotiate_Order_At --
   ------------------------

   overriding procedure Encode
     (Self    : Negotiate_Order_At_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Negotiate_Order_At
       renames Payloads.Negotiate_Order_At (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Negotiate_Order_At_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

      Writer.End_Element (IATS_URI, Negotiate_Order_At_Name);
   end Encode;

   ------------------------
   -- Create_Close_Order --
   ------------------------

   overriding procedure Encode
     (Self    : Create_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Create_Close_Order
       renames Payloads.Create_Close_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Close_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Position_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Position),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Position_Name);

     for Index in 1 .. Integer (Data.Order_Item.Length) loop
      Encode (Data.Order_Item.Element (Index),
              Writer,
              "Order_Item");
     end loop;

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

     if Data.Trader_Range /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Trader_Range)
    then
      Writer.Start_Element (IATS_URI, Trader_Range_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Trader_Range)));  -- decimal
      Writer.End_Element (IATS_URI, Trader_Range_Name);

     end if;
      Writer.Start_Element (IATS_URI, With_Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.With_Hedge));  -- boolean
      Writer.End_Element (IATS_URI, With_Hedge_Name);

     if Ada.Strings.Unbounded.Length (Data.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Create_Close_Order_Name);
   end Encode;

   -------------------
   -- Execute_Order --
   -------------------

   overriding procedure Encode
     (Self    : Execute_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Execute_Order
       renames Payloads.Execute_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Execute_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Execute_Order_Name);
   end Encode;

   ----------------------
   -- Execute_Order_At --
   ----------------------

   overriding procedure Encode
     (Self    : Execute_Order_At_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Execute_Order_At
       renames Payloads.Execute_Order_At (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Execute_Order_At_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.Start_Element (IATS_URI, Rate_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

      Writer.End_Element (IATS_URI, Execute_Order_At_Name);
   end Encode;

   ----------------
   -- Get_Orders --
   ----------------

   overriding procedure Encode
     (Self    : Get_Orders_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Orders
       renames Payloads.Get_Orders (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Get_Orders_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Orders_Name);
   end Encode;

   ----------------------
   -- Get_Orders_Links --
   ----------------------

   overriding procedure Encode
     (Self    : Get_Orders_Links_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Orders_Links
       renames Payloads.Get_Orders_Links (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Get_Orders_Links_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Orders_Links_Name);
   end Encode;

   ------------------
   -- Get_Accounts --
   ------------------

   overriding procedure Encode
     (Self    : Get_Accounts_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Get_Accounts
       renames Payloads.Get_Accounts (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Get_Accounts_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.End_Element (IATS_URI, Get_Accounts_Name);
   end Encode;

   ------------------
   -- Accept_Order --
   ------------------

   overriding procedure Encode
     (Self    : Accept_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Accept_Order
       renames Payloads.Accept_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Accept_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Order_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Order_Identifier'Wide_Wide_Image
               (Data.Order),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Order_Name);

      Writer.End_Element (IATS_URI, Accept_Order_Name);
   end Encode;

   ----------------------------
   -- Instrument_Information --
   ----------------------------

   overriding procedure Encode
     (Self    : Instrument_Updated_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Instrument_Updated
       renames Payloads.Instrument_Updated (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Instrument_Updated_Name);

      Encode (Data.Instrument
              Writer,
              "Instrument");
      Writer.Start_Element (IATS_URI, Contract_Currency_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Currency_Identifier'Wide_Wide_Image
               (Data.Contract_Currency),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Contract_Currency_Name);

      Writer.Start_Element (IATS_URI, Opposite_Currency_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Currency_Identifier'Wide_Wide_Image
               (Data.Opposite_Currency),
            Ada.Strings.Both)));  -- positive_Integer
      Writer.End_Element (IATS_URI, Opposite_Currency_Name);

      Writer.Start_Element (IATS_URI, Contract_Size_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Contract_Size)));  -- decimal
      Writer.End_Element (IATS_URI, Contract_Size_Name);

      Writer.Start_Element (IATS_URI, Is_Active_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Is_Active));  -- boolean
      Writer.End_Element (IATS_URI, Is_Active_Name);

      Writer.Start_Element (IATS_URI, Rate_Expiration_Name);
      Writer.Characters (IATS_URI, Data.Rate_Expiration);  -- duration
      Writer.End_Element (IATS_URI, Rate_Expiration_Name);

     if Data.Max_Order_Volume /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Max_Order_Volume)
    then
      Writer.Start_Element (IATS_URI, Max_Order_Volume_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Max_Order_Volume)));  -- decimal
      Writer.End_Element (IATS_URI, Max_Order_Volume_Name);

     end if;
     for Index in 1 .. Integer (Data.Trading_Interval.Length) loop
      Encode (Data.Trading_Interval.Element (Index),
              Writer,
              "Trading_Interval");
     end loop;

     if Data.Slippage_Range /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Slippage_Range)
    then
      Writer.Start_Element (IATS_URI, Slippage_Range_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Slippage_Range)));  -- decimal
      Writer.End_Element (IATS_URI, Slippage_Range_Name);

     end if;
     if Data.Dealer_Range /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Dealer_Range)
    then
      Writer.Start_Element (IATS_URI, Dealer_Range_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Dealer_Range)));  -- decimal
      Writer.End_Element (IATS_URI, Dealer_Range_Name);

     end if;
     if Data.Acceptable_Range /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Acceptable_Range)
    then
      Writer.Start_Element (IATS_URI, Acceptable_Range_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Acceptable_Range)));  -- decimal
      Writer.End_Element (IATS_URI, Acceptable_Range_Name);

     end if;
     if Data.Negotiation_Volume /= Payloads.Null_Decimal
      and then CLI.Ws_Utils.Is_Digits (Data.Negotiation_Volume)
    then
      Writer.Start_Element (IATS_URI, Negotiation_Volume_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String (Data.Negotiation_Volume)));  -- decimal
      Writer.End_Element (IATS_URI, Negotiation_Volume_Name);

     end if;
      Encode (Data.Margin_Requirement
              Writer,
              "Margin_Requirement");
      Encode (Data.Margin_Call_Execution
              Writer,
              "Margin_Call_Execution");
      Writer.End_Element (IATS_URI, Instrument_Updated_Name);
   end Encode;

   -------------------------
   -- Add_Separator ERROR --
   -------------------------

   overriding procedure Encode
     (Self    : Create_Stop_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Create_Stop_Open_Order
       renames Payloads.Create_Stop_Open_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Stop_Open_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Kind_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Create_Conditional_Open_Order_Base.Kind)));  -- string
      Writer.End_Element (IATS_URI, Kind_Name);

      Writer.Start_Element (IATS_URI, Instrument_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Identifier'Wide_Wide_Image
               (Data.Create_Conditional_Open_Order_Base.Instrument),
            Ada.Strings.Both)));  -- positive_Integer
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
                   .Create_Conditional_Open_Order_Base.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Open_Order_Base
                   .Create_Conditional_Open_Order_Base.Distance)));  -- decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .
       . Integer 
         (Data.Create_Conditional_Open_Order_Base.Order_Item.Length) loop
      Encode 
        (Data.Create_Conditional_Open_Order_Base.Order_Item.Element (Index),
              Writer,
              "Order_Item");
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Create_Conditional_Open_Order_Base.Hedge));  -- boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

      Encode (Data.Create_Conditional_Open_Order_Base.Predefined
              Writer,
              "Predefined");
     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Create_Conditional_Open_Order_Base.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Create_Conditional_Open_Order_Base.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Create_Stop_Open_Order_Name);
   end Encode;

   -------------------------
   -- Add_Separator ERROR --
   -------------------------

   overriding procedure Encode
     (Self    : Create_Stop_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Create_Stop_Close_Order
       renames Payloads.Create_Stop_Close_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Stop_Close_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Position_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Create_Conditional_Close_Order_Base.Position),
            Ada.Strings.Both)));  -- positive_Integer
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
                   .Create_Conditional_Close_Order_Base.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Close_Order_Base
                   .Create_Conditional_Close_Order_Base.Distance)));  -- decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .
       . Integer 
         (Data.Create_Conditional_Close_Order_Base.Order_Item.Length) loop
      Encode 
        (Data.Create_Conditional_Close_Order_Base.Order_Item.Element (Index),
              Writer,
              "Order_Item");
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Create_Conditional_Close_Order_Base.Hedge));  -- boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Create_Conditional_Close_Order_Base.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Create_Conditional_Close_Order_Base.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Create_Stop_Close_Order_Name);
   end Encode;

   -------------------------
   -- Add_Separator ERROR --
   -------------------------

   overriding procedure Encode
     (Self    : Create_Limit_Open_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Create_Limit_Open_Order
       renames Payloads.Create_Limit_Open_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Limit_Open_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Kind_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Create_Conditional_Open_Order_Base.Kind)));  -- string
      Writer.End_Element (IATS_URI, Kind_Name);

      Writer.Start_Element (IATS_URI, Instrument_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Instrument_Identifier'Wide_Wide_Image
               (Data.Create_Conditional_Open_Order_Base.Instrument),
            Ada.Strings.Both)));  -- positive_Integer
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
                   .Create_Conditional_Open_Order_Base.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Open_Order_Base
                   .Create_Conditional_Open_Order_Base.Distance)));  -- decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .
       . Integer 
         (Data.Create_Conditional_Open_Order_Base.Order_Item.Length) loop
      Encode 
        (Data.Create_Conditional_Open_Order_Base.Order_Item.Element (Index),
              Writer,
              "Order_Item");
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Create_Conditional_Open_Order_Base.Hedge));  -- boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

      Encode (Data.Create_Conditional_Open_Order_Base.Predefined
              Writer,
              "Predefined");
     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Create_Conditional_Open_Order_Base.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Create_Conditional_Open_Order_Base.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Create_Limit_Open_Order_Name);
   end Encode;

   -------------------------
   -- Add_Separator ERROR --
   -------------------------

   overriding procedure Encode
     (Self    : Create_Limit_Close_Order_Encoder;
      Message : Web_Services.SOAP.Payloads.Abstract_SOAP_Payload'Class;
      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)
   is
     pragma Unreferenced (Self);

     use Ada.Strings.Unbounded;

     Data : Payloads.Create_Limit_Close_Order
       renames Payloads.Create_Limit_Close_Order (Message);

   begin
      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);

      Writer.Start_Element (IATS_URI, Create_Limit_Close_Order_Name);

      Writer.Start_Element (IATS_URI, Session_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Session)));  -- string
      Writer.End_Element (IATS_URI, Session_Name);

      Writer.Start_Element (IATS_URI, Position_Name);
      Writer.Characters
        (League.Strings.To_Universal_String
           (Ada.Strings.Wide_Wide_Fixed.Trim
              (ICTS.Types.Position_Group'Wide_Wide_Image
               (Data.Create_Conditional_Close_Order_Base.Position),
            Ada.Strings.Both)));  -- positive_Integer
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
                   .Create_Conditional_Close_Order_Base.Rate)));  -- decimal
      Writer.End_Element (IATS_URI, Rate_Name);

       when Payloads.Distance_Case =>
      Writer.Start_Element (IATS_URI, Distance_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
             (To_String 
               (Data
                 .Create_Conditional_Close_Order_Base
                   .Create_Conditional_Close_Order_Base.Distance)));  -- decimal
      Writer.End_Element (IATS_URI, Distance_Name);

     end case;

     for Index in 1 .
       . Integer 
         (Data.Create_Conditional_Close_Order_Base.Order_Item.Length) loop
      Encode 
        (Data.Create_Conditional_Close_Order_Base.Order_Item.Element (Index),
              Writer,
              "Order_Item");
     end loop;

      Writer.Start_Element (IATS_URI, Hedge_Name);
      Writer.Characters (CLI.Ws_Utils.Image
        (Data.Create_Conditional_Close_Order_Base.Hedge));  -- boolean
      Writer.End_Element (IATS_URI, Hedge_Name);

     if Ada
       .Strings
         .Unbounded
           .Length 
             (Data
               .Create_Conditional_Close_Order_Base.Application_Data) /= 0 then
      Writer.Start_Element (IATS_URI, Application_Data_Name);
      Writer.Characters
        (League.Strings.From_UTF_8_String
          (Ada.Strings.Unbounded.To_String
             (Data.Create_Conditional_Close_Order_Base.Application_Data)));  -- string
      Writer.End_Element (IATS_URI, Application_Data_Name);

     end if;
      Writer.End_Element (IATS_URI, Create_Limit_Close_Order_Name);
   end Encode;

end Encoder;
