--  This package should be linked with svn_subr library.

package SVN.Error is

   pragma Preelaborate;

   procedure svn_error_clear (error : svn_error_t_access)
     with Import     => True,
          Convention => C,
          Link_Name  => "svn_error_clear";

end SVN.Error;
