# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT56 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/2.0.8.tar.gz"
  sha256 "96d2ff56db2b307b03f848028decb780cb2ae7c75fa922871f5f3063c7a66cb2"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "81b6fbd0f95085fb4be768caa5ba5c32192458513630fd23f68e72e886d05f1b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3b8f961fadb5d33c26c6fcdaae24184596bb627b2307c8e434aea3372dd638cf"
    sha256 cellar: :any_skip_relocation, monterey:       "7ecee5e58593cfa4f80ce315b690c291e5d1aedc4e508e55df36478acccd92c5"
    sha256 cellar: :any_skip_relocation, big_sur:        "01192b714e6c3f33338ce5cd2f26a60f523582895cd39476be6617424e125fcd"
    sha256 cellar: :any_skip_relocation, catalina:       "d2ad332ceb86b2242d57a69a35bd62f51458f7618a08951780b67659d3fb558d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e3f2f5bf83a7c4b89bda94d960c83e2f5cfbcb77c891884503b0d2c24a85957f"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php5"
    add_include_files
  end
end
