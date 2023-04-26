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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5828858d1ba6ce8cef098a77bf92b7348fd2f9a62268d083e0e626f713be46f6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "45347e09adb828af25fd7e3c8a16a14798e3ecb240a4616afcc7b552633c42f5"
    sha256 cellar: :any_skip_relocation, ventura:        "350c72bb4b2259fd4f360a69b2bacede4a9c0e9bde6e50a06b94929bd70c0b2c"
    sha256 cellar: :any_skip_relocation, monterey:       "6380a7042b6234b65ae021f86373a354b2b7a9798e0ff1ead26e34774ec8d0e6"
    sha256 cellar: :any_skip_relocation, big_sur:        "d574a8d5522cc7f3bb20889e7c000c23a61dabd078ef3f2015c6f07489cf7583"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fe944a357b13b7efae2fb07133ae99e2ccb4908537a5da2e0c4401262687d3ad"
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
