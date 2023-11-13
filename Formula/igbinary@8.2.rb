# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "42bd68a6ae73431eed8d94276a098255ac81e51dc9f8f9504afc0216ff33aba8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e17baed96d60290e8fba9563bd5b56678c4698422e811c696795fa8dbeff27c1"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6c02f782e271e0da9064a54386458af74472f25db9263b6e13ef1c79fe35d797"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "71b7b74c80f9c36ae5f375e2aecc663c1eb0a226bb903fe72728505d96179d80"
    sha256 cellar: :any_skip_relocation, ventura:        "f79b89a167c5f000b4701a1e021f6976acb60793dac2e201178b62eb905c085a"
    sha256 cellar: :any_skip_relocation, monterey:       "fe9c1b05a6863476d9ca39964dc201c6c1bc9609c27cf0399cbde36d8afedb37"
    sha256 cellar: :any_skip_relocation, big_sur:        "edce7759484fd66482f3605f794a5b094157ca40c6ddc3089c440b0711e6c63c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c3d110253944e8ca1561f29866b95aaa3df9a30d735381df5d42613982a9834d"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
