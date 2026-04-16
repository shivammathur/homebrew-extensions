# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT74 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "0589cfdd8a7974f07cf44b145e475a2f60488d870d550ef8260686e510683913"
    sha256 cellar: :any,                 arm64_sequoia: "82f43b35a2108085658236c1da27a4dc91df060e63a734a409d9ff80b6e0cda4"
    sha256 cellar: :any,                 arm64_sonoma:  "54ae0e1d000fa56f276a33ea3f56afd6ff477d6595532625c7a7fb34e3f5f109"
    sha256 cellar: :any,                 sonoma:        "8bce27d29db1de2cfc2ea83ef984475cb21a91ff2be1e993c5c0432930d4ede9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "26cb008dad9a6f62af44374b1b1e79baeb85d6932317802978a114ee67741f45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0171fb91deb47249369405cbf2189f1f7ae055e003b0346b488a23543d6bc751"
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
