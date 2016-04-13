module Doodle
  module KeywordsHelper
    module_function

    def stub_action(keyword)
      {
        name: keyword.name,
        products: { imap: true, pop: true, smtp: false },
        options:  { postal: '89% Utilizado', domain: 'Locaweb MX', anti_spam: 'ativo' }
      }
    end
  end
end
