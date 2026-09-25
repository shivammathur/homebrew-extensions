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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f712d9ef7c69caf3a8c17f5d2769e746958b9409dbb1a63635325263a1967f4e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e75cc46da913e285b66625a617b8b65ea515f409aae981894d1f51a931872d02"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "d78864d145c3c8a6d4036bb13116e14e72f55c7685ac5a01bfdc3ec072f5cbb8"
    sha256 cellar: :any,                 arm64_linux:       "8f3031ca5143c91e220e8afaf80779b73b80f48af3df53c7a703c3b4388e7578"
    sha256 cellar: :any,                 x86_64_linux:      "c2e28463d0b9061bb13b38b2554607c811999773119b14f8032563f05f631ed0"
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
