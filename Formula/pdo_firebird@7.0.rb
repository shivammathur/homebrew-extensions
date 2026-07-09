# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT70 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/da64b9b864bf43d9023d6d1d6d5b582800d72c9e.tar.gz"
  version "7.0.33"
  sha256 "c412fdeac66cb816f3f3fa5a7a6755daf3f37521d997fca771ecd40f61b22cc3"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "9c17308e0171e20620d73a3a1914f7142b0d7f6e27471cb5f36e932c8b8eee7e"
    sha256 cellar: :any, arm64_sequoia: "3121570bb46b8b3527d1345aa916acc0ae56110e1823b38a2503a482d150774f"
    sha256 cellar: :any, arm64_sonoma:  "2a9e583e08ecf67d76fd6afc5e408336e233df869c95a5a2945758e549ca13c8"
    sha256 cellar: :any, sonoma:        "be3d030b29b6a7fced205e14974e9ebfa861ccf25f8df64121d2926bb54639ff"
    sha256 cellar: :any, arm64_linux:   "90b1cefcc4cd93ead1e341add2825663b5291cb7d096edddf0f4cd0678c70bc8"
    sha256 cellar: :any, x86_64_linux:  "e100e4bc1631fbaacbe6322d540b052ee7c5390478dab25c87653ef3bf2cb4d4"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
