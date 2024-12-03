# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT80 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ab6e835dea0b1f475d4325855c171ef7a95b6cf5a075669660c612b8e658d02a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c4e08fe52b2d8de351191d9d45edc16ac504f0117835e46be4eea47fbb3a445e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "81334be53b6eb9384090cd59f00b0fcce5e7732ef94875010ab36c89d0db4bd8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6f226cf77eea8742b40776af5ac1898fc03823902e5d9227aa7206238670371d"
    sha256 cellar: :any_skip_relocation, ventura:        "fb03623c5eeb8ca9c764c1277e5ceaee8b132f85507421eae65149e58c991b28"
    sha256 cellar: :any_skip_relocation, monterey:       "5a2921929012e2d538401a3e2a79f6d15c486abe3d2b708e2ec779757a8c1e4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9051b73e73f73def1a06703f7695a4ddc55a89a51309bf427301eb43c1e5499d"
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
