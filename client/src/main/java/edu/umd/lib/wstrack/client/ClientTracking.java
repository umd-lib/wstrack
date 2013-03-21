package edu.umd.lib.wstrack.client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import org.apache.log4j.Appender;
import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.varia.NullAppender;

public class ClientTracking {

  public static final Logger log = Logger.getLogger(ClientTracking.class);

  /**
   * @param args
   */

  /*
   * @Javadoc - Main method to retrieve the workstation tracking details.
   */
  public static void main(String[] args) throws MalformedURLException,
      IOException {

    // configure logging
    boolean debug = System.getProperty("wstrack.debug", "false").equals("true");

    if (debug) {
      // debug logging to the console
      Appender console = new ConsoleAppender(new PatternLayout(
          "%d [%-5p]: (%c)%n%m%n%n"));
      Logger.getRootLogger().addAppender(console);
      Logger.getRootLogger().setLevel(Level.DEBUG);
    } else {
      Logger.getRootLogger().addAppender(new NullAppender());
    }

    try {

      String env = System.getProperty("wstrack.env", "local");

      // gather params
      String username = System.getProperty("wstrack.username");
      if (username == null) {
        throw new Exception("wstrack.username property is required");
      }

      String computerName = System.getProperty("wstrack.computerName");
      if (computerName == null) {
        throw new Exception("wstrack.computerName property is required");
      }

      String status = System.getProperty("wstrack.status");
      if (status == null) {
        throw new Exception("wstrack.status property is required");
      }

      String os = System.getProperty("wstrack.os");
      if (os == null) {
        throw new Exception("wstrack.os property is required");
      }

      track(env, username, computerName, status, os);

    } catch (Exception e) {
      log.error("Error in ClientTracking", e);
    }
  }

  /*
   * @Javadoc - Submit track event
   */
  public static void track(String env, String username, String computerName,
      String status, String os) throws MalformedURLException, IOException {

    // map environment to baseUrl
    String baseUrl = null;

    if (env.equals("prod")) {
      baseUrl = "https://www.lib.umd.edu/wstrack/track";

    } else if (env.equals("stage")) {
      baseUrl = "https://wwwstage.lib.umd.edu/wstrack/track";

    } else if (env.equals("dev")) {
      baseUrl = "https://wwwdev.lib.umd.edu/wstrack/track";

    } else {
      baseUrl = "http://localhost:8080/wstrack-server/track";
    }
    log.debug("base url: " + baseUrl);
    log.debug("username: " + username);
    log.debug("computerName: " + computerName);
    log.debug("status: " + status);
    log.debug("os: " + os);

    // build tracking url
    StringBuffer sb = new StringBuffer(baseUrl);
    sb.append("/" + URLEncoder.encode(computerName, "UTF-8"));
    sb.append("/" + status);
    sb.append("/" + URLEncoder.encode(os, "UTF-8"));
    sb.append("/" + URLEncoder.encode(username, "UTF-8"));

    // open the connection
    URL url = new URL(sb.toString());
    URLConnection conn = url.openConnection();

    // Get the response
    BufferedReader rd = new BufferedReader(new InputStreamReader(
        conn.getInputStream()));
    String line;
    while ((line = rd.readLine()) != null) {
      log.debug("response: " + line);
    }

    rd.close();
  }

}
