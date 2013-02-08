#!/usr/bin/ruby
require 'rubygems'
require 'sinatra'
require 'haml'
require 'popen4'
require 'mcollective'
require File.dirname(__FILE__) + '/init'

include MCollective::RPC

# Defined so it's easy to change later.

enable :sessions

get '/' do
    @user = env['HTTP_REMOTE_USER']
    haml :deploy
end

get '/clear' do
    session.clear
    params.clear
    redirect to('/')
end

post '/' do
    @user = env['HTTP_REMOTE_USER']
    @repo = params[:repo]
    @host = params[:host]
    @taglist = session[:taglist] if session[:taglist]
    @branchlist = session[:branchlist] if session[:branchlist]
    mc = rpcclient("gitagent")
  	mc.identity_filter @host
    data = Hash.new
    if params[:tag]
        @tag = params[:tag]
        $blamelog.info("#{@user} has requested a checkout of #{@repo}:#{@tag} to #{@host}")
        mc.git_checkout(:repo => @repo, :tag => @tag).each do |out|
            data = out[:data]
        end
        predeploy = Hash.new
        predeploy["stat"] = data[:prstat]
        predeploy["script"] = data[:trub1]
        predeploy["out"] = data[:prout]
        predeploy["err"] = data[:prerr]

        deploy = Hash.new
        deploy["stat"] = data[:dstat]
        deploy["lrep"] = data[:lrep]
        deploy["lsit"] = data[:lsit]
        deploy["out"] = data[:dout]
        deploy["err"] = data[:derr]

        postdeploy = Hash.new
        postdeploy["stat"] = data[:status]
        postdeploy["script"] = data[:trub2]
        postdeploy["out"] = data[:out]
        postdeploy["err"] = data[:err]

        @output = {"predeploy" => predeploy,
                   "deploy" => deploy,
                   "postdeploy" => postdeploy}
    else
        mc.git_tag(:repo => @repo).each do |out|
            data = out[:data]
        end
        if data
            session[:taglist] = @taglist = data[:tout]
            session[:branchlist] = @branchlist = data[:bout].reject{|x| x.match(/(\*|>)/)} if data[:bout]
        else
            @taglist = false
        end
    end
    haml :deploy
end
