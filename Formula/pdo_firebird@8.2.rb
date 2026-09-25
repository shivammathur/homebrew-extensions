# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT82 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.34.tar.xz"
  sha256 "5351330c54de240f54f7527c26ef292e239749e6fe11db0330acb5317e02bb39"
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.2(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "0beef5afbf832167aae1d6d128b3c448426f1c95157c29c27992c9901783bef6"
    sha256 cellar: :any, arm64_tahoe:       "2602a6432c5689f83ae8fc15ef1c4a78e9f68117fcedfb27e7f56ee0fe431bea"
    sha256 cellar: :any, arm64_sequoia:     "3915fea212236ac6d3634f8a7791ae787fafd05aea3ae5aeac2f7bc7edb87699"
    sha256 cellar: :any, arm64_linux:       "bd648067dc537c6a4d778ee66b3f54e47da43df1bbad4d10a2087d84869cfd0c"
    sha256 cellar: :any, x86_64_linux:      "3f6d5f625b9e4e8fc4985e3eb6d10357538c56720fdf3484c67143a132583a22"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
