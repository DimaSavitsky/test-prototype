module OccupationsHelper

  def occupation_ability_row(user_abilities, ability)

    user_ability = @user_abilities.find {|link| link.internal_ability_id == ability.internal_ability.id }.try(:level)
    ability_diff = user_ability && (user_ability - ability.data_value)

    row_class = ability_diff && case
                                when ability_diff > 0 then 'table-success'
                                when ability_diff < 0 then 'table-danger'
                                else nil
                                end

    render partial: 'occupation_ability_row', locals: {
      user_ability: user_ability,
      ability_diff: ability_diff,
      row_class: row_class,
      ability: ability
    }
  end

end
