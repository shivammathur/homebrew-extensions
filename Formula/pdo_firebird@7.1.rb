# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT71 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b170cdd5baaf5c6b1efd4e78f9a668f10acebc28.tar.gz"
  version "7.1.33"
  sha256 "0120b9ba5bd74c7fb2787142973da29dc6868941e63c34fdf3fd5ea954acb2cd"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "5b2567a3e343cfbef0dc160b228241002c7a63d8b17c6fd4b85cf232342b91eb"
    sha256 cellar: :any, arm64_tahoe:       "34fb314cfaa96d4f5ba34236496f55cbddf30508ca4267245575a7c824654116"
    sha256 cellar: :any, arm64_sequoia:     "0d48308730a068fe375331e94a3e2ce6cc459761e259995a28ec61672cc8fc79"
    sha256 cellar: :any, arm64_linux:       "b676c96f6c9642da57dc0b87870fbcd4c65acecf17d51c51eeeebd1e5066ba74"
    sha256 cellar: :any, x86_64_linux:      "d8d7433da8f950c5b0a4ca3faa58e724d860e2562f3783ca6a4ce684bba5c913"
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
