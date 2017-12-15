with Spikedog.Generic_Application_Initializer;

with Initializers;

package Initializer is
  new Spikedog.Generic_Application_Initializer
       (Initializers.Server_Initializer);
