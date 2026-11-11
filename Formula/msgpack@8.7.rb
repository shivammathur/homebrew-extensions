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
  revision 2
  compatibility_version 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "88272be0f278ce89e6830423d95af537e261722672f9e5ea3cdf8b6ad81b158f"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5c06df37cae4eab8b2d46af9d0c9f07e2c3bb8f366abf0b010119ff815b5e7ab"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "1ed448e7cb92c317badf1b6676851a0c8a59e57b72a3f1792f02902933cbeaf5"
    sha256 cellar: :any,                 arm64_linux:       "ddd1afe0334398c4e237bf6e818903dd5c52e1e555dc742f07c5b16f20618612"
    sha256 cellar: :any,                 x86_64_linux:      "dc6fa82c992fb10a5c7ce471b01da85200bc53bce7c1e443be08419f9cfc3487"
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
