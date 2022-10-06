# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/Link--muted.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d8bc34d61385df358a1322219259ab31770c2e456601f7b7c408bc32745ec322"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b859a4e99424ade0b6de8d54cba934eecf3372798776d054ce65571310cb3546"
    sha256 cellar: :any_skip_relocation, monterey:       "279c7d0908d8d03ed9997a4ea30a08f019ad56907e82b8a55c1b29a8fbce53e1"
    sha256 cellar: :any_skip_relocation, big_sur:        "e5ae91a36555d0b6b519bc7db6c0b1dfa69ce5be1a387fb98d98b7a037bf41a9"
    sha256 cellar: :any_skip_relocation, catalina:       "4b320c9d69e38e5b8259c26ee19b672ded9f378742daa4e61a2cd791226f897f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c32374b4c8d4ebb37fd422d9ffdaf3ecce92ad039e271758f43cb2128ecd5e12"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
