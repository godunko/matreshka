with WebAPI.HTML.Windows;

package WebAPI.HTML.Globals is

   Window : constant WebAPI.HTML.Windows.Window_Access
     with Import     => True,
          Convention => JavaScript;

end WebAPI.HTML.Globals;
