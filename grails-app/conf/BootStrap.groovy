import umd.edu.lib.wstrack.Tracking;

class BootStrap {

    def init = { servletContext ->
        if(!Tracking.count()) {
          new Tracking(ip: "2.2.2.2")
        }
    }
    def destroy = {
    }
}
