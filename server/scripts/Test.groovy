import edu.umd.lib.wstrack.server.*

println "loading sample data"

Map params = [:]

for (i in 1..1000) {
  params.computerName = 'computerName' + (i % 10)
  params.os = 'os' + (i % 3)
  params.status = ((i % 3 in [1,2]) ? 'login' : 'logout')
  params .userName = ((i % 15 == 0) ? 'libguest' : '') + 'userName' + (i % 20)

  TrackController.trackX(params)
}

println Current.count()
println Current.listOs()

println History.count()
println History.listOs()
