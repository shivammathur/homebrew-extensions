# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT87 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.1.tgz"
  sha256 "e30be355ab79aaea4568692fbd6073fd7c7f50ea8d3cf12edce40fc0c921d868"
  compatibility_version 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b47a721a1ddc57ec2c1eb1bb9b7b1981b1829589d454fac734ddf49e53a802b4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "b7df2bb416af8b15b5d2b8b1c0baecdb82e1c437812aef232554ee501806cc79"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "caa11474a5c6b4492432017536fb9755a4f5d847039ad6b094b1b45edee9b2f0"
    sha256 cellar: :any,                 arm64_linux:       "672c3887bf39d7411fcf70dc2e207dee672aa7db3a231e228eabe8fcbadeb608"
    sha256 cellar: :any,                 x86_64_linux:      "4e5de005a737658f4132eb04a4c5b526df246ef96b5b8d8ee868fb8582a9e272"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    inreplace "msgpack_unpack.c" do |s|
      s.gsub! "(PG(unserialize_callback_func) == NULL) ||\n            " \
              "(PG(unserialize_callback_func)[0] == '\\0')",
              "PG(unserialize_callback_func) == NULL"
      s.gsub! "ZVAL_STRING(&user_func, PG(unserialize_callback_func))",
              "ZVAL_STR_COPY(&user_func, PG(unserialize_callback_func))"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
