class UserController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.create
	end
end