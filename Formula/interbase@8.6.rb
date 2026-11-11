# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "4ee81de21f860ca4e781ad753c8fc6f1a9940060dfd2449b98b980dda2f36150"
    sha256 cellar: :any, arm64_tahoe:       "946957781a221582f8a5f70e85cd24a3723439ee21cfdb88c5532ef350abb477"
    sha256 cellar: :any, arm64_sequoia:     "8d5f1778581b746ced5211e809f0aa345aa2877467993b8f33f8d49fed71fe9e"
    sha256 cellar: :any, arm64_linux:       "cba750269c2be971f862bf941ae350255edef5f19aa084509d5a9cb5f22938b0"
    sha256 cellar: :any, x86_64_linux:      "d9eac5962da120d43a900a3b4a7696155542535e73d0195ce15f003a29cd5ad6"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/FirebirdSQL/php-firebird"
  url "https://github.com/FirebirdSQL/php-firebird/archive/refs/tags/5.0.2.tar.gz"
  sha256 "ca07a144d0ccb8f1a2773ad667de96c15882d42e4139397a028278112805fc00"
  revision 2
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
