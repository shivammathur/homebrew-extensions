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
  revision 3
  compatibility_version 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "119b8ed60e55890eac4510f4361318f0b0d0d1f33fb8bc9e6100315491dec9f3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "c3c766eb582cf8114eff21572cf861e6e165ae3caa4b49994b67b0a22aa62111"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "88b85f853083a07b97b7b227e3c85bb64d7ab218aa05e4736000c62f35ef36af"
    sha256 cellar: :any,                 arm64_linux:       "13ac3ce97ccdf2a7b44aaab27c2278941fff875c3b9e9e0acc115c8a6e17159c"
    sha256 cellar: :any,                 x86_64_linux:      "c2dfdf076fe314cbce25daeb664e991fc6c449617d6dd966a6458b680974e822"
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
