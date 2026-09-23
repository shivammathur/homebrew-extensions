# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT87 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/FirebirdSQL/php-firebird"
  url "https://github.com/FirebirdSQL/php-firebird/archive/refs/tags/5.0.2.tar.gz"
  sha256 "ca07a144d0ccb8f1a2773ad667de96c15882d42e4139397a028278112805fc00"
  license "PHP-3.01"

  livecheck do
    url "https://github.com/FirebirdSQL/php-firebird/tags"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    inreplace "ibase_query.c",
      "case SQL_TIMESTAMP_TZ:\n\t\t\tchar timeZoneBuffer[40] = {0};",
      "case SQL_TIMESTAMP_TZ: {\n\t\t\tchar timeZoneBuffer[40] = {0};"
    inreplace "ibase_query.c",
      "\t\t\tbreak;\n#endif\n\t\tcase SQL_DATE:",
      "\t\t\tbreak;\n\t\t}\n#endif\n\t\tcase SQL_DATE:"
    inreplace "ibase_events.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    inreplace "ibase_blobs.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    inreplace %w[interbase.c ibase_query.c], "INI_STR(", "zend_ini_string_literal("
    inreplace %w[interbase.c ibase_query.c], "INI_INT(", "zend_ini_long_literal("
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
