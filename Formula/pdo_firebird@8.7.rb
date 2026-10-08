# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/60702faf6af0b0f93fc1f2cc27318acf8b359f7d.tar.gz?commit=60702faf6af0b0f93fc1f2cc27318acf8b359f7d"
  version "8.7.0"
  sha256 "45067d857d688b1e7abd91619221cf067ae4987d12c878454157739c39fa088d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "1b405d8045b7d63908e6ecbfa74c0ecd3299d1f073c86b7ce878b938483627ae"
    sha256 cellar: :any, arm64_tahoe:       "dfc21bacd6cc280391f2ab95a7c42ac2998e5e036fc6c49d27e29e77f04ff70d"
    sha256 cellar: :any, arm64_sequoia:     "0c41e02a8ece145746ca6f8f0660558f83052cf0c1bf0bda89e523fdd6981fbb"
    sha256 cellar: :any, arm64_linux:       "f7fc97db6a4e7c69fe72b1837cf473d383406ef1b2af216b48923110dedb0c62"
    sha256 cellar: :any, x86_64_linux:      "52afcaf43896358b64bea53aea702248887e3f14142ba93bc13d0e05fb970289"
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
