# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT85 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "b903f9cf84a5624ee7861d9f357588f550d8241effbc3e6cbfc0f58073fb7ea2"
    sha256 cellar: :any,                 arm64_sequoia: "10e9d2a6fd408d47eb12e63b2d5c4282b208d60dd5c0410159e543db3124c189"
    sha256 cellar: :any,                 arm64_sonoma:  "a9690c173bd9d5662d89a0bd736dc112d63f088145a3273e9d87fd8aca7e4630"
    sha256 cellar: :any,                 sonoma:        "ef2d9ba807cf6c69a83c2cb2e0d01eb231b74d5637939c6362556b501ae45777"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "04d0fbc1a808d682a20d2a1a1045f6334291d8410b824ad5863d44189b665f50"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f3a11cac5069b480e3f65d20e78d3af827e6c733cdaed6946663f132896b6a6"
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
