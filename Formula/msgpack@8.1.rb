# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT81 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://github.com/msgpack/msgpack-php/archive/831b665e05007a820e841ba585e250d639986328.tar.gz"
  sha256 "4d20d70321eacf43634dea5103f1dc81820d6965a50ff8cfc6aff17df0fbea73"
  version "2.1.2"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "39f2d3f3f4d74faa6b7793c5149b77087ba853d7dee5a17564b83849887f1133"
    sha256 cellar: :any_skip_relocation, big_sur:       "b0279c152bf2abe9286ba25552b2a1799a6bde4bd9e7613818d2b873df3143a5"
    sha256 cellar: :any_skip_relocation, catalina:      "aafc6eaaa4f2707fe17ef48b06ae0a9a1f533fe3edc989f4dc98c686ff32624a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1bd91cdcd8af9856df3c9848416071fcf0adee95721e065aab0dcfcf5129efca"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
