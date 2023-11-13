# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT80 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3553ed422df9b4de6bd2e8d3b7d0066354da403d575bafff26845092c65fa2db"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "93cd3f2fc1191bd621426e256bad2a22febfe4b06f0800b853194f8c36fe17a2"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9f61af78b26e5402f2157f22c1a7344320072d6eea911c6d5b119bfe78a33153"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f1a54193f945a4139134a848edd324ffca081a9632db1e3e986674238e800cdd"
    sha256 cellar: :any_skip_relocation, ventura:        "54801fc29fdfc77b509f81f7ba06873f95bc6ae4fed48f30a3ae14055d5660d7"
    sha256 cellar: :any_skip_relocation, monterey:       "6a0bbc37bc99d2bac9fadee62f75c2719692380a7394cd692a5279a56a05d5a2"
    sha256 cellar: :any_skip_relocation, big_sur:        "06a53b4a63b42ba46d841855ef929b21f921baebf58f863457eb7f9803def910"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eea1f9967a519ef0016e7806427eee30bd5a0c489e1fba3f1f5198b1876f683e"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
