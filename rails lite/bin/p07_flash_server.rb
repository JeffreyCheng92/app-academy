require 'active_support'
require 'active_support/core_ext'
require 'webrick'
require_relative '../lib/phase7/controller_base'
require_relative '../lib/phase7/flash'
require "byebug"


# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

class Cat
  attr_reader :name, :owner

  def self.all
    @cat ||= []
  end

  def initialize(params = {})
    params ||= {}
    @name, @owner = params["name"], params["owner"]
  end

  def save
    return false unless @name.present? && @owner.present?

    Cat.all << self
    true
  end

  def inspect
    { name: name, owner: owner }.inspect
  end
end

class CatsController < Phase7::ControllerBase
  def create
    @cat = Cat.new(params["cat"])
    if @cat.save
      flash[:errors] = ["Cat successfully created!"]
      redirect_to("/cats")
    else
      flash.now[:errors] = ["Bad cat"]
      render :new
    end
  end

  def index
    p flash
    @cats = Cat.all
    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  case [req.request_method, req.path]
  when ['GET', '/cats']
    CatsController.new(req, res, {}).index
  when ['POST', '/cats']
    CatsController.new(req, res, {}).create
  when ['GET', '/cats/new']
    CatsController.new(req, res, {}).new
  end
end

trap('INT') { server.shutdown }
server.start
