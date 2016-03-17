# hi.rb
require 'sinatra'
require 'digest'
require 'json'
require 'open-uri'

get '/' do
  "Hello World!"
end

get '/hello/:name' do
  "Hello #{params['name']}!"
end

post '/validarFirma' do
	
	mensaje = params['mensaje']
	hash = params['hash']
	if not params['hash'] or not params['mensaje']
		return status 400
	end
	
	begin
		status 200
		if ((Digest::SHA256.hexdigest mensaje).downcase).eql? hash.downcase
			respuesta = {:valido => true, :mensaje => mensaje}
			return JSON.pretty_generate(respuesta)
		else
			respuesta = {:valido => false, :mensaje => mensaje}
			return JSON.pretty_generate(respuesta)
		end
	rescue
		return status 500
	end
end

get '/status' do
	return status 201
end

get '/texto' do
	begin
		result = open('https://s3.amazonaws.com/files.principal/texto.txt').read
		respuesta = {:text => result, :hash => (Digest::SHA256.hexdigest result).downcase}
		return respuesta
		return JSON.pretty_generate(respuesta)
	rescue
		return status 500
	end
end


