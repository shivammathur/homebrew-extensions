# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT82 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c83632411c7700e1116dba304737858e2760cef150d95cd7977d5eb119ea3f4a"
    sha256 cellar: :any_skip_relocation, big_sur:       "7efb9777718f0938ea3d6df7dae17da4491ce99db325ddc00edffa1816ab0b2d"
    sha256 cellar: :any_skip_relocation, catalina:      "5f15e6ddc5b3c654b50474acdd40bce5b0d3515d69ba32bd41842be3361e49ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "16fbf2c579c9a1decf823ea065b3b1e03e1507a337402b6af22aeefd4e55a7fd"
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
