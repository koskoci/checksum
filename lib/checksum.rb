require "sinatra"
require_relative "./generator"

class Checksum < Sinatra::Base
  get "/" do
    erb :checksum
  end

  post "/calculate" do
    Generator.new(params.fetch(:input_string)).generate.to_s
  end
end