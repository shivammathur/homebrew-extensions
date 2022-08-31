# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT83 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dc26a1b0c52f7abb6ad9895ec4fb995ac5bc12675bf5d2a1006bebcf3e97a00f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c52eb99f8d387b0359defe8ac33647e3f8528082b0ec42eb3ca2df5977fd7c11"
    sha256 cellar: :any_skip_relocation, monterey:       "bd99aa6883177bedac94bdc4547790431e725d3c04d1768814a6adcd90d2819b"
    sha256 cellar: :any_skip_relocation, big_sur:        "e93f9863b457271c7aeda751fb4cf518f869975ad88479996479d53ad7639c46"
    sha256 cellar: :any_skip_relocation, catalina:       "d5e062fa0e6ad995f4bd0d05c385edc2a5d62f9c7a912ff862cbbf9cef33f422"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d78fd6994528682e083fbb0bd8483edb61fcfb1e5cfcc78ca630daed3ea26017"
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
