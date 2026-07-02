# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7c9fcfd7d8cfc5b9c2bb535ca8a1c268505bd370.tar.gz?commit=7c9fcfd7d8cfc5b9c2bb535ca8a1c268505bd370"
  version "8.6.0"
  sha256 "0416a6965f4939572e56e3d2a3365e59142216ed2e04043e45840d8171a8f645"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any, arm64_tahoe:   "e38bd2623c1ac6374fc9378a7ab13c400e307023d4b707d3ec2d3f43ee2481ee"
    sha256 cellar: :any, arm64_sequoia: "9f1b0e1e06a2cdb756a3e0ecce17c9e313744f779e01b22440e78c4fb7674514"
    sha256 cellar: :any, arm64_sonoma:  "94faa5638d6fce0479b5b961b9ce3710879d06a38f6425d288fdee88041ac7a8"
    sha256 cellar: :any, sonoma:        "d905b7cc145dece1a6000b9cda6d45c6e59ebcc1edc39578d3fea28ebadd18ff"
    sha256 cellar: :any, arm64_linux:   "a8dde332da168121b900f2d23a8c3da2d80c60b7426d669f53156239f258b29e"
    sha256 cellar: :any, x86_64_linux:  "9059d01ad99eca4bbea3d4c94a6b8ed16d2dc1f09c7c9b6bec5f8f34a45a7689"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
