# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT56 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b896540a30a5d170797a1171b04dd872b88c5b.tar.gz"
  version "5.6.40"
  sha256 "8fabdeb0a133ab8ea9cb5e590030d824e7ae9ca7703c19a958c9628938d185d6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "9eab75ae51fa59c98427af003ab489ce41a12b249f8603ef7f465f9b7c82e714"
    sha256 cellar: :any, arm64_tahoe:       "3ecbf96f59abae188977cc322badbaafb5101057c91b18f206756c9645accbe1"
    sha256 cellar: :any, arm64_sequoia:     "eecfe14bf687c72affac3a0fe15e0807948d6cd463efcde7214e42aad358e9c6"
    sha256 cellar: :any, arm64_linux:       "e241174cb0ad329a2884b722acf1a954039c09b58cf56fd1e58e75c79c52ecc0"
    sha256 cellar: :any, x86_64_linux:      "3f685aa687ed50ef908a7bfc78c9de69423d83a169693a8653b8e65d2d8a5ca6"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
