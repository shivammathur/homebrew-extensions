# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT74 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/196d6a472da2fca7b2249335c60b6fd60bf3c98c.tar.gz"
  version "7.4.33"
  sha256 "30f4aa482e34bb2631a66450943256b220e8c13908940bd5c5d78fe743b3e5bd"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "f9bdbe70ffc1f208036a529c1710ef9ec594551bc47661563821f4fc84d1ca00"
    sha256 cellar: :any,                 arm64_sequoia: "a4f6235837551d127e5cddf1db31506504afa0c18317ddd4e52d9abe2b82ae3b"
    sha256 cellar: :any,                 arm64_sonoma:  "9c476aefc09e0d7b59ea155545c6135c9df76af4b7a85033b09b36f4fa1bd35f"
    sha256 cellar: :any,                 sonoma:        "2e50210ea08a1f55ad3023e22213d2546c739be1dc5718907ef255fbe10c63d9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fa54f4da0e2743740d35833ff3872d0f5f4f153dd6805c77b35b8a57b1bcc933"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c653c770d49da1f0d1397e207ad0f47f82f3b0cb8afc47f5b3f601a672211a85"
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
