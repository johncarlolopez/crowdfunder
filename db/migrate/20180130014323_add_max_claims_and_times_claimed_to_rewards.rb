class AddMaxClaimsAndTimesClaimedToRewards < ActiveRecord::Migration[5.1]
  def up
    change_table :rewards do |t|
      t.integer :max_claims
      t.integer :total_claims, :default => 0
    end
  end

  def down
    change_table :rewards do |t|
      t.remove :max_claims, :total_claims
    end
  end
end
