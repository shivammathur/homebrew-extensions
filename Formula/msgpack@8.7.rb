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
