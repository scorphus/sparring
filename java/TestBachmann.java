import java.net.InetAddress;
import java.net.UnknownHostException;

import java.io.IOException;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

import at.bachmann.sys.common.module.*;
import at.bachmann.sys.common.net.*;
import at.bachmann.sys.common.svi.*;
import at.bachmann.sys.common.util.*;

class TestBachmann {
    public static void main(String[] argv) throws UnknownHostException, M1ProtocolException, IOException, M1Exception, InterruptedException {
        InetAddress addr = InetAddress.getByName("10.14.2.41");
        M1RemoteController controller = new M1RemoteController(addr, "M1", M1Target.TCP, 1000);
        M1Credentials cred = new M1Credentials("tmhadmin", "1234");
        controller.setCredentials(cred);

        while(true) {
            ClientConnection conn = controller.createClientConnection();
            //SwModule mod = controller.getModuleFactory().createSwModule("RES", 2);
            ResModule mod = controller.getModuleFactory().createResModule();
            //SviVariable time_us = SviVariableFactory.createSviVariable("RES/Time_us", SviVariable.SVI_F_UINT32, SviVariable.SVI_F_INOUT, 4, false);
            SviVariable time_us = null;
            //SviVariable time_us = SviVariableFactory.createSviVariable("Time_us", SviVariable.SVI_F_UINT32, SviVariable.SVI_F_OUT, 4, false);
            controller.connect();
            Vector<SwModule> modules = mod.getSwModules();
            //System.out.println(modules);
            SwModule resmod = null;
            for (SwModule modh : modules) {
                String name = modh.getName();
                if (name.equals("RES")) {
                    resmod = modh;
                    break;
                }
                System.out.println(modh.getName());
            }

            if (resmod == null) {
                System.out.println("Couldnt find module.");
                System.exit(1);
            }

            Vector<SviVariable> vars = resmod.getVariables();

            for (SviVariable var : vars) {
                String name = var.getName();

                System.out.println("[" + name + "]");
                if (name.equals("RES/Time_us")) {
                    time_us = var;
                    break;
                }
            }

            if ( time_us == null ) {
                System.out.println("Not found");
                System.exit(2);
            }

            while(true) {
                resmod.getSviValue(time_us);
                System.out.println(time_us.toString());
                TimeUnit.SECONDS.sleep(1);
            }
        }
    }
}