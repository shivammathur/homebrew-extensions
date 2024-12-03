# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT73 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6cf4bab4bf80cfcc55fb366cde7ba65c942e7b16fb030ddc0f490f0dc9060bfa"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4c590f0de0eccd95e4a9f93a2f658f1f53703e8461cff6cee1714689fbc24511"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "df44106021bce21e9e9bdd49f1a191529a6503a5fc89df5b33c816a715dc5493"
    sha256 cellar: :any_skip_relocation, ventura:       "eb9172b6a4fa5aaa3d022052231057949ed7ad314ce5ff42897594f1303c9fda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0310a72982b094d36a710d45d0d25d377311db56be3b03878b345fbe1f0c977e"
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
