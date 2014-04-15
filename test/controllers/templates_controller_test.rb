class TemplatesControllerTest < ActionController::TestCase

    test "should not get templates without login" do
        get_template_actions.each do |action|
            get action
            assert_redirected_to signin_url
        end
    end

    test "should get templates when loggedin" do
        session[:user_id]=users(:michi).id
        (get_template_actions - ["index"]).each do |action|
            get action
            assert_response :success
            assert_template layout: nil
        end
    end


    test "should get index when loggedin" do
        session[:user_id]=users(:michi).id
        get :index
        assert_response :success
        assert_template layout: "layouts/application"
    end

    def get_template_actions
        TemplatesController.action_methods & TemplatesController.instance_methods(false).map{|i| i.to_s}
    end

end
