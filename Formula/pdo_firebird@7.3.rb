# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT73 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/64ca21fc4a956b8d2c151943dc22dbedb889f01d.tar.gz"
  version "7.3.33"
  sha256 "ffe700b4ddaf86b580bd5176bdbd2bfae785b9eb6786dde06afe6ce77e665ca7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "1f034ad29868fe0e8ed4c6417b5922faa67608b8d29e5fdc5fcfc9724e106ddc"
    sha256 cellar: :any, arm64_sequoia: "68992a83d28869a1b602e6d3a37ab50e0adb2b518bea9bd770e980099cf5075b"
    sha256 cellar: :any, arm64_sonoma:  "200980a23a414d58d39622bb91116fe61939db471d53e08f5b52cb2a7f2a782f"
    sha256 cellar: :any, sonoma:        "9553f14aa3913c5f3ff82abc8ab1f5e9dce9087f1876009f228db24d17e70295"
    sha256 cellar: :any, arm64_linux:   "bfa6ab945141f68515a04447136eaee283865d5f9ac8ecdad493359c55fad06e"
    sha256 cellar: :any, x86_64_linux:  "488cf3ca7cbdd55de1062010c00b6090dcad29ab2acb0a6616da9cc21e6a6ba8"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
