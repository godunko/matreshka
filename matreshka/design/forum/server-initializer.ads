with Spikedog.Generic_Application_Initializer;

with Server.Initializers;

package Server.Initializer is
  new Spikedog.Generic_Application_Initializer
       (Server.Initializers.Server_Initializer);
