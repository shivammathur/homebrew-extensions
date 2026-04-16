# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT80 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2c49e2a4edf3daa7c2f52185f0322b082d02a95f5643c7a39aa6452ebada2235"
    sha256 cellar: :any,                 arm64_sequoia: "4bebbaa7ec9d9b53fa501fb5a7f563c6982a06a9eb594303c57c67039f3af64a"
    sha256 cellar: :any,                 arm64_sonoma:  "0e9016ef7616dbf16644e359a9a2d203b31774920875354e24cc8454b7d9c01d"
    sha256 cellar: :any,                 sonoma:        "4fa59f3d5e9656dcf67d02bf3b45cf2164a27225909251d1e5f1905169959093"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ec1a450609a53ba220ecfd33be03e1885495ea2aad8eacd1d4ad4094694c0019"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8b6bec49c0846bfcc792ea623e688768174e542d473acd83571a3ef62523f625"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/FirebirdSQL/php-firebird"
  url "https://github.com/FirebirdSQL/php-firebird/archive/refs/tags/v3.0.1.tar.gz"
  sha256 "019300f18b118cca7da01c72ac167f2a5d6c3f93702168da3902071bde2238f9"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client"

  def install
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
