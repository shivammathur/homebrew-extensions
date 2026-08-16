# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT86 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fcba14dec73141edf47c32979724f15cf639b3fa1c1479742d444284ac16385a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c534dd333181c09ee90b41e17375ab8e9bdd7966385e47d57f21a0993d6e7e51"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "567d033fccbcbd508cd2b04e4c0df8c2d7e7ff7ae0b11175397f00a056d59c70"
    sha256 cellar: :any_skip_relocation, sonoma:        "2502280d64f06ca1b09a86bea94c3f7e83e4c7f2700fe8dce13a77edc4e255db"
    sha256 cellar: :any,                 arm64_linux:   "edc6c398d0765fd6321472202cc3b8ba1ad29c0b8d64b995946454e1059fe142"
    sha256 cellar: :any,                 x86_64_linux:  "feae09d90895ecb30d9ec0dac087e7e8923b179925b96103182250c533214c38"
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
