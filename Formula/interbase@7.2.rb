# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT72 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "f3ef1164188c874b52ccfa7f64a1552691d0db0673d3ade2002a54db6dcf57e0"
    sha256 cellar: :any, arm64_sequoia: "b939bde1c434b9b92f2b45d0a7fd7ddb6c140eeec6f1e05322f4fd994b3f22dd"
    sha256 cellar: :any, arm64_sonoma:  "2025df28ba19b84ae70615dc8f2c4df56a8b6a6a3797c32a79c6d8f6834ebf86"
    sha256 cellar: :any, sonoma:        "5609d735bea1a06aabb2e634c0e4caf585eecdfe11c53511d66bf9929d97dea2"
    sha256 cellar: :any, arm64_linux:   "71b095bdc71e982492855eb32e113b93421e0cc051a084ec2b0a3b9a12ed966f"
    sha256 cellar: :any, x86_64_linux:  "6c15c84770f60573d2492eadf082327f5f9245270150ce0ce1ca4f7568c1ef5c"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/580ff94139aa2f0383dae4da1d40fcf726b27a31.tar.gz"
  version "7.2.34"
  sha256 "cbf4d0b35b53b32b303b7e7ec171acc097094534b1e068b2c66abfce6008c4c0"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
