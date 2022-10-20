# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2a570e3a86e70e2bea5f91729376776ccbb6cfd85da07c4a14366984e0199704"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0d2eb175a274c1cfbc28bc638ca5df1fc2e221d4ea70a7e85102cd5ccce3f00c"
    sha256 cellar: :any_skip_relocation, monterey:       "14af2a9999e1bf1da67fc9480278ac2bf1ae7d8b4fecbb4643931e02f2b3c6b5"
    sha256 cellar: :any_skip_relocation, big_sur:        "9eda56ed7335858f703cff921e7b61384600a214214b8cc8a6d869b06166d6a4"
    sha256 cellar: :any_skip_relocation, catalina:       "601ea4d46f723eafc36aa798da2a5908fa59d15cd1522d419c82981d34e7419b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8d0fc70f52a7d181954fb764a72b30797b559b71c8bbec3a7fcbdf67105e16df"
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
