# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d9bbfeafcec90287f72bfbe6432b5887f669a2524433727d7cb095757fbe8851"
    sha256 cellar: :any,                 arm64_sequoia: "16f069a44b4498f3bdb2b434fd4c7b3b3c464104d30c2d2e3857b6f4df4d87f8"
    sha256 cellar: :any,                 arm64_sonoma:  "cd20525a534cbc10c1193d0d18538c9aaa32437998fc8de21cc95c743aee74c4"
    sha256 cellar: :any,                 sonoma:        "488e262c7a9ddc1d8d30024673a29254e416941f1ae74976f902248a3d765d06"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "20a892ab00bdc4dae60133afde6cd48c339a694f59fa86fe7db87a6045e079fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "169e7d30d7277d48ea517139033de458eddc31a9d07256b1f16960f8e032cc5a"
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
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
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
