module Onet
  class Occupation < Base

    self.table_name = :occupation_data
    self.primary_key = :onetsoc_code

    has_many :occupation_abilities, inverse_of: :occupation, foreign_key: self.primary_key
    has_many :task_statements, inverse_of: :occupation, foreign_key: self.primary_key

    def match_score
      self.send(self.class.match_score_alias)
    end

    def ordered_task_statements
      task_statements.sort_by(&:frequency_category).reverse
    end

    def ordered_occupation_abilities
      occupation_abilities.includes(:internal_ability).order(data_value: :desc)
    end

    class << self

      def search(search_criteria, get_top = 5)
        base_occupations = scoped_by_abilities(search_criteria)
        sum_diff_scores(base_occupations, search_criteria).order(match_score_alias).limit(get_top)
      end

      def match_score_alias
        'diff_sum'
      end

      private

      def scoped_by_abilities(criteria)
        scope = self.joins(:occupation_abilities)
        or_scopes = criteria.map do |criterium|
          scope.where abilities: { element_id: criterium[:element_id] }
        end
        or_scopes.reduce(:or)
      end

      def sum_diff_scores(scope, criteria)
        diff_sum = Arel::Nodes::Sum.new([diff_function(criteria)]).as(match_score_alias)
        scope.select(arel_table[Arel.star], diff_sum).group(:onetsoc_code)
      end

      def diff_function(criteria)
        difference =  Arel::Nodes::Subtraction.new(ability_table[:data_value], extended_case(criteria))
        Arel::Nodes::NamedFunction.new('abs', [difference])
      end

      def ability_table
        Onet::OccupationAbility.arel_table
      end

      def extended_case(criteria)
        ability_case = Arel::Nodes::Case.new(ability_table[:element_id])
        criteria.each do |criterium|
          ability_case.when( criterium[:element_id] ).then( criterium[:specific_value] )
        end
        ability_case.else(ability_table[:data_value])
      end

    end
  end
end
