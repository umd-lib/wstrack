package umd.edu.lib.wstrack



import org.junit.*

import edu.umd.lib.wstrack.server.Current;

import umd.edu.lib.wstrack.server.CurrentController;
import grails.test.mixin.*

@TestFor(CurrentController)
@Mock(Current)
class CurrentControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/tracking/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.trackingInstanceList.size() == 0
        assert model.trackingInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.trackingInstance != null
    }

    void testSave() {
        controller.save()

        assert model.trackingInstance != null
        assert view == '/tracking/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/tracking/show/1'
        assert controller.flash.message != null
        assert Current.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/tracking/list'


        populateValidParams(params)
        def tracking = new Current(params)

        assert tracking.save() != null

        params.id = tracking.id

        def model = controller.show()

        assert model.trackingInstance == tracking
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/tracking/list'


        populateValidParams(params)
        def tracking = new Current(params)

        assert tracking.save() != null

        params.id = tracking.id

        def model = controller.edit()

        assert model.trackingInstance == tracking
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/tracking/list'

        response.reset()


        populateValidParams(params)
        def tracking = new Current(params)

        assert tracking.save() != null

        // test invalid parameters in update
        params.id = tracking.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/tracking/edit"
        assert model.trackingInstance != null

        tracking.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/tracking/show/$tracking.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        tracking.clearErrors()

        populateValidParams(params)
        params.id = tracking.id
        params.version = -1
        controller.update()

        assert view == "/tracking/edit"
        assert model.trackingInstance != null
        assert model.trackingInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/tracking/list'

        response.reset()

        populateValidParams(params)
        def tracking = new Current(params)

        assert tracking.save() != null
        assert Current.count() == 1

        params.id = tracking.id

        controller.delete()

        assert Current.count() == 0
        assert Current.get(tracking.id) == null
        assert response.redirectedUrl == '/tracking/list'
    }
}
