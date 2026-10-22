# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT80 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5f8af80e6bdfe5d80880abccc4e7cb415c26ca42.tar.gz"
  version "8.0.30"
  sha256 "75a276a0a65cb6ad4dfab2db6fa0719601b593bfa99fd1936105952465e4e111"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "b4593c24bc9596578c0cad36b55173200341005b6e3d1875a82b3fd902d39eab"
    sha256 cellar: :any, arm64_tahoe:       "aedb8fe3157507c1fca96cedc1edd28a9ade05b88d822969266ebbe56b454ade"
    sha256 cellar: :any, arm64_sequoia:     "344523404ae2c833cd08d5ab883456ef5b47d8dbc5d020241a2232a57199273f"
    sha256 cellar: :any, arm64_linux:       "8a41c470642423c03ed0dda72f9a194afe5d139bb9648f7cfdbf35256153b4f2"
    sha256 cellar: :any, x86_64_linux:      "a5ef3b58e9f0f1dfe4c096fdda4d113e6c0ce533098b0b910ee2928f8a88b2ee"
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
