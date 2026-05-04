# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT84 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "610ca2564fb495300b00ff02556aec437ac6d4d9db703931e99ed092eb68ffa1"
    sha256 cellar: :any,                 arm64_sequoia: "eeb42da2dcdf640b813ee982631995166b905b448558f0e455fd57643c81b3b8"
    sha256 cellar: :any,                 arm64_sonoma:  "78b14668dbf73d8879d02250b51626f66ee4a79bd52891f631e030ec7839d11d"
    sha256 cellar: :any,                 sonoma:        "868477e15bf797733c3aedeefe802f2f24550153305e9e9313af26bfbae96f05"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "73524cfe3f314512a3489dd34b3fa5943345c2b7b3da3143b0706249c527ef21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "52af4a5649197f8edfae36a041b25a2dc450b0907854d30f70d8c30adf6fa5fd"
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
