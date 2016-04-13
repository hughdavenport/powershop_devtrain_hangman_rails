module WordListHelper
  def show_pagination?
    @word_list.words.count > default_pagination_length
  end

  def pagination_page
    params.fetch(:page, 1).to_i
  end

  def pagination_max_page
    @word_list.words.count / default_pagination_length
  end

  def pagination_first_link
    link_to t("First") unless pagination_page == 1
  end

  def pagination_previous_link
    return link_to t("Previous") if pagination_page == 2
    link_to t("Previous"), { page: pagination_page - 1 } unless pagination_page == 1
  end

  def pagination_next_link
    link_to t("Next"), { page: pagination_page + 1 } unless pagination_page == pagination_max_page
  end

  def pagination_last_link
    link_to t("Last"), { page: pagination_max_page } unless pagination_page == pagination_max_page
  end

  private

  def default_pagination_length
    Word.default_pagination_length
  end
end
