package edu.umd.lib.wstrack.server



import org.junit.*

import edu.umd.lib.wstrack.server.Current;

import edu.umd.lib.wstrack.server.TrackController;
import grails.converters.JSON
import grails.test.mixin.*

@TestFor(TrackController)
@Mock([History,Current])
class TrackControllerTests {


  def populateValidParams(params) {
    assert params != null
    // TODO: Populate valid properties like...
    //params["name"] = 'someValidName'
    params["timestamp"] = new Date ('2012/01/01')
    params["ip"] = '129.18.12.3'
    params["status"] = 'login'
    params["hostName"] = 'mckeldin-18.umd.edu'
    params["os"] = 'Mac OS X'
    params["userHash"] = 'AEIOU%20X'
    params["guestFlag"] = 'false'
    params["version"] = '1'
  }

  void testIndex() {
    controller.index()
    assert "/track/list" == response.redirectedUrl
  }

  void testList() {

    def model = controller.list()

    assert model.currentInstanceList.size() == 0
    assert model.currentInstanceTotal == 0
  }

  void testCreate() {
    def model = controller.create()

    assert model.currentInstance != null
  }

  void testSave() {
    controller.save()

    assert model.currentInstance != null
    assert view == '/track/create'

    response.reset()

    populateValidParams(params)
    controller.save()

    assert response.redirectedUrl == '/track/show/1'
    assert controller.flash.message != null
    assert Current.count() == 1
  }

  void testShow() {
    controller.show()

    assert flash.message != null
    assert response.redirectedUrl == '/track/list'


    populateValidParams(params)
    def tracking = new Current(params)

    assert tracking.save() != null

    params.id = tracking.id

    def model = controller.show()

    assert model.currentInstance == tracking
  }

  void testTrack() {
    populateValidParams(params)
    controller.track()

    // assert flash.message != null
    // assert  "/track/track"== response.redirectedUrl


    populateValidParams(params)
    def tracking = new Current(params)

    def model = controller.track()

    assert model.currentInstance != null
  }

  void testEdit() {
    controller.edit()

    assert flash.message != null
    assert response.redirectedUrl == '/track/list'


    populateValidParams(params)
    def tracking = new Current(params)

    assert tracking.save() != null

    params.id = tracking.id

    def model = controller.edit()

    assert model.currentInstance == tracking
  }

//  void testUpdate() {
//    controller.update()
//
//    assert flash.message != null
//    assert response.redirectedUrl == '/track/list'
//
//    response.reset()
//
//
//    populateValidParams(params)
//    def tracking = new Current(params)
//
//    assert tracking.save() != null
//
//    // test invalid parameters in update
//    params.id = tracking.id
//    //TODO: add invalid values to params object
//
//    controller.update()
//
//    assert view == "/track/edit"
//    assert model.currentInstance != null
//
//    tracking.clearErrors()
//
//    populateValidParams(params)
//    controller.update()
//
//    assert response.redirectedUrl == "/tracking/show/$tracking.id"
//    assert flash.message != null
//
//    //test outdated version number
//    response.reset()
//    tracking.clearErrors()
//
//    populateValidParams(params)
//    params.id = tracking.id
//    params.version = -1
//    controller.update()
//
//    assert view == "/tracking/edit"
//    assert model.currentInstance != null
//    assert model.currentInstance.errors.getFieldError('version')
//    assert flash.message != null
//  }

  void testDelete() {
    controller.delete()
    assert flash.message != null
    assert response.redirectedUrl == '/track/list'

    response.reset()

    populateValidParams(params)
    def tracking = new Current(params)

    //        assert tracking.save() != null
    //        assert Current.count() == 1

    params.id = tracking.id

    controller.delete()

    assert Current.count() == 0
    assert Current.get(tracking.id) == null
    assert response.redirectedUrl == '/track/list'
  }
}
