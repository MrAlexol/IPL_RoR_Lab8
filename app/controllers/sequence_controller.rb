# frozen_string_literal: true

# Контроллер для последовательности
class SequenceController < ApplicationController
  def input; end

  def view
      @input = params[:values]&.split&.map { |el| Integer el }
      @error = 'Последовательность короче 10 чисел' if @input.length < 10
      find_increasing_subseq
    rescue ArgumentError
      @error = 'Некорректный ввод'
    rescue NoMethodError
      @error = 'Последовательность не задана'
  end

  private

  def find_increasing_subseq
    @result = @input.each_with_object([[]]) do |el, acc|
      acc << [] if el <=> acc[-1][-1] && el < acc[-1][-1]
      acc[-1] << el
    end
  end
end
