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
  revision 1
  compatibility_version 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "539395b66c05c449fbf82098095afd0ef68b41337482c95f99915fd7601db852"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "603c510eac67083c0e4726f36f4bd6502e8b0b887c13a3892d72e692ce049a4f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "8931536196cf7e614909c88bf38e53bb7c896e35175c9daf994eabefc8783c74"
    sha256 cellar: :any,                 arm64_linux:       "9a085432d1ae4c4c9064eebdee0748bdda3de99371f0cc5d1b504d9af9c25c95"
    sha256 cellar: :any,                 x86_64_linux:      "958277b455cf83551c608637d8d3f4f7022611098cced1b9d69087e004597d38"
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
