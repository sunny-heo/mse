defmodule Mse.Web.ExAdmin.Card do
  use ExAdmin.Register

  alias MseWeb.Presenters.Manacost
  alias MseWeb.Admin.Helpers

  register_resource DB.Models.Card do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    scope :all, default: true
    scope :no_mtgio_data, &where(&1, [c], is_nil(c.mtgio_data))
    scope :no_gatherer_data, &where(&1, [c], is_nil(c.gatherer_data))

    query do
      %{
        index: [preload: [:single]],
        show: [preload: [:set, :single]]
      }
    end

    index do
      column :name, link: true
      column :manacost, fn(card) ->
        Manacost.present(card.single.manacost) |> Enum.map(&raw/1)
      end
    end

    show card do
      attributes_table "Card" do
        row :name
        row :mkm_id
        row :mtgio_id
        row :set, link: true
        row :single, link: true
      end

      attributes_table "Magic Card Market" do
        row :mkm_id
        row :mkm_price_trend
        row :mkm_basic_updated_at
        row :mkm_detailed_updated_at
      end

      attributes_table "Single" do
        row :name, &(&1.single.name)
        row :type, &(&1.single.type)
        row :manacost, fn(card) ->
          Manacost.present(card.single.manacost) |> Enum.map(&raw/1)
        end
        row :ability, &(&1.single.ability)
        row :color, &(&1.single.color)
        row :power, &(&1.single.power)
        row :toughness, &(&1.single.toughness)
      end
    end

    sidebar "", only: :show do
      Phoenix.View.render Mse.Web.AdminView, "card_image.html", image: resource.image_url
    end
  end
end