# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/425cd3d6a15bb5fec5724a9f89130029bdd9aa4f.tar.gz?commit=425cd3d6a15bb5fec5724a9f89130029bdd9aa4f"
  version "8.6.0"
  sha256 "7508c63502fc115f01eb7a38dfed120e0bd504c1dc9da0992bced1b218b49ecc"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_tahoe:   "8c2048f6740fc78e6881c30f2e1640b0a325be60e9d6489d93f3dc3010ea3064"
    sha256 cellar: :any, arm64_sequoia: "0724e0fbecb3310be238c4bd33ae70b1dd5617a7b4ba7cca1220eb127133f215"
    sha256 cellar: :any, arm64_sonoma:  "8e78d8a12774a1d97c8181ed39b797824be5767695addabe23b066aef353cd9e"
    sha256 cellar: :any, sonoma:        "7a4b452af4b907d41b3536cd78f0fff5edcf3d267123f1565d6097140a9c8d3a"
    sha256 cellar: :any, arm64_linux:   "22cff1c36f859f8f6e83312bf4054bef4304920e44ad548fb9e970321629c90b"
    sha256 cellar: :any, x86_64_linux:  "d04021133070eccbb63f78b90f936016242fbbe2be3bedfb3b7d72f028d3537f"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
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
