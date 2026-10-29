# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/17cfa007d5daf760cbcc76916fb52d673c9e530f.tar.gz?commit=17cfa007d5daf760cbcc76916fb52d673c9e530f"
  version "8.7.0"
  sha256 "a8dac945f8cf84d8561e75febe12b583afb753f36a8c66fb665dbe8f49019d2d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "cede575284bc8555fe5aaf46c10882146bf775259155e3a40ed2a9029ca20bd5"
    sha256 cellar: :any, arm64_tahoe:       "0cf9f228eef6fb337fb8e0b6cb9d7e5cc1344d0f62575ccafd6544d412c2c6e8"
    sha256 cellar: :any, arm64_sequoia:     "9199d145a029afa145665b8e402217d7ad808aae1e9f2e706f3359ce4f794056"
    sha256 cellar: :any, arm64_linux:       "5eb4d3fd48f7a2a9470a68b7748cd85ee15da18b428c89659915ad9aeee1250e"
    sha256 cellar: :any, x86_64_linux:      "7250d420ee57becfb9458bd31c583668a88140cefcf1f2866300da90e7f6a61a"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
