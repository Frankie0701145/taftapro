# frozen_string_literal: true

require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest

 def setup

    @professional = professionals(:joe)
    @client  = clients(:jane)
    @request = Request.create( location: "#{@professional.city},#{@professional.country}" , service: @professional.service,
                                professional_id: @professional.id, client_id: @client.id
                              )

    @quotation = Quotation.create( amount: 1000, status: "accepted", client_id: @client.id,
                                   professional_id: @professional.id, request_id: @request.id
                                  )

    @project = Project.create( debit_balance: 1000 , paid: 0 ,status: "started",
                                client_id: @client.id, professional_id: @professional.id,
                                due: "2018-09-06 04:55:44" , request_id: @request.id, quotation_id: @quotation.id
                                  )
 end

 test "the professional should only see the client phone number when the debit is cleared" do

       get professional_login_path
       assert_response :success
       #log the pro in
       post professional_login_path, params: { professional_session: { email: "duckduck@gmail.com" , password: "password" } }
       assert_response :redirect
       follow_redirect!
       assert_template "professionals/show"
       #visit the projects view
       get projects_path
       #assert the project#index view is showned
       assert_template "projects/index"
       #assert that there is project being showed when there is a project
       assert_select "h3", {count:0, text: "There are no projects."}
       #assert that the client phone number is not visible when the debit balance is not cleared
       assert_select "span", {count:0, text: "Client No:"}
       #assert that the project button is not visible when the professional is logged in
       assert_select "a[href=?]", root_path, count:0
       #assert that the client name is visible when the professional is loggged in
       assert_select "a", {count:1, text: @client.full_name}
       #assert that the update button is not visible when the professional is logged in
       assert_select "a[href=?]", edit_project_path( @project.id ), count:0
       # assert that the rate button is not visible when the professional is logged in
       assert_select "a[href=?]", new_review_path(professional_id: @professional.id, project_id: @project.id), count:0
 end

 test "the client should only see the professional phone number when the debit is cleared" do

        get client_login_path
        #log the client in
        post client_login_path, params: { client_session: { email: "googlegoogle@gmail.com" , password: "password" } }
        assert_response :redirect
        follow_redirect!
        assert_template "clients/show"
        #visit the projects view
        get projects_path
        #assert the project#index view is showned
        assert_template "projects/index"
        #assert that there is project being showed when there is a project
        assert_select "h3", {count:0, text: "There are no projects."}
        #assert that the professional phone number is not visible when the debit balance is not cleared
        assert_select "span", {count:0, text: "Professional No:"}
        #assert that the project button is visible when the client is logged in
        assert_select "a[href=?]", root_path, count:1
        #assert that the professional name is visible when the client is loggged in
        assert_select "a", {count:1, text: @professional.full_name}
        #assert that the update button is visible when the client is logged in
        assert_select "a[href=?]", edit_project_path( @project.id ), count:1
        # assert that the rate button is visible when the client is logged in
        assert_select "a[href=?]", new_review_path(professional_id: @professional.id, project_id: @project.id), count:1
 end

end
