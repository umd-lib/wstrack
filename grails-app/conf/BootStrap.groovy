import edu.umd.lib.wstrack.server.Current;

class BootStrap {

    def init = { servletContext ->
        if(!Current.count()) {
          new Current(ip: "2.2.2.2")
        }
    }
    def destroy = {
    }
}
