require_relative '../../app/services/parser'
require_relative '../models/page'
require 'net/http'

# main controller
class QuizController < ApplicationController
  # skip security => csrf
  skip_before_action :verify_authenticity_token

  $tasks = []
  PARS = Parser.new.parse
  API = '0d9be9744a167e20c463629ff0a34d7b'.freeze
  URI = URI('http://pushkin.rubyroidlabs.com/quiz')

  def index; end

  def task
    answer = ''
    case params[:level].to_i
    when 1
      answer = level_1(del(params[:question]))
    when 2
      answer = level_2_3_4_5(del(params[:question]).split(' '))[1]
    when 3
      begin
        questions = params[:question].split("\n")
        p questions
        questions.each do |question|
          answer += ',' if questions.index(question) != 0
          answer += level_2_3_4_5(del(question).split(' '))[1]
        end
      rescue TypeError
        answer = ','
      end
    when 4 # not correct, repeat code
      begin
        questions = params[:question].split("\n")
        questions.each do |question|
          answer += ',' if questions.index(question) != 0
          answer += level_2_3_4_5(del(question).split(' '))[1]
        end
      rescue TypeError
        answer = ','
      end
    when 5
      array = level_2_3_4_5(del(params[:question]).split(' '))
      answer = array[1] + ',' + array[0]
    when 6
      answer = level_6_7(params[:question].chars.sort)
    when 7
      answer = level_6_7(params[:question].chars.sort)
    when 8
      answer = level_8(params[:question])
    else
      # out if request failed
      render json: 'error'
    end
    if answer
      parameters = {
        answer: answer,
        token: API,
        task_id: params[:id]
      }
      Net::HTTP.post_form(URI, parameters)
      task = Page.new params[:question], params[:id], params[:level], answer
      $tasks << task
      render json: 'ok'
    else
      render json: 'error'
    end
  end

  private

  def level_1(question)
    PARS.each { |poem| poem[1].each { |l| return poem[0] if del(l) == question } }
  end

  def level_2_3_4_5(question)
    _index = 0
    PARS.each do |poem|
      poem[1].each do |line|
        check = []
        line = del(line).split(' ')
        line.each_with_index do |value, index|
          if value == question[index]
            check.push(true)
          else
            _index = index
          end
        end
        return [question[_index], line[_index]] if check.count + 1 == question.count
      end
    end
  end

  def level_6_7(question)
    PARS.each { |p| p[1].each { |l| return l if del(l).chars.sort == question } }
  end

  def level_8(question)
    PARS.each do |p|
      p[1].each do |l|
        next unless del(l).chars.size == question.chars.size
        diff = question
        del(l).chars.each do |value|
          diff = minus(diff, value)
          return l if diff.size == 1
        end
      end
    end
  end

  # for string methods
  def del(str)
    str.gsub(/[,?.!:+-=*_@#()^;№'<>~`«»—]/, '')
  end

  def minus(st, cr)
    char_arr = st.chars
    char_arr.map do |v|
      next unless v == cr
      index = char_arr.index(cr)
      char_arr.delete_at(index)
      cr = nil
    end
    array_to_string(char_arr)
  end

  def array_to_string(array)
    result = ''
    array.each do |value|
      result += value
    end
    result
  end
end
