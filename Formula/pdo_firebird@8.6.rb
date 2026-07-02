# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7c9fcfd7d8cfc5b9c2bb535ca8a1c268505bd370.tar.gz?commit=7c9fcfd7d8cfc5b9c2bb535ca8a1c268505bd370"
  version "8.6.0"
  sha256 "0416a6965f4939572e56e3d2a3365e59142216ed2e04043e45840d8171a8f645"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any, arm64_tahoe:   "c3f346da34d97b1404dee26e6eb44c2bd7edf080fbe1e199b65d3adcc143bc38"
    sha256 cellar: :any, arm64_sequoia: "5eddd80354af8936babbcf0216a11269f7a2da1259fe397cefc61af7aa4093e5"
    sha256 cellar: :any, arm64_sonoma:  "de4d850494488679ee2cc7266f33d898b81d7e80774433350616c62bc3fd7165"
    sha256 cellar: :any, sonoma:        "a8de6151b4985e535140763e0a43bf34bfbee476780a1d90a55d68c594ffb32f"
    sha256 cellar: :any, arm64_linux:   "b5fa4304b7cef55ecc25273e2e55865859b818497bb1caa3b477ec3996c5273a"
    sha256 cellar: :any, x86_64_linux:  "bbd6c7d42c04e22162600fc09b509eb0d29e6b97c034360383603f21edc1caea"
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
