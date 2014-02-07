require_relative '../lib/environment'
require_relative '../lib/crud_functions'

class Play < ActiveRecord::Base
  # attr_accessor :notes, :game_id, :errors
  attr_reader :id, :date
  # extend CrudFunctions

  # def initialize attrs = {}
  #   attrs[:game_id] = attrs[:game_id].to_i unless attrs[:game_id].nil?
  #   attrs = attrs.symbolize_keys
  #   [:id, :date, :notes, :game_id, :errors].each do |attr|
  #     self.send("#{attr}=", attrs[attr])
  #   end
  #   self.extend CrudFunctions
  #   self.create_methods
  #   self
  # end

  # def valid?
  #   @errors = []
  #   @errors << "No game provided" if @game_id.nil?
  #   @errors.empty?
  # end

  # def save
  #   if valid?
  #     if id.nil?
  #       create_record
  #       self
  #     end
  #   end
  # end

  # def create_record
  #   db = Environment.connect_to_database
  #   # db.results_as_hash = true
  #   statement = "INSERT INTO plays(game_id, notes) VALUES(#{game_id}, '#{notes}')"
  #   Environment.logger.info("Executing CREATE: " + statement)
  #   # db.execute(statement)
  #   # self.save
  #   # @id = db.last_insert_row_id
  #   self
  # end

  # private

  # def id= new_id
  #   @id = new_id
  # end

  # def date= new_date
  #   @date = new_date
  # end

end