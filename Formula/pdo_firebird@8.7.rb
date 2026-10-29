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
    rebuild 6
    sha256 cellar: :any, arm64_golden_gate: "4d913a50b1c37180f6c6a506261cc7d2ace1bf15577042b07b6c6f244affd596"
    sha256 cellar: :any, arm64_tahoe:       "c3a2afd4e5c7d51982690c43992d89daf80fe12cebb01ff8be2ca2bfe4e50703"
    sha256 cellar: :any, arm64_sequoia:     "f6320b563d3a5267d4979aa9f26cab88d0ce4b4a6f7e05e0dc067b695e70d7f5"
    sha256 cellar: :any, arm64_linux:       "0340d641078cbd49235909bc7e35a4dccd5a8aacca038d2c832028e4135e376c"
    sha256 cellar: :any, x86_64_linux:      "5e553bb5dbdefd18ba936832df64a592832a41e55c96d86e0d6d45d16a8a6ec2"
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
