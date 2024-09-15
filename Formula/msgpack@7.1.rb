# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT71 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "da1307f8d4ea063dba549eb3add46c53681b22e163102dc1b41f59f848edb8c0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "10eabfe8ced564904d87b5541a1605450821e8a12fd068b5cbfdbe1e61a8e7c3"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2eb36515e775920df9bbbba768abb28d476977142e9ed76cd938c30612fc5d09"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "664f362355e76411d182d51dae5905b9d64974c8aa40553ed1b906a241a3ce07"
    sha256 cellar: :any_skip_relocation, ventura:        "815e60ca4328ba8182a2d955e0cf4141385f9a3609ce38e28904c6e8daba9a16"
    sha256 cellar: :any_skip_relocation, monterey:       "9ad205dbfbe80504e8e0efe052ab99e3fd952dcbe2f08a59d0b1b59aa28a4d5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d79840912444496a1a7543f2267d6e961621641b35d8a5d5db0b5a0987f100c2"
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
