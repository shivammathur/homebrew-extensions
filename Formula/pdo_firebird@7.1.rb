# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT71 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4cd450adf633ff3b756586f5ce8fb31a7c7f8359.tar.gz"
  version "7.1.33"
  sha256 "632a98f29d7e023b0dc4d3ae9680877f8f7aafed162345ca3318f5e9d1f87db7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "4329d055f842cf4fe08a6ef03d62ad3e074a9c77357e39c3fae5606d29ace79d"
    sha256 cellar: :any,                 arm64_sequoia: "4a9abd7ec946c39cb5ca48d254ff7929fa7ca8a455259e29801850003c785d69"
    sha256 cellar: :any,                 arm64_sonoma:  "1c942cfc398dd19ef2a6eb53c3bb9396a13039a7c7b443663a586f0865082f06"
    sha256 cellar: :any,                 sonoma:        "84aec152d7702d11760d2d086c0ab86cdff5e0f081891df429069e8bea1200cf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "68b80dae7cb0200899cbfb00c010eb4ab9b2801da0bb094b96b5b9a542efbfa8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "baae5d85e1a823c4b7f887aba2a3f077759f5d87f932ca64906c1797937fda4b"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
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
