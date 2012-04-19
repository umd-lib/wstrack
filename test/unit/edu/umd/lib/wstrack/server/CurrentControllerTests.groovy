package edu.umd.lib.wstrack.server



import org.junit.*
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
        assert "/current/list" == response.redirectedUrl
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
        assert view == '/current/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/current/show/1'
        assert controller.flash.message != null
        assert Current.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/current/list'


        populateValidParams(params)
        def current = new Current(params)

        assert current.save() != null

        params.id = current.id

        def model = controller.show()

        assert model.currentInstance == current
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/current/list'


        populateValidParams(params)
        def current = new Current(params)

        assert current.save() != null

        params.id = current.id

        def model = controller.edit()

        assert model.currentInstance == current
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/current/list'

        response.reset()


        populateValidParams(params)
        def current = new Current(params)

        assert current.save() != null

        // test invalid parameters in update
        params.id = current.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/current/edit"
        assert model.currentInstance != null

        current.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/current/show/$current.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        current.clearErrors()

        populateValidParams(params)
        params.id = current.id
        params.version = -1
        controller.update()

        assert view == "/current/edit"
        assert model.currentInstance != null
        assert model.currentInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/current/list'

        response.reset()

        populateValidParams(params)
        def current = new Current(params)

        assert current.save() != null
        assert Current.count() == 1

        params.id = current.id

        controller.delete()

        assert Current.count() == 0
        assert Current.get(current.id) == null
        assert response.redirectedUrl == '/current/list'
    }
}
