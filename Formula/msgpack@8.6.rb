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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "4170bced59049cc714c6f30d35f200b48909b34155e026d70c2e1d281453fee4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "80207548d292afa1237cda21d394e361dadc9bd07c738bb0869370ea8f780206"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "13d9daec07da9d1667f684567bfbcd7057cb038f1ef749e7eaaadccad3a214d1"
    sha256 cellar: :any,                 arm64_linux:       "4476b75ee01cfdbe8c3b56f760680117eb3bb434d3906795eacbaa62d8984b62"
    sha256 cellar: :any,                 x86_64_linux:      "e50a859c133e336ff482a3742f02493b43352e78b416431128dc18aa8037d3c1"
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
