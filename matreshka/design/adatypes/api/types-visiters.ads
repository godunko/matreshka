with Types.Accesses.Objects;
with Types.Accesses.Subprograms;
with Types.Arrays;
with Types.Discretes.Enumerations;
with Types.Discretes.Integers;
with Types.Discriminanteds.Protecteds;
with Types.Discriminanteds.Records.Taggeds;
with Types.Discriminanteds.Records;
with Types.Discriminanteds.Tasks;
with Types.Taggeds.Interfaces;

package Types.Visiters is

   pragma Preelaborate;

   type Type_Visiter is limited interface;

   not overriding procedure Enumeration_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Discretes.Enumerations.Enumeration_Type_Access)
      is abstract;

   not overriding procedure Boolean_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Discretes.Enumerations.Enumeration_Type_Access)
      is abstract;

   not overriding procedure Character_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Discretes.Enumerations.Enumeration_Type_Access)
      is abstract;

   not overriding procedure Signed_Integer_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Discretes.Integers.Integer_Type_Access)
      is abstract;

   not overriding procedure Modular_Integer_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Discretes.Integers.Integer_Type_Access)
      is abstract;

--     not overriding procedure Floating_Point_Type
--      (Self  : not null access Type_Visiter;
--    Value : not null Types.Reals.Floating_Points.Floating_Point_Type_Access)
--        is abstract;
--
--     not overriding procedure Fixed_Point_Type
--      (Self  : not null access Type_Visiter;
--       Value : not null Types.Reals.Fixed_Points.Fixed_Point_Type_Access)
--        is abstract;
--
--     not overriding procedure Decimal_Fixed_Point_Type
--      (Self  : not null access Type_Visiter;
--       Value : not null Types.Reals.Decimal_Fixed_Points
--                          .Decimal_Fixed_Point_Type_Access)
--        is abstract;

   not overriding procedure Object_Access_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Accesses.Objects.Object_Access_Type_Access)
      is abstract;

   not overriding procedure Subprogram_Access_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Accesses.Subprograms.Subprogram_Access_Type_Access)
      is abstract;

   not overriding procedure Array_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Arrays.Array_Type_Access)
      is abstract;

   not overriding procedure String_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Arrays.Array_Type_Access)
      is abstract;

   not overriding procedure Record_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Discriminanteds.Records.Record_Type_Access)
      is abstract;

   not overriding procedure Tagged_Record_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Discriminanteds.Records.Taggeds
                        .Tagged_Record_Type_Access)
      is abstract;

   not overriding procedure Task_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Discriminanteds.Tasks.Task_Type_Access)
      is abstract;

   not overriding procedure Protected_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Discriminanteds.Protecteds.Protected_Type_Access)
      is abstract;

   not overriding procedure Interface_Type
    (Self  : not null access Type_Visiter;
     Value : not null Types.Taggeds.Interfaces.Interface_Type_Access)
      is abstract;

end Types.Visiters;
